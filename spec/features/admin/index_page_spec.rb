require 'rails_helper'

RSpec.describe 'Index Page (Admin)' do
  before :each do
    @genre1 = Genre.create!(name: 'Sci-Fi')
    @genre2 = Genre.create!(name: 'Action')
    @genre3 = Genre.create!(name: 'Fantasy')

    @director1 = Director.create!(name: 'Cool Director')
    @movie1 = @director1.movies.create!(title: 'Star Wars', description: 'A great movie')
    @movie2 = @director1.movies.create!(title: 'Harry Potter', description: 'Another great movie')

    MovieGenre.create!(movie_id: @movie1.id, genre_id: @genre1.id)
    MovieGenre.create!(movie_id: @movie1.id, genre_id: @genre2.id)
    MovieGenre.create!(movie_id: @movie2.id, genre_id: @genre3.id)

    @admin = User.create!(username: 'admin', password: 'adminlogin', role: 1)
  end

  describe 'An admin visits the genre index page' do
    it 'they should see a list of all genre name in the database' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit genres_path

      expect(page).to have_content(@genre1.name)
      expect(page).to have_content(@genre2.name)
      expect(page).to have_content(@genre3.name)
    end

    it 'they should see a form to create a new genre' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit genres_path

      expect(page).to have_content('Create a New Genre')
      within('#new_genre') do
        expect(page).to have_content('Name')
        expect(page).to have_button('Create Genre')
      end
    end
  end
end
