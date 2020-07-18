class CommentsController < ApplicationController

	def new
		@article = Article.find_by(id: params[:article_id])
  		respond_to do |format|
  			format.js
  		end
	end

	def create
		@article = Article.find(params[:article_id])
  		@comment = @article.comments.create(comment_params)
  		@comment.user_id = current_user.id
		respond_to do |format|
			if @comment.save
				format.html { redirect_to article_path(@article) }
    			format.js
    		else
    			format.html {redirect_to @article}
      			format.json { render json: @article.errors }
    		end
    	end
	end

	def destroy
  		@comment = Comment.find_by(id: params[:id])
  		respond_to do |format|
	  		if @comment.destroy
	  			format.html { redirect_to article_path(Article.find(params[:article_id])) }
	  			format.js
	  		end
  		end
	end

	private
	def comment_params
		params.require(:comment).permit(:user_id, :article_id, :body)
	end
end