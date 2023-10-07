class CommentsController < ApplicationController
  load_and_authorize_resource
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params.merge(post_id: @post.id))
    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to @post
    else
      @comments = @post.comments
      flash[:alert] = 'Comment cannot be empty.'
      render '/posts/show'
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    authorize! :destroy, @comment
    @post = @comment.post
    if @comment.destroy
      @post.decrement!(:comments_counter)
      redirect_to post_path(@comment.post), notice: 'Comment was successfully deleted.'
    else
      render '/posts/show', notice: 'Oops Something\'s wrong. Try again.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
