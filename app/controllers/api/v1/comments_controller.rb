class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comments = post.comments
    render json: comments
  end

  def create
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comment = post.comments.build(comment_params.merge(user: current_user))
    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_message }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
