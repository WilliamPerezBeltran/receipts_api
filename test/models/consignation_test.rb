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

require 'test_helper'

class ConsignationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
