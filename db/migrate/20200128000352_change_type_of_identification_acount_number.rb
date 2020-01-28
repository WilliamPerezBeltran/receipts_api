class ChangeTypeOfIdentificationAcountNumber < ActiveRecord::Migration[6.0]
  def change
  	change_column :companies, :identification, :string
  	change_column :companies, :account_number, :string
  end
end
