class Api::UsersController < ApplicationController
	before_action :check_user, only: [:show, :update, :destroy, :edit]

	#list of all users
	def index
		users = User.all
		render json: {status: "success", code: 200, message: "List Of Users", data: users, count: users.count}
	end
	
	# SHow specific users
	def show
		if @user.present?
			render json: {status: "success", code: 200, message: "One Of Users", data: @user}
		else	
			render json: {status: "Not Found", code: 404, message: "Could not find user", data: ''}
		end
	end

	#Create New User
	def create
		user = User.new(firstName: params[:firstName], lastName: params[:lastName], email: params[:email])
		if user.save!
			render json: {status: "Created SuccessFully", code: 200, message: "Success", data: user}
		else
			render json: {status: "ERROR", code: 200, message: "Failed", data: ''}
		end
	end

	def edit
		@user = User.find_by_id(params[:id])
	end	

	
	def update
		if @user.present?
			@user.update_attributes(firstName: params[:firstName])
			render json: {status: "Updated SuccessFully", code: 200, message: "Success", data: @user}
		end
	end
	
	def destroy
		if @user.present?
			@user.destroy
			# render json: {status: "Destroy SuccessFully", code: 200, message: "Success", data: @user} # For describe message
			# In case of delete empty list as per specification
			render json: {}
		else
			# render json: {status: "Not Found", code: 404, message: "user Not Found", data: ''}
		end
	end


	def typeahead
		match_users = []
		user = User.all
		user.each do |user|
			if user.email.include?(params[:input])
				match_users.push(name: user.firstName)
			end	
		end	
		render json: {status: "Find with Email", code: 200, message: "Success", data: match_users} # For describe message
	end	

	private

	# For DRY Code
	def check_user
		@user = User.find_by_id(params[:id])
		return @user if @user.present?
	end
end
