class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	
	def logged_in?
	!!current_user
	end
	
	def require_user
		if !logged_in?
			flash[:danger] = "You must be logged in to perform that action"
			redirect_to root_path
		end
	end
	
	def resource_name
		:user
	end
	def resource
		@resource ||= User.new
	end
	def resource_class
		User
	end
	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

end