class UsersController < ApplicationController
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			# flash[:success] = "Welcome to the Alpha blog #{@user.username}"
			flash[:success] = t "success.done"
			redirect_to articles_path
		else
			# flash[:danger] = @user.errors.full_messages.to_sentence
			flash[:danger] = t "warning.detail"
			render 'new'
		end
	end
	def edit
		@user = User.find_by(id: params[:id])
	end
	def update
		@user = User.find_by(id: params[:id])
		if @user.update(user_params)
			# flash[:success] = "your account was updated	successfully"
			flash[:success] = t "success.done"
			redirect_to articles_path
		else
			flash[:danger] = @user.errors.full_messages.to_sentence
			render 'edit'
		end
	end
	def show
		@user = User.find_by(id: params[:id])
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end
	def index
		@users = User.paginate(page: params[:page], per_page: 3)
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end
end