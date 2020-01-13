class UsersController < ApplicationController
	def index
		@users = User.select("id,name")

		render json: @users
	end

	def all_user_for_filter
		@users = User.select("id,name")
		@all_users=	@users.map{|value| {id: value[:id], label: value[:name], value: value[:name] } }

		render json: @all_users
	end


end
