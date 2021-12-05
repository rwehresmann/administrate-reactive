class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.float :price, null: false, default: 10
      t.string :name, null: false

      t.references :sales_point, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
