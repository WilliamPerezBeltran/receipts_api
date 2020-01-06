class AddPhotoToPayments < ActiveRecord::Migration[6.0]
  def change
  	add_column :payments, :photo, :json
  end
end
