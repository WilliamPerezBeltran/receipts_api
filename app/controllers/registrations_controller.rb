class RegistrationsController < ApplicationController
	skip_before_action :authenticate_request
	def create
		@user = User.new(user_params)
		if @user.save 
			render json: @user 
		else
			render json: {error: 'error en los parametros'}, status: :bad_request
		end
	end

	def delete
		# binding.pry

		@user = User.find(params[:id])
		@user.destroy
		render json: {status: :ok, msg:"Usuario eliminado correctamente"}
	end

	def update
		binding.pry
		@user = User.find_by(email: params[:email])
		if @user.update(user_params)
			render json: {status: :ok, msg:"Usuario actualizado"}
		else
			render json: {status: false, msg:"Error en la petición"}
		end

	end

	private
	def user_params
		params.require(:user).permit(:name,:email,:password,:password_confirmation)
		
	end
end
