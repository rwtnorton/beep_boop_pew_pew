class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.integer :game_id, null: false, index: true
      t.string :company, null: false, index: true
      t.string :region, null: false, default: '', index: true

      t.timestamps
    end
    add_index :manufacturers, [:game_id, :company, :region], unique: true
    add_index :manufacturers, [:game_id, :company]
    add_index :manufacturers, [:company, :region]
  end
end
