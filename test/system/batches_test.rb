require "application_system_test_case"

class BatchesTest < ApplicationSystemTestCase
  setup do
    sign_in users(:school_admin)
    @batch = batches(:two)
  end

  test "redirect to sign_in page if not logged in" do
    sign_out :user
    visit schools_url
    assert_selector "h2", text: "Log in"
  end

  test "visiting batches" do
    visit school_course_batches_url(@batch.course.school, @batch.course)
    assert_selector "h1", text: "Batches"
  end

  test "create new batch" do
    visit school_course_batches_url(@batch.course.school, @batch.course)
    assert_selector "h1", text: "Batches"
    click_on "New Batch"

    fill_in "Name", with: "Test Batch"
    fill_in "Size", with: 30
    select('2023', from: 'batch_start_date_1i')
    select('August', from: 'batch_start_date_2i')
    select('31', from: 'batch_start_date_3i')
    select('2023', from: 'batch_end_date_1i')
    select('October', from: 'batch_end_date_2i')
    select('15', from: 'batch_end_date_3i')
    select(@batch.status, from: 'Status')
    click_on "Create Batch"

    @batch = Batch.last
    assert_current_path school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_text "Batch was successfully created."
  end

  test "visiting batch" do
    visit school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_selector "strong", text: "Name:"
  end

  test "visiting unauthorized batch" do
    @batch = batches(:one)
    visit school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_text "You are not authorized to access this page."
  end

  test "updating a batch" do
    visit school_course_batch_url(@batch.course.school, @batch.course, @batch)
    click_on "Edit"

    fill_in "Name", with: "Update Test Batch"
    click_on "Update Batch"

    assert_current_path school_course_batch_url(@batch.course.school, @batch.course, @batch)
    assert_text "Batch was successfully updated."
  end

  test "deleting a batch" do
    visit school_course_batch_url(@batch.course.school, @batch.course, @batch)
    click_on "Delete Batch"

    assert_current_path school_course_batches_url(@batch.course.school, @batch.course)
    assert_text "Batch was successfully destroyed."
  end

  test "visiting enrollments" do
    visit school_course_batch_url(@batch.course.school, @batch.course, @batch)
    click_on "List"
    assert_selector "h1", text: "Enrollments"
  end
end