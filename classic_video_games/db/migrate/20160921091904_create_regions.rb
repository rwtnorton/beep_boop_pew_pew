class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name, null: false, uniqueness: true, index: true

      t.timestamps
    end
  end
end
