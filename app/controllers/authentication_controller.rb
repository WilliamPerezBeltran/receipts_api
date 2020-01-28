# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
  	puts "authenticate "
  	puts "params[:email] "
  	puts params[:email] 
  	puts "params[:password] "
  	puts params[:password] 
    command = AuthenticateUser.call(params[:email], params[:password])
    puts "----------------command ----------------"
  	puts command
    puts "----------------command.success? ----------------"
  	puts command.success?

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
