require 'rails_helper'

RSpec.describe 'Genre Pages (Visitor)' do
  before :each do
    @genre1 = Genre.create!(name: 'Sci-Fi')
    @genre2 = Genre.create!(name: 'Action')
    @genre3 = Genre.create!(name: 'Fantasy')

    @director1 = Director.create!(name: 'Cool Director')
    @director2 = Director.create!(name: 'The Cooler Diector')

    @movie1 = @director1.movies.create!(title: 'Star Wars', description: 'A great movie', rating: 3)
    @movie2 = @director1.movies.create!(title: 'Harry Potter', description: 'Another great movie')
    @movie3 = @director1.movies.create!(title: 'Star Trek', description: 'The coolest movie', rating: 5)

    MovieGenre.create!(movie_id: @movie1.id, genre_id: @genre1.id)
    MovieGenre.create!(movie_id: @movie1.id, genre_id: @genre2.id)
    MovieGenre.create!(movie_id: @movie2.id, genre_id: @genre3.id)
    MovieGenre.create!(movie_id: @movie3.id, genre_id: @genre1.id)
  end

  context 'Genres Index Page' do
    describe 'A visitor visits the genres index page' do
      it 'they cannot view the form to create a new genre' do
        visit genres_path

        expect(page).to_not have_content('Create a New Genre')
        expect(page).to_not have_css('#new_genre')
        expect(page).to_not have_button('Create Genre')
      end

      it 'they should see all of the genre names as links' do
        visit genres_path

        expect(page).to have_link(@genre1.name)
        expect(page).to have_link(@genre2.name)
        expect(page).to have_link(@genre3.name)
      end
    end
  end

  context 'Genre Show Page' do
    describe 'A visitor vistis the show page for a specific genre' do
      it 'they should see all movies for that genre' do
        visit genre_path(@genre1)

        expect(page).to have_content(@movie1.title)
        expect(page).to have_content(@movie3.title)
        expect(page).to_not have_content(@movie2.title)
      end

      it 'they should see the average rating for all movies in the genre' do
        visit genre_path(@genre1)

        expect(page).to have_content("Average Rating: 4")
      end

      it 'should show the name an rating of the movie with the highest rating of all movies in this genre' do
        visit genre_path(@genre1)

        expect(page).to have_content("Highest Rated Movie: #{@movie3.title}")
      end

      it 'should show the name an rating of the movie with the lowest rating of all movies in this genre' do
        visit genre_path(@genre1)

        expect(page).to have_content("Lowest Rated Movie: #{@movie1.title}")
      end
    end
  end
end
