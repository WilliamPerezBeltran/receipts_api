class CreateConsignations < ActiveRecord::Migration[6.0]
  def change
    create_table :consignations do |t|
      t.integer :type
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
