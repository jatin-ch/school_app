require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
    @course = courses(:one)
  end

  test "redirect if not logged in" do
    sign_out :user
    get school_courses_url(@course.school)
    assert_response :redirect
  end

  test "redirect if student logged in" do
    sign_out :user
    sign_in users(:student)
    get school_courses_url(@course.school)
    assert_response :redirect
  end

  # GET /schools/1/courses
  test "should get index" do
    get school_courses_url(@course.school)
    assert_response :success
  end
  test "school_admin should not get index for another school" do
    sign_out :user
    sign_in users(:school_admin)
    get school_courses_url(@course.school)
    assert_response :redirect
  end
  test "school_admin should get index" do
    sign_out :user
    sign_in users(:school_admin)
    @course = courses(:two)
    get school_courses_url(@course.school)
    assert_response :success
  end
  test "student should not get index" do
    sign_out :user
    sign_in users(:student)
    get school_courses_url(@course.school)
    assert_response :redirect
  end

  # GET /schools/1/courses/new
  test "should get new" do
    get new_school_course_url(@course.school)
    assert_response :success
  end
  test "school_admin should not get new for another school" do
    sign_out :user
    sign_in users(:school_admin)
    get new_school_course_url(@course.school)
    assert_response :redirect
  end
  test "school_admin should get new" do
    sign_out :user
    sign_in users(:school_admin)
    @course = courses(:two)
    get new_school_course_url(@course.school)
    assert_response :success
  end
  test "student should not get new" do
    sign_out :user
    sign_in users(:student)
    get new_school_course_url(@course.school)
    assert_response :redirect
  end

  # POST /schools/1/courses
  test "should create course" do
    assert_difference('Course.count') do
      post school_courses_url(@course.school), params: { course: { name: 'Course 1' } }
    end

    assert_redirected_to school_course_url(@course.school, Course.last)
  end
  test "school_admin should not create course for another school" do
    sign_out :user
    sign_in users(:school_admin)
    assert_no_difference('Course.count') do
      post school_courses_url(@course.school), params: { course: { name: 'Course 1' } }
    end

    assert_redirected_to root_url
  end
  test "school_admin should create course" do
    sign_out :user
    sign_in users(:school_admin)
    @course = courses(:two)
    assert_difference('Course.count') do
      post school_courses_url(@course.school), params: { course: { name: 'Course 1' } }
    end

    assert_redirected_to school_course_url(@course.school, Course.last)
  end
  test "student should not create course" do
    sign_out :user
    sign_in users(:student)
    assert_no_difference('Course.count') do
      post school_courses_url(@course.school), params: { course: { name: 'Course 1' } }
    end

    assert_redirected_to root_url
  end

  # GET /schools/1/courses/1
  test "should show course" do
    get school_course_url(@course.school, @course)
    assert_response :success
  end
  test "school_admin should not show another school course" do
    sign_out :user
    sign_in users(:school_admin)
    get school_course_url(@course.school, @course)
    assert_response :redirect
  end
  test "school_admin should show course" do
    sign_out :user
    sign_in users(:school_admin)
    @course = courses(:two)
    get school_course_url(@course.school, @course)
    assert_response :success
  end
  test "student should not show course" do
    sign_out :user
    sign_in users(:student)
    get school_course_url(@course.school, @course)
    assert_response :redirect
  end

  # GET /schools/1/courses/1/edit
  test "should get edit" do
    get edit_school_course_url(@course.school, @course)
    assert_response :success
  end
  test "school_admin should not edit another school course" do
    sign_out :user
    sign_in users(:school_admin)
    get edit_school_course_url(@course.school, @course)
    assert_response :redirect
  end
  test "school_admin should edit course" do
    sign_out :user
    sign_in users(:school_admin)
    @course = courses(:two)
    get edit_school_course_url(@course.school, @course)
    assert_response :success
  end
  test "student should not edit course" do
    sign_out :user
    sign_in users(:student)
    get edit_school_course_url(@course.school, @course)
    assert_response :redirect
  end

  # PATCH /schools/1/courses/1
  test "should update course" do
    patch school_course_url(@course.school, @course), params: { course: { name: 'Course 1 - New' } }
    assert_redirected_to school_course_url(@course.school, @course)
  end
  test "school_admin should not update another course" do
    sign_out :user
    sign_in users(:school_admin)
    patch school_course_url(@course.school, @course), params: { course: { name: 'Course 1 - New' } }
    assert_redirected_to root_url
  end
  test "school_admin should update course" do
    sign_out :user
    sign_in users(:school_admin)
    @course = courses(:two)
    patch school_course_url(@course.school, @course), params: { course: { name: 'Course 1 - New' } }
    assert_redirected_to school_course_url(@course.school, @course)
  end
  test "student should not update course" do
    sign_out :user
    sign_in users(:student)
    patch school_course_url(@course.school, @course), params: { course: { name: 'Course 1 - New' } }
    assert_redirected_to root_url
  end

  # DELETE /schools/1/courses/1
  test "should delete course" do
    assert_difference('Course.count', -1) do
      delete school_course_url(@course.school, @course)
    end
    assert_redirected_to school_courses_url(@course.school)
  end
  test "school_admin should not delete another course" do
    sign_out :user
    sign_in users(:school_admin)
    assert_no_difference('Course.count') do
      delete school_course_url(@course.school, @course)
    end
    assert_redirected_to root_url
  end
  test "school_admin should delete course" do
    sign_out :user
    sign_in users(:school_admin)
    @course = courses(:two)
    assert_difference('Course.count', -1) do
      delete school_course_url(@course.school, @course)
    end
    assert_redirected_to school_courses_url(@course.school)
  end
  test "student should not delete course" do
    sign_out :user
    sign_in users(:student)
    assert_no_difference('Course.count') do
      delete school_course_url(@course.school, @course)
    end
    assert_redirected_to root_url
  end
end
