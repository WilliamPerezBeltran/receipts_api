class AddAttachmentsToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :attachments, :json
  end
end
