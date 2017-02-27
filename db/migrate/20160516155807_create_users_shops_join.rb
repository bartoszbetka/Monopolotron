class CreateUsersShopsJoin < ActiveRecord::Migration
  def change
    create_table :users_shops, :id => false do |t|
      t.integer "user_id"
      t.integer "shop_id"
    end
    add_index :users_shops, ["user_id", "shop_id" ]
  end
end
