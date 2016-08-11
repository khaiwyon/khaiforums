class CommentsController <ApplicationController
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topic = Topic.includes(:posts).find_by(id: params[:topic_id])
    @post = Post.includes(:comments).find_by(id: params[:post_id])
    @comments = @post.comments
  end

  def new
    @post= Post.find_by(id: params[:post_id])
    @topic =Topic.includes(:posts).find_by(id:params[:topic_id])
    @comment= Comment.new
    authorize @comment
  end

  def create
    @topic = Topic.find_by(id: params[:topic_id])
    @post= Post.find_by(id: params[:post_id])
    @comment = current_user.comments.build(comment_params.merge(post_id:params[:post_id]))

    if @comment.save
      redirect_to topic_post_comments_path(@topic, @post)
      flash[:success] = "You've created a new comment."
    else
      redirect_to new_topic_post_comment_path(@topic, @post, @comment)
      flash[:danger] = @comment.errors.full_messages
    end
  end

  def edit
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])
    authorize @comment
  end

  def update
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])

    if @comment.update(comment_params)
      redirect_to topic_post_comments_path(@topic, @post, @comment)
      flash[:success] = "You've edited this comment."
    else
      redirect_to edit_topic_post_comment_path(@post,@comment)
      flash[:danger] = @comment.errors.full_messages
    end
  end

  def destroy
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])

    if @comment.destroy
      redirect_to topic_post_comments_path(@topic, @post, @comment)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image)
  end
end
