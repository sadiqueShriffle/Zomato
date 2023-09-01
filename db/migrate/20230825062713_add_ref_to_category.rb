class AddRefToCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :restaurent, null: false, foreign_key: true
  end
end
