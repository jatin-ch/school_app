require "application_system_test_case"

class SchoolsTest < ApplicationSystemTestCase
  setup do
    sign_in users(:school_admin)
    @school = schools(:two)
  end

  test "redirect to sign_in page if not logged in" do
    sign_out :user
    visit schools_url
    assert_selector "h2", text: "Log in"
  end

  test "visiting schools" do
    visit schools_url
    assert_selector "h1", text: "Schools"
  end

  test "create new school" do
    visit new_school_url
    assert_text "You are not authorized to access this page."

    sign_out :user
    sign_in users(:admin)

    visit schools_url
    assert_selector "h1", text: "Schools"
    click_on "New School"

    fill_in "Name", with: "Test School"
    select(users(:school_admin).name, from: 'User')
    click_on "Create School"

    assert_current_path school_url(School.last)
    assert_text "School was successfully created."
  end

  test "visiting school" do
    visit school_url(@school)
    assert_selector "strong", text: "Name:"
  end

  test "visiting unauthorized school" do
    visit school_url(schools(:one))
    assert_text "You are not authorized to access this page."
  end

  test "updating a school" do
    visit school_url(@school)
    click_on "Edit"

    fill_in "Name", with: "Update Test School"
    click_on "Update School"

    assert_current_path school_url(@school)
    assert_text "School was successfully updated."
  end

  test "deleting a school" do
    sign_out :user
    sign_in users(:admin)
    
    visit school_url(@school)
    click_on "Delete School"

    assert_current_path schools_url
    assert_text "School was successfully destroyed."
  end

  test "visiting courses" do
    visit school_url(@school)
    click_on "List"
    assert_selector "h1", text: "Courses"
  end
end