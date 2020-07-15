class CommentsController < ApplicationController

	def create
		 @article = Article.find(params[:article_id])
  		@comment = @article.comments.create(comment_params)
  		@comment.user_id = current_user.id
		if @comment.save
      		flash.now[:danger] = "Successfully Commented"
			redirect_to article_path(@article)
    	else
      		flash.now[:danger] = "Error"
    	end
	end

	private
	def comment_params
		params.require(:comment).permit(:user_id, :article_id, :comment)
	end
end