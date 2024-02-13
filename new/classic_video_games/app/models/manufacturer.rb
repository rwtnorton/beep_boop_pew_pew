class Manufacturer < ApplicationRecord

  belongs_to :game

  validates :game_id, presence: true
  validates :company, presence: true
  validates :region, format: {
    with: /\A([a-z]{2})?\z/i, # allow "", "US"
    message: "must be blank or ISO 3166-1 alpha-2",
  }, exclusion: {
    in: [nil], message: "can't be nil",
  }

end
