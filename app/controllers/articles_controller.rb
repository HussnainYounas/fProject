class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :show, :destroy]
	
	def new
		@article = Article.new
	end
	def create
		# render plain: params[:article].inspect
		@article = Article.new(article_params)
		
		if @article.save
		flash[:success] = "Successfull creaated"
		# redirect_to article_path(@article)
		else
			flash[:success] = "Didn't Created"
			render 'new'
		end
	end
	def show
		# @article = Article.find(params[:id])
	end

	def edit
		# @article = Article.find(params[:id])
	end

	def update
		# @article = Article.find(params[:id])
		if @article.update(article_params)
		flash[:success] = "Article was updated"
		redirect_to article_path(@article)
			
		else
			flash[:success] = "Article Not updated"
			render edit
		end
	end
	def index
		@article = Article.all
	end
	def destroy
		# @article = Article.find(params[:id])
		@article.destroy
		flash[:success] = "Article was Deleted"
		redirect_to articles_path
	end

# Strong Parameters is a feature of Rails that prevents 
# assigning request parameters to objects unlesss they 
# have been explicitly permitted.
	private
	def article_params
		params.require(:article).permit(:title, :description)
	end
	def set_article
		@article = Article.find(params[:id])
	end
end