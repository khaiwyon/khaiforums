class UsersController < ApplicationController
   before_action :authenticate!, except: [:create, :new]

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id])
    authorize @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "You've created your User successfully."
      redirect_to topics_path

    else
      flash[:danger] = @user.errors.full_messages
      render new_user_path
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    authorize @user

    if @user.update(user_params)
      flash[:success] = "You've successfully edited your User"
      redirect_to root_path
    else
      flash[:danger] = @user.errors.full_messages
      redirect_to edit_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :email, :username)
  end
end
