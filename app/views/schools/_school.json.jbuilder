json.extract! school, :id, :name, :user_id, :created_at, :updated_at
json.url school_url(school, format: :json)
json.courses_url school_courses_url(school, format: :json)
