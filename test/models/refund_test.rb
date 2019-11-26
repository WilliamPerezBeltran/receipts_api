# frozen_string_literal: true

# == Schema Information
#
# Table name: refunds
#
#  id             :integer          not null, primary key
#  value          :integer
#  actual_payment :integer
#  actual_debt    :integer
#  receipt_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class RefundTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
