# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :authenticate_request

  def create
    # binding.pry
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: { error: 'error en los parametros' }, status: :bad_request
    end
  end

  def delete
    @user = User.find(params[:id])
    @user.destroy
    render json: { status: :ok, msg: 'Usuario eliminado correctamente' }
  end

  def update
    @user = User.find_by(email: params[:email])
    if @user.update(name: params[:name])

    else
      render json: { status: false, msg: 'Error en la petición' }
    end
  rescue Exception => e
    render json: {
      error: e,
      status: false,
      msg: 'Error en la petición'
    }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
