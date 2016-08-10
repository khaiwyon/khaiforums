class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :topic_id
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
