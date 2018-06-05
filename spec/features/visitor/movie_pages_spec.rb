require 'rails_helper'

RSpec.describe 'Movie Pages (Visitor)' do
  before :each do
    @genre1 = Genre.create!(name: 'Sci-Fi')
    @genre2 = Genre.create!(name: 'Action')
    @genre3 = Genre.create!(name: 'Fantasy')

    @director1 = Director.create!(name: 'Cool Director')
    @director2 = Director.create!(name: 'The Cooler Diector')

    @movie1 = @director1.movies.create!(title: 'star', description: 'A great movie')
    @movie2 = @director1.movies.create!(title: 'Harry Potter', description: 'Another great movie')
    @movie3 = @director1.movies.create!(title: 'Star Trek', description: 'The coolest movie', rating: 5)

    MovieGenre.create!(movie_id: @movie1.id, genre_id: @genre1.id)
    MovieGenre.create!(movie_id: @movie1.id, genre_id: @genre2.id)
    MovieGenre.create!(movie_id: @movie2.id, genre_id: @genre3.id)
    MovieGenre.create!(movie_id: @movie3.id, genre_id: @genre1.id)
  end

  context 'Movie Show Page' do
    describe 'A visitor visits the show page for a specific movie' do
      it 'they should see the genres for that movie' do
        visit movie_path(slug: @movie1.slug)

        expect(page).to have_content('Genres for this Movie:')
        expect(page).to have_content(@movie1.title)
        expect(page).to have_content(@genre1.name)
        expect(page).to have_content(@genre2.name)

        expect(page).to_not have_content(@genre3.name)
      end

      it 'they should see the rating for that movie, if it does not have a rating it should be zero' do
        visit movie_path(slug: @movie1.slug)

        expect(page).to have_content("Rated: Not Rated")

        visit movie_path(slug: @movie3.slug)

        expect(page).to have_content("Rated: #{@movie3.rating} out of 5")
      end
    end
  end
end
