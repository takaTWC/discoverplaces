class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.string :comment,  null: false
      t.decimal :score, precision: 5, scale: 3
      t.timestamps
    end
  end
end
