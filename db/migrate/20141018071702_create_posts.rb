class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :title
      t.text :body
      t.hstore :tags

      t.timestamps
    end
  end
end
