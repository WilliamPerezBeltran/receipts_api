# == Schema Information
#
# Table name: refunds
#
#  id             :integer          not null, primary key
#  value          :integer
#  actual_payment :integer
#  actual_debt    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class RefundTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end