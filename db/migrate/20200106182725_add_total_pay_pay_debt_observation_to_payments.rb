class AddTotalPayPayDebtObservationToPayments < ActiveRecord::Migration[6.0]
  def change
  	add_column :payments, :total_payment, :integer
  	add_column :payments, :pay, :integer
  	add_column :payments, :debt, :integer
  	add_column :payments, :observation, :string
  end
end
