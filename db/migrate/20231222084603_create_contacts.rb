class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|

      t.integer :user_id
      t.string :title, null: false
      t.text :contact, null: false
      t.string :email
      t.string :name
      t.text :reply
      t.text :support, null: false, default: "未対応"
      t.timestamps
    end
  end
end
