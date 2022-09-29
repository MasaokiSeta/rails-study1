class TasksController < ApplicationController

  before_action :set_tasks, only: [:show, :edit, :update, :destroy]
  
  def index
    # インスタンス変数はview側でもアクセス出来る筈
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end
  end

  def show
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def new
    @task = Task.new
    @tasks = current_user.tasks.order(created_at: :desc)
    render :index if false
  end

  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))
    
    if params[:back].present?
      render :new
      return
    end

    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      #TaskMailer.creation_email(@task).deliver_later(wait: 1.minutes)
      SampleJob.perform_later
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: "タスクを追加しました"
  end

  private 

  def task_params
    params.require(:task).permit(:name, :description, :image)
  end

  def set_tasks
    @task = current_user.tasks.find(params[:id])
  end
end
