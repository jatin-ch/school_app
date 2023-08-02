json.extract! course, :id, :name, :created_at, :updated_at

json.school { 
	json.id course.school.id
	json.name course.school.name 
	json.url school_url(@school, format: :json)
}

json.url school_course_url(@school, course, format: :json)
json.batches_url school_course_batches_url(@school, course, format: :json)

