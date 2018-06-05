require 'rails_helper'

RSpec.describe Genre do
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

  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Relationships' do
    it { should have_many(:movie_genres) }
    it { should have_many(:movies).through(:movie_genres) }
  end

  describe 'Instance Methods' do
    describe '#average_movie_rating' do
      it 'should return the average rating of the movies in the specific genre' do
        expect(@genre1.average_movie_rating).to eq(4)
      end
    end
  end
end
