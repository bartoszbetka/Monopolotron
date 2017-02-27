class ChangeColummnShop < ActiveRecord::Migration
  def change
  	change_column(:shops, :topen, :time)
  	change_column(:shops, :tclose, :time)
  end
end
