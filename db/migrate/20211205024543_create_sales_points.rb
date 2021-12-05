class CreateSalesPoints < ActiveRecord::Migration[6.1]
  def change
    create_table :sales_points do |t|
      t.string :address_line1, null: false
      t.string :address_line2

      t.references :shop, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
