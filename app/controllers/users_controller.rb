class UsersController < ApplicationController
	before_filter :authenticate
	before_filter :correct_user

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash.now[:success] = "Welcome to Currency Tracker!"
		else
			flash.now[:error] = "Couldn't create account for you :("
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private

	def correct_user
		@user = User.find(params[:id])
	end
end

