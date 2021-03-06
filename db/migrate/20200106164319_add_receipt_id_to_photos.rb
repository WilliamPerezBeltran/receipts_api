# frozen_string_literal: true

class AddReceiptIdToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_reference :photos, :receipt, null: true, foreign_key: true
  end
end
