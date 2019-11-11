class TasksController < ApplicationController
  before_action :get_id_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)

    if params[:sort_by_deadline]
	     @tasks = Task.all.order(deadline: :desc)
	  end

    if params[:sort_by_priority]
	     @tasks = Task.all.order(priority: :desc)
	  end

    if params[:task]
       @tasks = Task.where("title LIKE ?", "%#{ params[:task][:title] }%").where(status: "#{ params[:task][:status] }")
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:title, :explanation, :deadline, :status, :search, :priority)
  end

  def get_id_task
    @task = Task.find(params[:id])
  end
end
