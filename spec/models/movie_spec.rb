require 'rails_helper'

describe Movie, type: :model do
  describe "relationships" do
    it {should belong_to(:director)}
    it {should have_many(:actors).through(:actor_movies)}
    it { should have_many(:movie_genres) }
    it { should have_many(:genres).through(:movie_genres) }
  end

  describe 'instance methods' do
    it 'should generate a slug for a new movie' do
      director = Director.create(name: 'foo')
      movie = director.movies.create(title: 'Jurassic Park', description: 'blah')

      expect(movie.slug).to eq(movie.title.parameterize)
    end
  end
end
