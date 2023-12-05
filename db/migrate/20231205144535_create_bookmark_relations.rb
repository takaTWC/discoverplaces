class CreateBookmarkRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmark_relations do |t|

      t.integer :user_id, null: false
      t.integer :bookmark_id, null: false
      t.timestamps
    end
  end
end
