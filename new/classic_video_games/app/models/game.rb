class Game < ApplicationRecord

  has_many :manufacturers, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
