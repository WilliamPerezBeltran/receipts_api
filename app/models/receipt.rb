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

class Receipt < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_many :payments
  has_many :refunds
end
