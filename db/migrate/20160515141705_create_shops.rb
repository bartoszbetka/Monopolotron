class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string "shopname", :limit => 50, :null => false
      t.string "address"
      t.datetime "topen"
      t.datetime "tclose"
      t.float "latitude"
      t.float "longitude"
      t.boolean "visible", :default => false
      t.timestamps null: false
    end
  end
end
