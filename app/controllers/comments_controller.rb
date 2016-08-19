class CommentsController <ApplicationController
  respond_to :js
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topic = Topic.includes(:posts).friendly.find(params[:topic_id])
    @post = Post.includes(:comments).friendly.find(params[:post_id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def create
    @topic = Topic.friendly.find(params[:topic_id])
    @post= Post.friendly.find(params[:post_id])
    @comment = current_user.comments.build(comment_params.merge(post_id:params[:post_id]))
    @new_comment = Comment.new

    if @comment.save
      CommentBroadcastJob.perform_later("create", @comment)
      flash.now[:success] = "You've created a new comment."
    else
      flash.now[:danger] = @comment.errors.full_messages
    end
  end

  def edit
    @topic = Topic.friendly.find(params[:topic_id])
    @post = Post.friendly.find(params[:post_id])
    @comment = Comment.find_by(id: params[:id])
    authorize @comment
  end

  def update
    @topic = Topic.friendly.find(params[:topic_id])
    @post = Post.friendly.find(params[:post_id])
    @comment = Comment.find_by(id: params[:id])

    if @comment.update(comment_params)
      CommentBroadcastJob.perform_later("update", @comment)
      flash.now[:success] = "You've edited this comment."
    else
      flash.now[:danger] = @comment.errors.full_messages
    end
  end

  def destroy
    @topic = Topic.friendly.find(params[:topic_id])
    @post = Post.friendly.find(params[:post_id])
    @comment = Comment.find_by(id: params[:id])
    authorize @comment

    if @comment.destroy
      CommentBroadcastJob.perform_now("destroy", @comment)
      flash.now[:success]= "You have deleted the comment"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image)
  end
end
