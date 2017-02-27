class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "name", :limit => 30, :null => false
      t.string "upass", :null => false
      t.string "email", :default => "", :null => false
      t.boolean "privilege", :default => false
      t.timestamps null: false
    end
  end
end
