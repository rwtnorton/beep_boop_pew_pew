class Game < ActiveRecord::Base
  attr_accessible :is_active, :name, :notes, :publication_year

  has_many :manufacturers, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
