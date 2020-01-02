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
#

class Receipt < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :payments
  has_many :refunds
end
