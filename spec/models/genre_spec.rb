require 'rails_helper'

RSpec.describe Genre do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Relationships' do
    it { should have_many(:movie_genres) }
    it { should have_many(:movies).through(:movie_genres) }
  end
end
