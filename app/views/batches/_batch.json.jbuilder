json.extract! batch, :id, :name, :size, :status, :created_at, :updated_at

json.start_date batch.start_date.strftime("%d %B %Y")
json.end_date batch.end_date.strftime("%d %B %Y")
json.course { 
	json.id batch.course.id
	json.name batch.course.name 
	json.url school_course_url(@school, @course, format: :json)
}

json.url school_course_batch_url(@school, @course, batch, format: :json)
json.batches_url school_course_batch_enrollments_url(@school, @course, batch, format: :json)
