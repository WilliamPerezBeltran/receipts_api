class CreateReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|
      t.integer :pay
      t.integer :debt
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :number
      t.string :status
      t.references :payment, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
