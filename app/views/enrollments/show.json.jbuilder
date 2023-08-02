json.partial! "enrollments/enrollment", enrollment: @enrollment
json.url school_course_batch_enrollments_url(@school, @course, @batch, format: :json)
