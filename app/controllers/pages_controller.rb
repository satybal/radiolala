class PagesController < ApplicationController
  ALL_RADIO_STATIONS_URL = "http://all.api.radio-browser.info/json/stations".freeze
  DEFAULT_LIST = "http://all.api.radio-browser.info/json/stations/bycountry/russia".freeze

  def home
    json = JSON.parse(Net::HTTP.get_response(URI(DEFAULT_LIST)).body)
    @stations = json
  end
end
