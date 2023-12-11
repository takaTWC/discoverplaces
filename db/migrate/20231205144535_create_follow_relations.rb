class CreateFollowRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_relations do |t|

      t.integer :user_id, null: false
      t.integer :follow_id, null: false
      t.timestamps
    end
  end
end
