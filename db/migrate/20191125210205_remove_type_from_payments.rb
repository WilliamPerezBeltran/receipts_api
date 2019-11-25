class RemoveTypeFromPayments < ActiveRecord::Migration[6.0]
  def change

    remove_column :payments, :type, :integer
  end
end
