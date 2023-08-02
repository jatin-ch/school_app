json.partial! "courses/course", course: @course
json.url school_courses_url(@school, format: :json)
