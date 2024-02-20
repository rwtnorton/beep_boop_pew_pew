class AddLikesCountToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :likes_count, :integer,
               null: false, default: 0
  end
end
