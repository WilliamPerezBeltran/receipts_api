# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'william', email: 'william@gmail.com', password: '123456', password_confirmation: '123456')

Company.create(name: 'Bavaria')
Company.create(name: 'Pepsi')
Company.create(name: 'Postobon')
Company.create(name: 'Microsoft')
Company.create(name: 'Apple')
Company.create(name: 'Chevrolet')
Company.create(name: 'Carrefour')
Company.create(name: 'Obleas dani')

Payment.create(name: 'pago_anticipado')
Payment.create(name: 'pago_contra_entrega')
Payment.create(name: 'pago_credito')
