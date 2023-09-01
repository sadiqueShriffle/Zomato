class AddColumnNameAddressToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :name, :string
    add_column :orders, :address, :string
    remove_column :orders,:total_amount ,:integer
  end
end
