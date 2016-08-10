class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :post_id
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
