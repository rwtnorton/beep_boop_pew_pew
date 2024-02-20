class Game < ApplicationRecord

  has_many :manufacturers, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def image_name
    GameImageFinder.from_game(self).image_name
  end
end
