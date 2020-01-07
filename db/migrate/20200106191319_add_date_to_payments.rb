# frozen_string_literal: true

class AddDateToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :date, :date
  end
end
