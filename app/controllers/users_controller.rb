class UsersController < ApplicationController
  before_action :find_users, only: [:edit, :update, :destroy]

  def index
    @users = User.all.order(:username)
  end

  def show
    id = params[:id].to_i
    @user = User.find_by(id: id)

    if @user.nil?
      render :notfound, status: :note_found
    end
  end

  def new
    @users = User.new
  end

  def create
    @users = User.new(user_params)

    if @users.save
      redirect_to users_path
    else
      render :new
    end
  end

  def update
   if @user && @user.update(user_params)
     redirect_to user_path(@user.id)
   else @user
     flash.now[:warning]  = @user.errors.messages
     render :edit
   end
 end

  def edit; end

  def destroy
    user = User.find_by(id: params[:id].to_i)
    @deleted_user = user.destroy

    if @deleted_user
      redirect_to users_path
    end
  end

  private

  def user_params
    return params.require(:user).permit(:username, :upvote)
  end

end
