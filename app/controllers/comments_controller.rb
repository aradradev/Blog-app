class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment_text = comment_params[:text].strip
    if comment_text.present?
      @comment = current_user.comments.build(comment_params.merge(post_id: @post.id))

      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        redirect_to @post
      else
        flash[:alert] = 'Comment could not be saved.'
        render '/posts/show'
      end
    else
      flash[:alert] = 'Comment cannot be empty.'
      render '/posts/show'
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
