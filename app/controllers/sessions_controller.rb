class SessionsController < ApplicationController
  def login
    flash[:error] = 'Logging in'

    user = User.find_by(username: params[:user][:username])

    if user.nil?
      user = User.create(username: params[:user][:username])
      if user.save
        session[:user_id] = user.id
        flash[:success] = "#{ user.username } Successfully logged in!"
        redirect_to root_path
      else
        flash[:warning] = "#{ user.username } Unable to log in!"
        redirect_to root_path
      end

    else
      session[:user_id] = user.id
      flash[:success] = "#{ user.username } Successfully logged in!"
      redirect_to root_path
    end

  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out'
    redirect_back fallback_location: root_path
  end

end
