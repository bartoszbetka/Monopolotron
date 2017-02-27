class CreateShopsUsersJoin < ActiveRecord::Migration
  def change
    create_table :shops_users, :id => false do |t|
      t.integer "shop_id"
      t.integer "user_id"
    end
    add_index :shops_users, ["shop_id", "user_id"]
  end
end
