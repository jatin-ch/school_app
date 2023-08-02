require "test_helper"

class BatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
    @batch = batches(:one)
  end

  test "redirect if not logged in" do
    sign_out :user
    get school_course_batches_url(@batch.course.school, @batch.course)
    assert_response :redirect
  end

  test "redirect if student logged in" do
    sign_out :user
    sign_in users(:student)
    get school_course_batches_url(@batch.course.school, @batch.course)
    assert_response :redirect
  end

  # GET /schools/1/courses/1/batches
  test "should get index" do
    get school_course_batches_url(@batch.course.school, @batch.course)
    assert_response :success
  end
  test "school_admin should not get index for another school course" do
    sign_out :user
    sign_in users(:school_admin)
    get school_course_batches_url(@batch.course.school, @batch.course)
    assert_response :redirect
  end
  test "school_admin should get index" do
    sign_out :user
    sign_in users(:school_admin)
    @batch = batches(:two)
    get school_course_batches_url(@batch.course.school, @batch.course)
    assert_response :success
  end
  test "student should not get index" do
    sign_out :user
    sign_in users(:student)
    get school_course_batches_url(@batch.course.school, @batch.course)
    assert_response :redirect
  end

  # GET /schools/1/courses/1/batches/new
  test "should get new" do
    get new_school_course_batch_url(@batch.course.school, @batch.course)
    assert_response :success
  end
  test "school_admin should not get new for another school course" do
    sign_out :user
    sign_in users(:school_admin)
    get new_school_course_batch_url(@batch.course.school, @batch.course)
    assert_response :redirect
  end
  test "school_admin should get new" do
    sign_out :user
    sign_in users(:school_admin)
    @batch = batches(:two)
    get new_school_course_batch_url(@batch.course.school, @batch.course)
    assert_response :success
  end
  test "student should not get new" do
    sign_out :user
    sign_in users(:student)
    get new_school_course_batch_url(@batch.course.school, @batch.course)
    assert_response :redirect
  end

  # POST /schools/1/courses/1/batches
  test "should create batch" do
    assert_difference('Batch.count') do
      post school_course_batches_url(@batch.course.school, @batch.course), params: { batch: { name: 'Batch 1', size: 30, start_date: Date.today, end_date: (Date.today + 30.days) } }
    end

    assert_redirected_to school_course_batch_url(@batch.course.school, @batch.course, Batch.last)
  end
  test "school_admin should not create batch for another school course" do
    sign_out :user
    sign_in users(:school_admin)
    assert_no_difference('Batch.count') do
      post school_course_batches_url(@batch.course.school, @batch.course), params: { batch: { name: 'Batch 1', size: 30, start_date: Date.today, end_date: (Date.today + 30.days) } }
    end

    assert_redirected_to root_url
  end
  test "school_admin should create batch" do
    sign_out :user
    sign_in users(:school_admin)
    @batch = batches(:two)
    assert_difference('Batch.count') do
      post school_course_batches_url(@batch.course.school, @batch.course), params: { batch: { name: 'Batch 2', size: 30, start_date: Date.today, end_date: (Date.today + 30.days) } }
    end

    assert_redirected_to school_course_batch_url(@batch.course.school, @batch.course, Batch.last)
  end
  test "student should not create course" do
    sign_out :user
    sign_in users(:student)
    assert_no_difference('Batch.count') do
      post school_course_batches_url(@batch.course.school, @batch.course), params: { batch: { name: 'Batch 1', size: 30, start_date: Date.today, end_date: (Date.today + 30.days) } }
    end

    assert_redirected_to root_url
  end

  # GET /schools/1/courses/1/batches/1
  test "should show batch" do
    get school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_response :success
  end
  test "school_admin should not show batch for another school course" do
    sign_out :user
    sign_in users(:school_admin)
    get school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_response :redirect
  end
  test "school_admin should show batch" do
    sign_out :user
    sign_in users(:school_admin)
    @batch = batches(:two)
    get school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_response :success
  end
  test "student should not show batch" do
    sign_out :user
    sign_in users(:student)
    get school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_response :redirect
  end

  # GET /schools/1/courses/1/batches/1/edit
  test "should get edit" do
    get edit_school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_response :success
  end
  test "school_admin should not edit another school course batch" do
    sign_out :user
    sign_in users(:school_admin)
    get edit_school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_response :redirect
  end
  test "school_admin should edit batch" do
    sign_out :user
    sign_in users(:school_admin)
    @batch = batches(:two)
    get edit_school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_response :success
  end
  test "student should not edit batch" do
    sign_out :user
    sign_in users(:student)
    get edit_school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_response :redirect
  end

  # PATCH /schools/1/courses/1/batches/1
  test "should update course" do
    patch school_course_batch_url(@batch.course.school, @batch.course, @batch), params: { batch: { name: 'Batch 1 - New' } }
    assert_redirected_to school_course_batch_url(@batch.course.school, @batch.course, @batch)
  end
  test "school_admin should not update another course" do
    sign_out :user
    sign_in users(:school_admin)
    patch school_course_batch_url(@batch.course.school, @batch.course, @batch), params: { batch: { name: 'Batch 1 - New' } }
    assert_redirected_to root_url
  end
  test "school_admin should update batch" do
    sign_out :user
    sign_in users(:school_admin)
    @batch = batches(:two)
    patch school_course_batch_url(@batch.course.school, @batch.course, @batch), params: { batch: { name: 'Batch 2 - New' } }
    assert_redirected_to school_course_batch_url(@batch.course.school, @batch.course, @batch)
  end
  test "student should not update batch" do
    sign_out :user
    sign_in users(:student)
    patch school_course_batch_url(@batch.course.school, @batch.course, @batch), params: { batch: { name: 'Batch 1 - New' } }
    assert_redirected_to root_url
  end

  # DELETE /schools/1/courses/1/batches/1
  test "should delete course" do
    assert_difference('Batch.count', -1) do
      delete school_course_batch_url(@batch.course.school, @batch.course, @batch)
    end
    assert_redirected_to school_course_batches_url(@batch.course.school, @batch.course)
  end
  test "school_admin should not delete another course" do
    sign_out :user
    sign_in users(:school_admin)
    assert_no_difference('Batch.count') do
      delete school_course_batch_url(@batch.course.school, @batch.course, @batch)
    end
    assert_redirected_to root_url
  end
  test "school_admin should delete batch" do
    sign_out :user
    sign_in users(:school_admin)
    @batch = batches(:two)
    assert_difference('Batch.count', -1) do
      delete school_course_batch_url(@batch.course.school, @batch.course, @batch)
    end
    assert_redirected_to school_course_batches_url(@batch.course.school, @batch.course)
  end
  test "student should not delete batch" do
    sign_out :user
    sign_in users(:student)
    assert_no_difference('Batch.count') do
      delete school_course_batch_url(@batch.course.school, @batch.course, @batch)
    end
    assert_redirected_to root_url
  end
end
