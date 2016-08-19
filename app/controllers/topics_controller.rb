class TopicsController < ApplicationController
  respond_to :js
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topics = Topic.order(id: :DESC).page params[:page]
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topic_params)
    @new_topic = Topic.new

    if @topic.save
      flash.now[:success] = "You've created a new topic."
    else
       flash.now[:danger] = @topic.errors.full_messages
    end
  end

  def edit
    @topic = Topic.friendly.find(id: params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.friendly.find(id: params[:id])

    if @topic.update(topic_params)
      flash.now[:success] = "You've successfully edited this topic."
    else
      flash.now[:danger] = @topic.errors.full_messages
    end
 end

 def destroy
    @topic = Topic.friendly.find(id: params[:id])
    if @topic.destroy
      redirect_to topics_path
    else
      redirect_to topic_path(@topic)
    end
  end

 private

 def topic_params
   params.require(:topic).permit(:title, :description)
 end
end
