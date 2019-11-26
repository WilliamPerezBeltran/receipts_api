# frozen_string_literal: true

# == Schema Information
#
# Table name: consignations
#
#  id          :integer          not null, primary key
#  name        :string
#  date        :date
#  observation :string
#  payment_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Consignation < ApplicationRecord
  belongs_to :payment
  has_many :photos
end
