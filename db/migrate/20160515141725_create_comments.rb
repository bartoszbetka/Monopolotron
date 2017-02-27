class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer "user_id"
      t.integer "shop_id"
      t.float "rate"
      t.string "comments", :limit => 250
      t.timestamps null: false
    end
    add_index("comments","user_id")
    add_index("comments","shop_id")
  end
end
