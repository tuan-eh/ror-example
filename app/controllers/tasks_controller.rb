class TasksController < ApplicationController
  # 1. Tell Rails to run the `set_task` method before specific actions
  before_action :set_task, only: [ :edit, :update, :destroy ]

  # GET /projects/:project_id/tasks
  def index
    # 1. Find the project from the URL
    @project = Project.find(params[:project_id])

    # 2. Load only tasks for this project
    @tasks = @project.tasks

    # 3. Empty task for the form
    @task = Task.new
  end

  # POST /projects/:project_id/tasks
  def create
    @project = Project.find(params[:project_id])

    # Build the task directly through the project association
    @task = @project.tasks.build(task_params)

    if @task.save
      redirect_to project_tasks_path(@project), notice: "Task added!"
    else
      redirect_to project_tasks_path(@project), alert: "Failed to add task."
    end
  end

  # GET /tasks/:id/edit
  # Fetches the task and loads the edit page
  def edit
  end

  def update
    if @task.update(task_params)
      # 👈 Redirect to the nested project tasks list
      redirect_to project_tasks_path(@task.project), notice: "Task updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # 1. Grab the project before we destroy the task (so we know where to go back to)
    project = @task.project

    # 2. Destroy the task
    @task.destroy

    # 3. 👈 Redirect to the saved project
    redirect_to project_tasks_path(project), notice: "Task deleted!"
  end

  private

  # 2. Define the method here in the private section
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :completed, :project_id)
  end
end
