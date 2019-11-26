# frozen_string_literal: true

class CreateReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|
      t.integer :pay
      t.integer :debt
      t.string :number
      t.string :status
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
