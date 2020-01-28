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

class Company < ApplicationRecord
  has_many :receipts
  require 'csv'

  def self.import(file_path)
    attributes = %w[type_identification identification name address phone email bank type_account account_number]
    companies = []

    CSV.foreach(file_path,
                encoding: 'iso-8859-1:utf-8',
                headers: true,
                converters: :all,
                header_converters: ->(h) { h.downcase.gsub(' ', '_') }) do |row|
      type_identification = row['type_identification']
      identification = row['identification']
      name = row['name']
      address = row['address']
      phone = row['phone']
      email = row['email']
      bank = row['bank']
      type_account = row['type_account']
      account_number = row['account_number']

      row['type_identification'].nil? ? type_identification = '' : type_identification = type_identification.to_s.downcase
      row['identification'].nil? ? identification = '' : identification
      row['name'].nil? ? name = '' : name = name.to_s.downcase.downcase.squeeze(' ').gsub(/\s+$/, '')
      row['address'].nil? ? address = '' : address = address.to_s.downcase.squeeze(' ').gsub(/\s+$/, '')
      phone = row['phone'].nil? ? '' : phone.to_s
      email = row['email'].nil? ? '' : email.to_s.downcase
      bank = row['bank'].nil? ? '' : bank.to_s.downcase
      row['type_account'].nil? ? type_account = '' : type_account = type_account.to_s.downcase
      row['account_number'].nil? ? account_number = '' : account_number

      new_row = {
        type_identification: type_identification,
        identification: identification,
        name: name,
        address: address,
        phone: phone,
        email: email,
        bank: bank,
        type_account: type_account,
        account_number: account_number
      }

      companies << new_row
    end
    Company.bulk_insert values: companies
  end
end
