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

  # GET /tasks/:id/edit
  # Fetches the task and loads the edit page
  def edit
    @task = Task.find(params[:id])
  end

  # PATCH /tasks/:id
  # Saves the changes to the database (handles both title edits AND toggles)
  def update
    @task = Task.find(params[:id])

    # task_params will automatically pick up the new title OR the new status
    if @task.update(task_params)
      redirect_to root_path, notice: "Task updated successfully!"
    else
      # If validation fails (e.g., empty title), re-render the edit form
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :completed, :project_id)
  end
end
