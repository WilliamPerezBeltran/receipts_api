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

require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
