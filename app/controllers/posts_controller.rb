class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:group_id])
    @posts = @group.posts
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group.destroy
    redirect_to group_path
    flash[:alert] = "Post deleted"
  end

  private

  def  post_params
    params.require(:post).permit(:content)
  end


end
