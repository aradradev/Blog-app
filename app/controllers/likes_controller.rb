class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post: @post)
    if @like.save
      redirect_to @post, notice: 'Liked the post!'
    else
      redirect_to @post, alert: 'Failed to like the post!'
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to @like.post, noticed: 'Unliked post!'
  end
end
