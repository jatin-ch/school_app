require "application_system_test_case"

class EnrollmentsTest < ApplicationSystemTestCase
  setup do
    sign_in users(:school_admin)
    @enrollment = enrollments(:two)
  end

  test "redirect to sign_in page if not logged in" do
    sign_out :user
    visit schools_url
    assert_selector "h2", text: "Log in"
  end

  test "visiting enrollments" do
    visit school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_selector "h1", text: "Enrollments"
  end

  test "create new enrollment" do
    visit school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_selector "h1", text: "Enrollments"
    click_on "New Enrollment"
    select(users(:three).name, from: 'User')
    select('pending', from: 'Status')
    click_on "Create Enrollment"

    @enrollment = Enrollment.last
    assert_current_path school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_text "Enrollment was successfully created."
  end

  test "visiting enrollment" do
    visit school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_selector "strong", text: "User:"
  end

  test "visiting unauthorized enrollment" do
    @enrollment = enrollments(:one)
    visit school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_text "You are not authorized to access this page."
  end

  test "updating an enrollment" do
    visit school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    click_on "Edit"

    select('accepted', from: 'Status')
    click_on "Update Enrollment"

    assert_current_path school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)
    assert_text "Enrollment was successfully updated."
  end

  test "deleting an enrollment" do
    visit school_course_batch_enrollment_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch, @enrollment)

    click_on "Delete Enrollment"

    assert_current_path school_course_batch_enrollments_url(@enrollment.batch.course.school, @enrollment.batch.course, @enrollment.batch)
    assert_text "Enrollment was successfully destroyed."
  end
end