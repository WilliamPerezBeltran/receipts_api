# frozen_string_literal: true

class AddFilesToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :type_identification, :string
    add_column :companies, :identification, :integer
    add_column :companies, :address, :string
    add_column :companies, :email, :string
    add_column :companies, :bank, :string
    add_column :companies, :type_account, :string
    add_column :companies, :account_number, :integer
  end
end
