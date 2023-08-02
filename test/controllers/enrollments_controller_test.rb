require "test_helper"

class EnrollmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
    @enrollment = enrollments(:one)
  end

  # GET /schools/1/courses/1/batches/1/enrollments
  test "redirect if not logged in" do
    sign_out :user
    get school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_response :redirect
  end

  # GET /schools/1/courses/1/batches/1/enrollments
  test "redirect if student logged in" do
    sign_out :user
    sign_in users(:student)
    get school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_response :redirect
  end

  # GET /schools/1/courses/1/batches/1/enrollments
  test "should get index" do
    get school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_response :success
  end
  test "school_admin should not get index for unauthorized enrollments" do
    sign_out :user
    sign_in users(:school_admin)
    get school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_response :redirect
  end
  test "school_admin should get index" do
    sign_out :user
    sign_in users(:school_admin)
    @enrollment = enrollments(:two)
    get school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_response :success
  end
  test "student should not get index" do
    sign_out :user
    sign_in users(:student)
    get school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_response :redirect
  end

  # # GET /schools/1/courses/1/batches/1/enrollments/new
  test "should get new" do
    get new_school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_response :success
  end
  test "school_admin should not get new for unauthorized page" do
    sign_out :user
    sign_in users(:school_admin)
    get new_school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_response :redirect
  end
  test "school_admin should get new" do
    sign_out :user
    sign_in users(:school_admin)
    @enrollment = enrollments(:two)
    get new_school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_response :success
  end
  test "student should not get new" do
    sign_out :user
    sign_in users(:student)
    get new_school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_response :redirect
  end

  # # POST /schools/1/courses/1/batches/1/enrollments
  test "should create enrollment" do
    assert_difference('Enrollment.count') do
      post school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch), params: { enrollment: { user_id: 5, status: 0 } }
    end

    assert_redirected_to school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, Enrollment.last)
  end
  test "school_admin should not create enrollment for unauthorized page" do
    sign_out :user
    sign_in users(:school_admin)
    assert_no_difference('Enrollment.count') do
      post school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch), params: { enrollment: { user_id: 5, status: 0 } }
    end

    assert_redirected_to root_url
  end
  test "school_admin should create enrollment" do
    sign_out :user
    sign_in users(:school_admin)
    @enrollment = enrollments(:two)
    assert_difference('Enrollment.count') do
      post school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch), params: { enrollment: { user_id: 6, status: 0 } }
    end

    assert_redirected_to school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, Enrollment.last)
  end
  test "student should not create enrollment" do
    sign_out :user
    sign_in users(:student)
    assert_no_difference('Enrollment.count') do
      post school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch), params: { enrollment: { user_id: 4, status: 0 } }
    end

    assert_redirected_to root_url
  end

  # GET /schools/1/courses/1/batches/1/enrollments/1
  test "should show batch" do
    get school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_response :success
  end
  test "school_admin should not show for unauthorized page" do
    sign_out :user
    sign_in users(:school_admin)
    get school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_response :redirect
  end
  test "school_admin should show batch" do
    sign_out :user
    sign_in users(:school_admin)
    @enrollment = enrollments(:two)
    get school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_response :success
  end
  test "student should not show batch" do
    sign_out :user
    sign_in users(:student)
    get school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_response :redirect
  end

  # GET /schools/1/courses/1/batches/1/enrollments/1/edit
  test "should get edit" do
    get edit_school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_response :success
  end
  test "school_admin should not edit unauthorized page" do
    sign_out :user
    sign_in users(:school_admin)
    get edit_school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_response :redirect
  end
  test "school_admin should edit batch" do
    sign_out :user
    sign_in users(:school_admin)
    @enrollment = enrollments(:two)
    get edit_school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_response :success
  end
  test "student should not edit batch" do
    sign_out :user
    sign_in users(:student)
    get edit_school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_response :redirect
  end

  # PATCH /schools/1/courses/1/batches/1/enrollments/1
  test "should update course" do
    patch school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment), params: { enrollment: { status: 1 } }
    assert_redirected_to school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
  end
  test "school_admin should not update unauthorized page" do
    sign_out :user
    sign_in users(:school_admin)
    patch school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment), params: { enrollment: { status: 1 } }
    assert_redirected_to root_url
  end
  test "school_admin should update batch" do
    sign_out :user
    sign_in users(:school_admin)
    @enrollment = enrollments(:two)
    patch school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment), params: { enrollment: { status: 1 } }
    assert_redirected_to school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
  end
  test "student should not update batch" do
    sign_out :user
    sign_in users(:student)
    patch school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment), params: { enrollment: { status: 1 } }
    assert_redirected_to root_url
  end

  # DELETE /schools/1/courses/1/batches/1/enrollments/1
  test "should delete course" do
    assert_difference('Enrollment.count', -1) do
      delete school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    end
    assert_redirected_to school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
  end
  test "school_admin should not delete unauthorized page" do
    sign_out :user
    sign_in users(:school_admin)
    assert_no_difference('Enrollment.count') do
      delete school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    end
    assert_redirected_to root_url
  end
  test "school_admin should delete batch" do
    sign_out :user
    sign_in users(:school_admin)
    @enrollment = enrollments(:two)
    assert_difference('Enrollment.count', -1) do
      delete school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    end
    assert_redirected_to school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
  end
  test "student should not delete batch" do
    sign_out :user
    sign_in users(:student)
    assert_no_difference('Enrollment.count') do
      delete school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    end
    assert_redirected_to root_url
  end
end
