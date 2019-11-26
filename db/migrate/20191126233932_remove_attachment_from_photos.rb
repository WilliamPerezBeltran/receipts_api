# frozen_string_literal: true

class RemoveAttachmentFromPhotos < ActiveRecord::Migration[6.0]
  def change
    remove_column :photos, :attachment, :string
  end
end
