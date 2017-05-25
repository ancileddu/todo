json.extract! task, :id, :owner, :value, :completed, :category, :date, :assignee, :created_at, :updated_at
json.url task_url(task, format: :json)