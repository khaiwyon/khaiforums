class PostsController < ApplicationController
  respond_to :js
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topic = Topic.includes(:posts).friendly.find(params[:topic_id])
    @posts = @topic.posts.order(id: :DESC)
    @post = Post.new

    if request.path != topic_posts_path(@topic)
      redirect_to topic_posts_path(@topic), status: :moved_permanently
     end
  end

  def create
    @topic= Topic.friendly.find(params[:topic_id])
    @post= current_user.posts.build(post_params.merge(topic_id:params[:topic_id]))
    @new_post = Post.new

    if @post.save
      flash.now[:success] = "You've created a new post."
    else
      flash.now[:danger] = @post.errors.full_messages
    end
  end

  def edit
    @post = Post.friendly.find(params[:id])
    @topic = Topic.friendly.find(params[:topic_id])
    authorize @post
  end

  def update
    @topic = Topic.friendly.find(params[:topic_id])
    @post = Post.friendly.find(params[:id])

    if @post.update(post_params)
      flash.now[:success] = "You've edited a new post."
    else
      flash.now[:danger] = @post.errors.full_messages
    end
   end


  def destroy
    @post = Post.friendly.find(params[:id])
    @topic = @post.topic
    authorize @post
    if @post.destroy
      flash.now[:success] = "You've deleted a new post."
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
