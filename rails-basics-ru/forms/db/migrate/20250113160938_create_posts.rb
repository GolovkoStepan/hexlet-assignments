class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body
      t.string :summary
      t.boolean :published, null: false, default: false
      
      t.timestamps
    end
  end
end
