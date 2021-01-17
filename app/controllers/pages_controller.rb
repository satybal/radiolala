class PagesController < ApplicationController
  ALL_RADIO_STATIONS_URL = "http://all.api.radio-browser.info/json/stations".freeze
  DEFAULT_LIST = "http://all.api.radio-browser.info/json/stations/bycountry/russia".freeze

  def index
    searched_stations  = unique_stations(JSON.parse(Net::HTTP.get_response(URI(DEFAULT_LIST)).body))

    @total   = searched_stations.size
    @page    = params[:page]&.to_i || 1
    @stations = searched_stations.drop((@page - 1) * 8).take(8)
    @stations.map { |s| s["favicon"] = defalt_image if s["favicon"].empty? }
  end

  private

  def defalt_image
    "https://w7.pngwing.com/pngs/353/939/png-transparent-sound-logo-acoustic-wave-wave-angle-text-logo.png"
  end

  def unique_stations(stations)
    urls = stations.map { |s| s["url"] }.uniq
    output = []
    urls.each { |url| output << stations.find { |s| s["url"] == url } }
    output
  end
end
