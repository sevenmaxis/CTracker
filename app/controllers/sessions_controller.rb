class SessionsController < ApplicationController

	def create
		user = User.authenticate(*params[:session])
		if user.nil?
			flash.now[:error] = "Invalid login/password combination."
			render 'new'
		else
			sign_in user
		end
	end

	def destroy
		sign_out
	end
end