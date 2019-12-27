# frozen_string_literal: true

# == Schema Information
#
# Table name: photos
#
#  id              :integer          not null, primary key
#  title           :string
#  observation     :string
#  refund_id       :integer
#  consignation_id :integer
#  payment_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  attachments     :json
#

class Photo < ApplicationRecord
  belongs_to :refund, optional: true
  belongs_to :consignation, optional: true
  belongs_to :payment, optional: true

  # Gema Carrierwave para cargar imagenes
  mount_uploaders :attachments, AttachmentsUploader
end
