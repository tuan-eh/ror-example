class ProjectsController < ApplicationController
  before_action :set_project, only: [ :edit, :update, :destroy ]

  # GET / (Root page)
  def index
    @projects = Project.all
    @project = Project.new # For the form to create a new project
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to root_path, notice: "Project created!"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to root_path, notice: "Project updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to root_path, notice: "Project deleted!"
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
