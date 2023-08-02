require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    sign_in users(:admin)
    @user = users(:one)
  end

  test "redirect to sign_in page if not logged in" do
    sign_out :user
    visit users_url
    assert_selector "h2", text: "Log in"
  end

  test "visiting profile" do
    visit profile_users_url
    assert_selector "strong", text: "Name:"
    click_on "Edit"
  end

  test "editing profile" do
    visit profile_edit_users_url
    assert_selector "h1", text: "Editing Profile"
  end

  test "updating profile" do
    visit profile_edit_users_url
    fill_in "Name", with: "My updated name"
    click_on "Update User"

    assert_current_path profile_users_url
    assert_text "Profile was successfully updated."
  end

  test "visiting enrollments as admin or school_admin" do
    visit enrollments_users_url
    assert_text "You are not authorized to access this page."

    sign_out :user
    sign_in users(:school_admin)
    visit enrollments_users_url
    assert_text "You are not authorized to access this page."
  end

  test "visiting enrollments" do
    sign_out :user
    sign_in users(:student)
    visit enrollments_users_url
    assert_selector "h1", text: "Enrollments"
    click_on "New Enrollment"
  end

  test "creating new enrollment" do
    sign_out :user
    sign_in users(:student)
    visit enrollments_new_users_url

    select(schools(:one).id, from: 'enrollment_school_id')
    select(courses(:one).id, from: 'enrollment_course_id')
    select(batches(:one).id, from: 'enrollment_batch_id')
    click_on "Create Enrollment"
    assert_current_path enrollments_users_url
    assert_text "Enrollment was successfully created."
  end 

  test "visiting an enrollment" do
    sign_out :user
    sign_in users(:one)
    visit enrollment_users_url(enrollments(:one))
    assert_selector "h1", text: "Classmates"
  end

  test "visiting index as school_admin or student" do
    sign_out :user
    sign_in users(:school_admin)
    visit users_url
    assert_text "You are not authorized to access this page."

    sign_out :user
    sign_in users(:student)
    visit users_url
    assert_text "You are not authorized to access this page."
  end

  test "visiting new as school_admin" do
    sign_out :user
    sign_in users(:school_admin)
    visit new_user_url
    assert_selector "h1", text: "New User"
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "visiting new" do
    visit new_user_url
    assert_selector "h1", text: "New User"
  end

  test "creating a student" do
    visit users_url
    click_on "New User"

    fill_in "Name", with: @user.name
    fill_in "Email", with: 'test_user@app.com'
    select("student", from: 'Kind')
    check "Active"
    click_on "Create User"

    assert_current_path user_path(User.last)
    assert_text "User was successfully created."
    click_on "Back"
  end

  test "creating an school_admin" do
    visit users_url
    click_on "New User"

    fill_in "Name", with: @user.name
    fill_in "Email", with: 'test_user@app.com'
    select("school_admin", from: 'Kind')
    check "Active"
    click_on "Create User"

    assert_current_path user_path(User.last)
    assert_text "User was successfully created."
    click_on "Back"
  end

  test "visiting show" do
    visit user_url(@user)
    assert_selector "strong", text: "Name"
    click_on "Edit"
  end

  test "visiting edit" do
    visit edit_user_url(@user)
    assert_selector "h1", text: "Editing User"
  end

  test "updating a user" do
    visit edit_user_url(@user)

    fill_in "Name", with: "Name updated"
    click_on "Update User"

    assert_current_path user_path(@user)
    assert_text "User was successfully updated."
    click_on "Back"
  end

  test "deleting a user" do
    visit user_url(users(:one))

    click_on "Delete User"

    assert_current_path users_path
    assert_text "User was successfully destroyed."
  end

end
