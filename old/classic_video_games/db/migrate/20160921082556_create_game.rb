class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name, null: false, uniqueness: true, index: true
      t.integer :publication_year, index: true
      t.string :notes
      t.boolean :is_active, null: false, default: false

      t.timestamps
    end
  end
end
