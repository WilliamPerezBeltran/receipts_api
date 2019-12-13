# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id                  :integer          not null, primary key
#  name                :string
#  phone               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  type_identification :string
#  identification      :integer
#  address             :string
#  email               :string
#  bank                :string
#  type_account        :string
#  account_number      :integer
#

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
