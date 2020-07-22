class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :show, :update, :destroy]

	def new
		@article = Article.new
	end

	def create
		@article = current_user.articles.new(article_params)
		# @article.user = current_user
		respond_to do |format|
			if @article.save!
				format.html {redirect_to @article}
				format.js
				format.json {render :show, status: :created, location: @article}
			else
				format.html { render :new}
				format.json { render json: @article.errors, status: :unprocessable_entity }
			end
		end
		# if @article.save
		# flash[:success] = "Successfull creaated"
		# redirect_to article_path(@article)
		# else
		# 	flash[:danger] = @article.errors.full_messages.to_sentence
		# 	render 'new'
		# end
	end

	def show
	end

	# def edit
	# end

	# def update
	# 	if @article.update(article_params)
	# 		flash[:success] = "Article was updated"
	# 		redirect_to article_path(@article)
	# 	else
	# 		flash[:danger] = @article.errors.full_messages.to_sentence
	# 		render :edit
	# 	end
	# end
	
	 def edit
        @article = Article.find(params[:id])
        respond_to do |format|
          format.html { @article.save }
          format.js
        end
      end

      def update
        @article = Article.find(params[:id])
        @article.update(article_params)
        respond_to do |format|
          format.html { redirect_to @article }
          format.js
      	end
      end

	def index
		@articles = Article.paginate(page: params[:page], per_page: 5)
	end

	def destroy
		sleep 1
		if @article.destroy
		    respond_to do |format|
			    format.html { redirect_to articles_path }
			    format.json { head :no_content }
			    format.js { render :layout => false }
		    end
		end
	end

	# Strong Parameters is a feature of Rails that prevents 
	# assigning request parameters to objects unlesss they 
	# have been explicitly permitted.
	private
	def article_params
		params.require(:article).permit(:title, :description)
	end

	def set_article
		if current_user.nil?
			# TODO: convrt all flash messages to I18n
			# flash[:danger] = I18n.t(warning.login) 
			flash[:danger] = "you are not eligible for this action. Please SignIn !" 
			redirect_to login_path and return
		elsif current_user.present? && params[:action] == 'show'
			p '*'*100
			p params.inspect
			p '*'*100
			@article = Article.find_by(id: params[:id])
		elsif current_user.present? && !params[:action] == 'show'
			@article = current_user.articles.where(id: params[:id]).last
		end
		redirect_to articles_path, alert: 'This action not available to you.' and return if @article.blank?
	end
end