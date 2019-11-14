class TasksController < ApplicationController
  before_action :get_id_task, only: [:show, :edit, :update, :destroy]


  def index
    if logged_in?
      @tasks = Task.page(params[:page]).order(created_at: :desc)

      if params[:sort_by_deadline]
        @tasks = Task.page(params[:page]).order(deadline: :desc)
      end

      if params[:sort_by_priority]
        @tasks = Task.page(params[:page]).order(priority: :desc)
      end

      if params[:task]
        if params[:task][:title] && params[:task][:status]
          @tasks = Task.search_title_status(params[:task][:title],params[:task][:status])
        elsif params[:task][:title].present?
          @tasks = Task.search_title(params[:task][:title])
        elsif params[:task][:status].present?
          @tasks = Task.search_status(params[:task][:status])
        end
        # @tasks = Task.where("title LIKE ?", "%#{ params[:task][:title] }%").where(status: "#{ params[:task][:status] }")
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to task_path(@task), notice: "タスクを登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:  "タスクを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :explanation, :deadline, :status, :search, :priority, :user_id)
  end

  def get_id_task
    @task = Task.find(params[:id])
  end

end
