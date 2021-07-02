class TasksController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:index, :new, :show]
  before_action :admin_or_correct_user, only: [:edit, :update, :show]
    
    def index
      @tasks = Task.all
    end
    
    def new
      @task = Task.new
    end
    
    def create
      @task = Task.new(user_id: params[:id], work: params[:work], detail: params[:detail])
      if @task.save
        redirect_to task_index_url
        flash[:success] = "新規タスクを作成しました。"
      else
        flash[:danger] = "タスク作成に失敗しました。"
        render :new
      end
    end

    def show
      @task = Task.find(params[:task_id])
    end
    
    def edit
      @task = Task.find(params[:task_id])
    end
    
    def update
      @task = Task.find(params[:task_id])
      @task.work = params[:work]
      @task.detail = params[:detail]
      if @task.save
        redirect_to task_show_path
        flash[:success] = "タスクを編集しました。"
        else
        flash[:danger] = "タスクの編集に失敗しました。"
        render :edit
      end
    end
    
    def destroy
      @task = Task.find(params[:task_id])
      @task.destroy
      redirect_to task_index_url
      flash[:danger] = "タスクを削除しました。"
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
end
