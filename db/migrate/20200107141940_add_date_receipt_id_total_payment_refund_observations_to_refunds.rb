# frozen_string_literal: true

class AddDateReceiptIdTotalPaymentRefundObservationsToRefunds < ActiveRecord::Migration[6.0]
  def change
    add_column :refunds, :date, :date
    add_column :refunds, :refund, :integer
    add_column :refunds, :observations, :string
    add_column :refunds, :user_refund, :string
  end
end
