class SessionsController < ApplicationController
	def new
	end

	def create
		@user = User.find_by(email: session_params[:email])

		if @user and @user.password == User.encrypt_password(session_params[:password])
			session[:user_id] = @user._id.to_s
			redirect_to projects_path
		else
			redirect_to '/login', notice: "Couldn't login user.", alert: "danger"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/login'
	end

	private

	def session_params
		params.require(:session).permit(:email, :password)
	end
end
