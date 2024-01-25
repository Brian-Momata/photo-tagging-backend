class Api::CharactersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:tagging]

  CHARACTERS = {
    'Washington Carver' => { ratio: [7.75, 64.90], coords: [] },
    'Einstein' => { ratio: [13.93, 38.70], coords: [] },
    'Curie' => { ratio: [30.55, 75.59], coords: [] },
    'Newton' => { ratio: [91.84, 87.63], coords: [] },
    'Ride' => { ratio: [57.66, 34.17], coords: [] }
  }.freeze

  def tagging
    selected_character = params[:character]
    box_coords = params[:boxCoords]
    canvas_params = params[:canvas]
    character_coords = calculate_character_coords(canvas_params)

    selected_character_coords = character_coords[selected_character]

    if character_within_box?(selected_character_coords, box_coords)
      render json: { message: 'You found the character!' }
    else
      render json: { message: 'You need to eat more carrots' }
    end
  end

  private

  def calculate_character_coords(params)
    character_coords = {}
    canvas_width = params[:width]
    canvas_height = params[:height]

    CHARACTERS.each do |character, data|
      x_ratio, y_ratio = data[:ratio]
      x_coord = (x_ratio / 100) * canvas_width
      y_coord = (y_ratio / 100) * canvas_height

      character_coords[character] = [x_coord, y_coord]
    end
    character_coords
  end

  def character_within_box?(character_coords, box_coords)
    x_within_box = character_coords[0].between?(box_coords['x'][0], box_coords['x'][1])
    y_within_box = character_coords[1].between?(box_coords['y'][0], box_coords['y'][1])

    x_within_box && y_within_box
  end
end
