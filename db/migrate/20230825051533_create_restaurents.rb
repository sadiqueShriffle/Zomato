class CreateRestaurents < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurents do |t|
      t.string :name
      t.string :place
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
