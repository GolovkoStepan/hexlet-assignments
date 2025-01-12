# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'New task was successfully created'
      redirect_to task_path(@task)
    else
      flash[:failure] = 'Task cannot be created'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task was successfully updated'
      redirect_to task_path(@task)
    else
      flash[:failure] = 'Task cannot be updated'
      render :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = 'Task was successfully deleted'
      redirect_to tasks_path
    else
      flash[:failure] = 'Task cannot be deleted'
      redirect_to task_path(@article)
    end
  end

  private

  def task_params
    params.required(:task).permit(:name, :description, :creator, :performer, :status)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
