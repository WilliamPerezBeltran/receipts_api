# frozen_string_literal: true

class CreateRefunds < ActiveRecord::Migration[6.0]
  def change
    create_table :refunds do |t|
      t.integer :value
      t.integer :actual_payment
      t.integer :actual_debt
      t.references :receipt, foreign_key: true

      t.timestamps
    end
  end
end
