class RenameColumnNameAddressInORder < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders ,:address, :shipping_address
  
  end
end
