json.extract! network_element, :id, :name, :description, :ip, :port, :created_at, :updated_at
json.url network_element_url(network_element, format: :json)
