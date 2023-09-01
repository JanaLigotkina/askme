class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy show]
  before_action :authorize_user, only: %i[edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_path, notice: 'You have successfully registered!'
    else 
      flash.now[:alert] = 'Incorrectly filled fields of the registration form'

      render :new
    end   
  end

  def edit 
  end  

  def update
    if @user.update(user_params)
      session[:user_id] = @user.id

      redirect_to root_path, notice: 'User data updated!'
    else 
      flash.now[:alert] = 'An error occurred while trying to save changes'

      render :edit
    end   
  end   

  def destroy
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: 'User deleted!'
  end  

  def show 
    @user = User.find(params[:id])
    @questions = @user.questions.order(created_at: :desc)
    @question = Question.new(user: @user)
  end  

  private 

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    redirect_with_alert unless @user == current_user
  end

  def user_params
    params.require(:user).permit(
      :name, :nickname, :email, :password, :header_color, :password_confirmation
    )
  end    
end
