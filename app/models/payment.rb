# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  name       :string
#  receipt_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Payment < ApplicationRecord
  belongs_to :receipt
  has_many :consignations
  has_many :photos
end
