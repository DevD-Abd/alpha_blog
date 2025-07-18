class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email.downcase])
      logger.debug "Session params: #{session_params.inspect}"
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in."
      redirect_to user
    else
      flash.now[:danger] = "Invalid email or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end