require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters.shuffle!

  end

  def score
    @letters = params[:letters].chars
    @answer = params[:game].upcase!
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    response = URI.open(url).read
    data = JSON.parse(response)
    @english_word = data['found']
    @answer = @answer.chars
    @length = @letters.length - @answer.length
    @answer.each { |letter| @letters.delete("#{letter}") if @letters.include? "#{letter}" }
    @included if @letters.length == @length
  end
end
