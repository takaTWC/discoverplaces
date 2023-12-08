class CreateTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_relations do |t|

      t.references :post, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
    add_index :tag_relations, [:post_id, :tag_id], unique: true
  end
end
