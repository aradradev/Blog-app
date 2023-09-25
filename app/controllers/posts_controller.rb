class PostsController < ApplicationController
  def index
    @post = Post.all
  end
  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.comments
  end
end
