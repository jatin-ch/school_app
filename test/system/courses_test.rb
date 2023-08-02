require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    sign_in users(:school_admin)
    @course = courses(:two)
  end

  test "redirect to sign_in page if not logged in" do
    sign_out :user
    visit users_url
    assert_selector "h2", text: "Log in"
  end

  test "visiting courses" do
    visit school_courses_url(@course.school)
    assert_selector "h1", text: "Courses"
  end

  test "create new course" do
    visit school_courses_url(@course.school)
    assert_selector "h1", text: "Courses"
    click_on "New Course"

    fill_in "Name", with: "Test Course"
    check "Active"
    click_on "Create Course"

    assert_current_path school_course_url(Course.last.school, Course.last)
    assert_text "Course was successfully created."
  end

  test "visiting course" do
    visit school_course_url(@course.school, @course)
    assert_selector "strong", text: "Name:"
  end

  test "visiting unauthorized course" do
    @course = courses(:one)
    visit school_course_url(@course.school, @course)
    assert_text "You are not authorized to access this page."
  end

  test "updating a course" do
    visit school_course_url(@course.school, @course)
    click_on "Edit"

    fill_in "Name", with: "Update Test Course"
    click_on "Update Course"

    assert_current_path school_course_url(@course.school, @course)
    assert_text "Course was successfully updated."
  end

  test "deleting a course" do
    visit school_course_url(@course.school, @course)
    click_on "Delete Course"

    assert_current_path school_courses_url(@course.school)
    assert_text "Course was successfully destroyed."
  end

  test "visiting batches" do
    visit school_course_url(@course.school, @course)
    click_on "List"
    assert_selector "h1", text: "Batches"
  end
end