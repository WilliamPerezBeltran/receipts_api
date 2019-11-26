class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :observation
      t.string :attachment
      t.references :refund, foreign_key: true
      t.references :consignation, foreign_key: true
      t.references :payment, foreign_key: true

      t.timestamps
    end
  end
end
