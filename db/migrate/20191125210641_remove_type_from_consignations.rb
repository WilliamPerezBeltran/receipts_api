class RemoveTypeFromConsignations < ActiveRecord::Migration[6.0]
  def change

    remove_column :consignations, :type, :integer
  end
end
