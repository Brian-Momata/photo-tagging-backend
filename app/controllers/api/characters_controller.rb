class Api::CharactersController < ApplicationController
  CHARACTERS = {
    "Washington Carver" => { ratio: [7.75, 64.90], coords: [] },
    "Einstein" => { ratio: [13.93, 38.70], coords: [] },
    "Curie" => { ratio: [30.55, 75.59], coords: [] },
    "Newton" => { ratio: [91.84, 87.63], coords: [] },
    "Ride" => { ratio: [57.66, 34.17], coords: [] }
  }.freeze

  def index
    render json: CHARACTERS
  end
end
