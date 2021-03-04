class PostsController < ApplicationController
before_action :set_discussion
before_action :set_post, only: [:edit, :update, :destroy]

  def create
    @post = @discussion.posts.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to discussion_path(@discussion, anchor: @post.id)
    else
      redirect_to @discussion, alert: @post.errors.ful_messages.first
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
    redirect_to discussion_path(@discussion, anchor: @post.id)
    else
      redirect_to @discussion, alert: @post.errors.ful_messages.first
    end
  end

  def destroy
    @post.destroy
  end

private
 
  def set_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end

  def set_post
    @post = @discussion.posts.find_by(id: params[:id], user: current_user)
  end
  def post_params
    params.require(:post).permit(:body)
  end
end