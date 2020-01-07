# frozen_string_literal: true

class DropPhotos < ActiveRecord::Migration[6.0]
  def up
    drop_table :photos
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
