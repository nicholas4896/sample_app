class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      # Its saying if params... == 1, remember user, else forget, end. WOW
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # redirects back to where the user was or the user page
      redirect_back_or user
      # log the user in and redirect to the user's show page
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "You've logged out!"
    redirect_to root_path

  end

end
