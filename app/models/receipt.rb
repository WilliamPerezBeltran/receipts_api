# == Schema Information
#
# Table name: receipts
#
#  id         :integer          not null, primary key
#  pay        :integer
#  debt       :integer
#  number     :string
#  status     :string
#  date       :date
#  user_id    :integer          not null
#  company_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Receipt < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_one :payment
  has_many :refunds
end