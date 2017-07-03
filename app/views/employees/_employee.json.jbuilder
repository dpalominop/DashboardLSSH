json.extract! employee, :id, :name, :last_name, :username, :document, :area_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
