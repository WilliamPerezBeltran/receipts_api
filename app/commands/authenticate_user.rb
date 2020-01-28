# frozen_string_literal: true

class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    puts "initialize class authenticate_user.rb"
    puts "email"
    puts email
    puts "password"
    puts password
    @email = email
    @password = password
  end

  def call
    puts "call class authenticate_user.rb"
    puts "user.name"
    puts user.name
    puts "user.email"
    puts user.email
    if user
      JsonWebToken.encode(user_id: user.id, user_name: user.name, user_email: user.email)
    end
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    return user if user&.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
