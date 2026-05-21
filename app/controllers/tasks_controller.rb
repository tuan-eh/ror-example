class TasksController < ApplicationController
  # GET /tasks
  def index
    @tasks = Task.all
    @task = Task.new # For the form to create a new task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      redirect_to tasks_path, alert: "Failed to create task: " + @task.errors.full_messages.to_sentence
    end
  end

  # DELETE /tasks/:id
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "Task was successfully deleted."
  end

  # PATCH/PUT /tasks/:id
  def update
    # 1. Find the specific task using the ID from the URL
    @task = Task.find(params[:id])

    # 2. Toggle the boolean (if true make false, if false make true)
    new_status = !@task.completed

    # 3. Update the database and save
    @task.update(completed: new_status)

    # 4. Refresh the page
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :completed)
  end
end
