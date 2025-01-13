# frozen_string_literal: true

json.extract! task, :id, :name, :description, :status_id, :user_id, :created_at, :updated_at
json.url task_url(task, format: :json)
