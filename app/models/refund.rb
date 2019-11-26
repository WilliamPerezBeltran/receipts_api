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

class Refund < ApplicationRecord
  belongs_to :receipt
  has_many :photos
end
