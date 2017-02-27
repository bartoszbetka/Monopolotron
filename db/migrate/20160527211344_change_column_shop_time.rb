class ChangeColumnShopTime < ActiveRecord::Migration
  def change
  	remove_column(:shops, :topen, :time)
  	remove_column(:shops, :tclose, :time)

  	add_column(:shops, :topen, :time)
  	add_column(:shops, :tclose, :time)
  end
end
