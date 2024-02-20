class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.integer :game_id, null: false, index: true
      t.string :ip_addr, null: false, index: true

      t.timestamps
    end
    add_index :likes, %i[game_id ip_addr], unique: true
    add_index :likes, :created_at
  end
end
