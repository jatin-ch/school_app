json.partial! "batches/batch", batch: @batch
json.url school_course_batches_url(@school, @course, format: :json)
