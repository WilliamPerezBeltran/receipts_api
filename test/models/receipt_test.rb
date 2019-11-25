# == Schema Information
#
# Table name: receipts
#
#  id         :integer          not null, primary key
#  pay        :integer
#  debt       :integer
#  company_id :integer          not null
#  user_id    :integer          not null
#  number     :integer
#  status     :string
#  payment_id :integer          not null
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  refund_id  :integer
#

require 'test_helper'

class ReceiptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
