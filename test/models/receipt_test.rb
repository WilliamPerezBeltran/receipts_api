# frozen_string_literal: true

# == Schema Information
#
# Table name: receipts
#
#  id           :integer          not null, primary key
#  pay          :integer
#  debt         :integer
#  number       :string
#  status       :string
#  date         :date
#  user_id      :integer          not null
#  company_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  pay_invoice  :integer
#  receipt_type :string
#  photo        :json
#  observation  :string
#

require 'test_helper'

class ReceiptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
