class AddLikesCountToGames < ActiveRecord::Migration
  def change
    add_column :games, :likes_count, :integer,
               null: false, default: 0
  end
end
