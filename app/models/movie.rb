class Movie < ApplicationRecord
  validates_inclusion_of :rating, in: [0, 1, 2, 3, 4, 5]

  belongs_to :director
  has_many :actor_movies
  has_many :actors, through: :actor_movies
  has_many :movie_genres
  has_many :genres, through: :movie_genres

  before_save :generate_slug

  def generate_slug
    self.slug = title.parameterize
  end

  def rating_statement
    if rating == 0
      'Not Rated'
    else
      "#{rating} out of 5"
    end
  end
end
