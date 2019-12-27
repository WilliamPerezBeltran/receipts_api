# frozen_string_literal: true

class AddPayInvoiceToReceipts < ActiveRecord::Migration[6.0]
  def change
    add_column :receipts, :pay_invoice, :integer
  end
end
