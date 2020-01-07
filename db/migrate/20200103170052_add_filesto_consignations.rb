# frozen_string_literal: true

class AddFilestoConsignations < ActiveRecord::Migration[6.0]
  def change
    add_column :consignations, :type_consignation, :string
    add_column :consignations, :credit, :integer
    add_column :consignations, :pay, :integer
    add_column :consignations, :debt, :integer
    add_column :consignations, :photo, :json
  end
end
