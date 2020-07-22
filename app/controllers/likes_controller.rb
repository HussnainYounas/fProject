class LikesController < ApplicationController
   before_action :find_article
   before_action :find_like, only: [:destroy]
  
  def create
  	if already_liked?
  		flash[:danger] = "You cant like more than once."
      redirect_to article_path(@article)
  	else
    @article.likes.create(user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to article_path(@article) }
      format.js
    end
    end
  end
  
  def destroy
 	 if !(already_liked?)
	   flash[:notice] = "Cannot unlike"
     redirect_to article_path(@article)
	 else
	   @like.destroy
	   respond_to do |format|
      format.html {redirect_to article_path(@article)}
      format.js
     end
   end
  end
  

 private
  def find_article
    @article = Article.find_by(id: params[:article_id])
  end
  
  def already_liked?
  	Like.where(user_id: current_user.id, article_id: params[:article_id]).exists?
  end
  def find_like
  	@like = @article.likes.find_by(id: params[:id])
  end
end
