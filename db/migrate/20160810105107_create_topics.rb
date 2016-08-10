class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
