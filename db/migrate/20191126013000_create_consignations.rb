class CreateConsignations < ActiveRecord::Migration[6.0]
  def change
    create_table :consignations do |t|
      t.string :name
      t.date :date
      t.string :observation
      t.references :payment, foreign_key: true

      t.timestamps
    end
  end
end
