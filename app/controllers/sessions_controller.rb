class SessionsController < ApplicationController

	def create
		s = params[:session]
		user = User.authenticate(s[:login], s[:password])
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