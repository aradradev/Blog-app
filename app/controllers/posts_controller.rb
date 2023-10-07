class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: %i[new create]

  def index
    @posts = Post.includes(:author, :comments).all
  end

  def show
    @post = Post.includes(:author, :comments).find(params[:id])
    @user = @post.author
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def destroy
    authorize! :destroy, @post
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
