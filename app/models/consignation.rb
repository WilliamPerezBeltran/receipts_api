# == Schema Information
#
# Table name: consignations
#
#  id         :integer          not null, primary key
#  name       :string
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Consignation < ApplicationRecord
end
