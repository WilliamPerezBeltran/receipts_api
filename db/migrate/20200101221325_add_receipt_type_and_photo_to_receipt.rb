class AddReceiptTypeAndPhotoToReceipt < ActiveRecord::Migration[6.0]
  def change
    add_column :receipts, :receipt_type, :string
    add_column :receipts, :photo, :json
  end
end
