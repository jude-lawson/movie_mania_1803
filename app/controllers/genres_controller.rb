class GenresController < ApplicationController
  def index
    @genres = Genre.all
    @new_genre = Genre.new
  end

  # def create
  #   Genre.create!(genre_params)
  #   redirect_to genres_path
  # end

  def show
    @genre = Genre.find(params[:id])
    @genre_movies = @genre.movies
  end

  # private

  # def genre_params
  #   params.require(:genre).permit(:name)
  # end
end
