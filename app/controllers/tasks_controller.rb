class TasksController < ApplicationController
  before_action :get_id_task, only: [:show, :edit, :update, :destroy]


  def index
    if params[:task]
      @tasks = current_user.tasks
                            .search_title(params.dig(:task, :title))
                            .search_status(params.dig(:task, :status))
                            .search_label(params.dig(:task, :label_id))
                            .group(:id)
                            .page(params[:page])

    elsif params[:sort_by_deadline]
      @tasks = current_user.tasks.page(params[:page]).order(deadline: :desc)

    elsif params[:sort_by_priority]
      @tasks = current_user.tasks.page(params[:page]).order(priority: :desc)

    else
      @tasks = current_user.tasks.page(params[:page]).order(created_at: :desc)
    end
      # if params[:task]
      #   binding.pry
      #   if params[:task][:title] && params[:task][:status]
      #     binding.pry
      #     @tasks = current_user.tasks.search_title_status(params[:task][:title].params[:task][:status])
      #   elsif params[:task][:title].present?
      #     binding.pry
      #     @tasks = current_user.tasks.search_title(params[:task][:title])
      #   elsif params[:task][:status].present?
      #     binding.pry
      #     @tasks = current_user.tasks.search_status(params[:task][:status])
      #   elsif params[:task][:label_id].present?
      #     binding.pry
      #     labelling = Labelling.where(label_id: params[:label_id])
      #     @tasks = current_user.tasks.where(id: labelling.pluck(:task_id))
      #   end
        # @tasks = Task.where("title LIKE ?", "%#{ params[:task][:title] }%").where(status: "#{ params[:task][:status] }")
      # end
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
    params.require(:task).permit(:title, :explanation, :deadline, :status, :search, :priority, :user_id, label_ids: [])
  end

  def get_id_task
    @task = current_user.tasks.find(params[:id])
  end
end
