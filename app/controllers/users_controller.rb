class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :current_user, only: [:show, :edit, :update]
  before_action :admin_or_correct_user, only: [:edit, :update, :show]

  def index
    @current_user = User.find(session[:user_id])
    if @current_user.admin?
      @users = User.paginate(page: params[:page], per_page: 20)
    else
      redirect_to(root_url)
      flash[:danger] = "権限がありません。"
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @current_user = User.find(session[:user_id])
    unless @current_user.admin?
      if logged_in?
        redirect_to user_path(current_user.id)
        flash[:success] = "すでにログイン済です。"
      end
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
    flash[:success] = "ユーザーを削除しました。"
  end

  # beforeフィルター

  # ログイン済みのユーザーか確認します。
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def admin_or_correct_user
    @user = User.find(params[:id]) if @user.blank?
    @current_user = User.find(session[:user_id])
    unless @current_user.id == @user.id || @current_user.admin?
      redirect_to(root_url)
      flash[:danger] = "権限がありません。"
    end
  end
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
