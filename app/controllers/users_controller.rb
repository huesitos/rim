class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		@user.password = user_params[:password]

		respond_to do |format|
			if @user.save
				format.html { redirect_to login_path }
			else
				format.html {redirect_to '/signup', notice: "Couldn't save user.", alert: 'danger'}
			end
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password)
	end
end
