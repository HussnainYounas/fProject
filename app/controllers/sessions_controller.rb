class SessionsController < ApplicationController
	respond_to :html, :js
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			# flash[:success] = "You are logged in"
			flash[:success] = t "success.done"
			redirect_to users_path(user)
		else
			# flash.now[:danger] = "There was something wrong with your login information"
			flash.now[:danger] = t 'warning.detail'
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You are logged out"
		redirect_to root_path
	end

end