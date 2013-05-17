class ApplicationController < ActionController::Base
	protect_from_forgery

	private

	def authorize
		if current_user.nil?
			flash[:error] = "please login first"
			redirect_to signin_path
		end 
	end

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user
 
end