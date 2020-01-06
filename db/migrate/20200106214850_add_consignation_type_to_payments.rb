class AddConsignationTypeToPayments < ActiveRecord::Migration[6.0]
  def change
  	add_column :payments, :consignation_type, :string
  end
end
