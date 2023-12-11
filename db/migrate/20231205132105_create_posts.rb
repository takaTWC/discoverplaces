class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id,     null: false
      t.integer :place_id
      t.string  :title,       null: false
      t.string  :description, null: false
      t.timestamps
    end
  end
end
