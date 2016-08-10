class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user && user.authenticate(params[:password])
      session[:id] = user[:id]
      flash[:success] = "Welcome back #{current_user.username}"
      redirect_to root_path

    else
      flash[:danger] = "Error logging in"
      redirect_to new_session_path
    end
  end

  def destroy
    session.delete (:id)
    flash[:success] = "You've been logged out"
    redirect_to root_path
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
