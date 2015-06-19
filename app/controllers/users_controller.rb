class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
		@edit = true
	end

	def create
		@user = User.new(
			name: user_params[:name], 
			email: user_params[:email], 
			password: User.encrypt_password(user_params[:password])
			)

		respond_to do |format|
			if @user.save
				format.html { redirect_to login_path }
			else
				format.html {redirect_to '/signup', 
					notice: "Couldn't save user.", alert: 'danger'}
			end
		end
	end

	def update
		@user = User.find(params[:id])

		if user_params[:password] 
			password = User.encrypt_password(user_params[:password])
		else
			password = @user.password
		end

		respond_to do |format|
			if @user.update(name: user_params[:name], password: password)
				format.html { redirect_to edit_user_path @user }
			else
				format.html { redirect_to edit_user_path @user, 
					notice: "Couldn't save user.", 
					alert: 'danger'}
			end
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password)
	end
end
