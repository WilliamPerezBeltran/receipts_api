class AddObservationToReceipts < ActiveRecord::Migration[6.0]
  def change
  	add_column :receipts, :observation, :string
  end
end
