# frozen_string_literal: true

require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    word = params[:word].upcase
    word_array = word.split('')
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response_hash = JSON.parse(open(url).read)
    letters_array = params[:tags_list].split(',')
    @response = if word_array.all? { |letter| letters_array.include?(letter) }
                  if response_hash["found"] == true
                    "<Congragulatio></Congragulatio>ns! #{word} is a valid English word!"
                  else
                    "Sorry but #{word} does not seem to be a valid English word.."
                  end
                else
                  "Sorry but #{word} can't be built out of #{letters_array}"
                end
  end
end
