class RenameColumnTypeFromDish < ActiveRecord::Migration[7.0]
  def change
    remove_column :dishes , :type 
  end
end
