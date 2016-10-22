class Like < ActiveRecord::Base
  attr_accessible :game_id, :ip_addr

  belongs_to :game, counter_cache: true

  validates :game_id, presence: true
  validates :ip_addr, presence: true

  def liked_at
    created_at
  end
end
