json.extract! enrollment, :id, :status, :created_at, :updated_at

json.user { 
	json.id enrollment.user.id
	json.name enrollment.user.name 
}

json.batch { 
	json.id enrollment.batch.id
	json.name enrollment.batch.name
	json.url school_course_batch_url(@school, @course, @batch, format: :json)
}

json.url school_course_batch_enrollment_url(@school, @course, @batch, enrollment, format: :json)