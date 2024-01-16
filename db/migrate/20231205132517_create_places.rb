class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|

      t.string :address, null: false
      t.float :latitude, null: false
      t.float :longitude,null: false
      t.timestamps
    end
  end
end
