class GenresController < ApplicationController
  def index
    @genres = Genre.all
    @new_genre = Genre.new
  end
end
