class SessionsController < ApplicationController

	def create
		user = User.authenticate(params[:session][:login], params[:session][:password])
		if user.nil?
			flash.now[:error] = "Invalid login/password combination."
			render nothing: true
		else
			sign_in user
		end
	end

	def destroy
		sign_out
	end
end