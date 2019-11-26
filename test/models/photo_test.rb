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

require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
