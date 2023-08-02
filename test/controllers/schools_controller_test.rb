require "test_helper"

class SchoolsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
    @school = schools(:one)
  end

  test "redirect if not logged in" do
    sign_out :user
    get schools_url
    assert_response :redirect
  end

  test "redirect if student logged in" do
    sign_out :user
    sign_in users(:student)
    get schools_url
    assert_response :redirect
  end

  # GET /schools
  test "should get index" do
    get schools_url
    assert_response :success
  end
  test "school_admin should get index" do
    sign_out :user
    sign_in users(:school_admin)
    get schools_url
    assert_response :success
  end
  test "student should not get index" do
    sign_out :user
    sign_in users(:student)
    get schools_url
    assert_response :redirect
  end

  # GET schools/new
  test "should get new" do
    get new_school_url
    assert_response :success
  end
  test "school_admin should not get new" do
    sign_out :user
    sign_in users(:school_admin)
    get new_school_url
    assert_response :redirect
  end
  test "student should not get new" do
    sign_out :user
    sign_in users(:student)
    get new_school_url
    assert_response :redirect
  end

  # POST /schools
  test "should create school" do
    assert_difference('School.count') do
      post schools_url, params: { school: { name: 'School 1', user_id: users(:school_admin).id } }
    end

    assert_redirected_to school_url(School.last)
  end
  test "school_admin should not create school" do
    sign_out :user
    sign_in users(:school_admin)
    assert_no_difference('School.count') do
      post schools_url, params: { school: { name: 'School 1', user_id: users(:school_admin).id } }
    end

    assert_redirected_to root_url
  end
  test "student should not create school" do
    sign_out :user
    sign_in users(:student)
    assert_no_difference('School.count') do
      post schools_url, params: { school: { name: 'School 1', user_id: users(:school_admin).id } }
    end

    assert_redirected_to root_url
  end

  # GET /schools/1
  test "should show school" do
    get school_url(@school)
    assert_response :success
  end
  test "school_admin should not show another school" do
    sign_out :user
    sign_in users(:school_admin)
    get school_url(@school)
    assert_response :redirect
  end
  test "school_admin should show school" do
    sign_out :user
    sign_in users(:school_admin)
    @school = schools(:two)
    get school_url(@school)
    assert_response :success
  end
  test "student should not show school" do
    sign_out :user
    sign_in users(:student)
    get school_url(@school)
    assert_response :redirect
  end

  # GET /schools/1/edit
  test "should get edit" do
    get edit_school_url(@school)
    assert_response :success
  end
  test "school_admin should not edit another school" do
    sign_out :user
    sign_in users(:school_admin)
    get edit_school_url(@school)
    assert_response :redirect
  end
  test "school_admin should not edit school" do
    sign_out :user
    sign_in users(:school_admin)
    @school = schools(:two)
    get edit_school_url(@school)
    assert_response :success
  end
  test "student should not edit school" do
    sign_out :user
    sign_in users(:student)
    get edit_school_url(@school)
    assert_response :redirect
  end

  # PATCH /schools/1
  test "should update school" do
    patch school_url(@school), params: { school: { name: 'School 1, India' } }
    assert_redirected_to school_url(@school)
  end
  test "school_admin should update school" do
    sign_out :user
    sign_in users(:school_admin)
    @school = schools(:two)
    patch school_url(@school), params: { school: { name: 'School 1, India' } }
    assert_redirected_to school_url(@school)
  end
  test "school_admin should not update another school" do
    sign_out :user
    sign_in users(:school_admin)
    patch school_url(@school), params: { school: { name: 'School 1, India' } }
    assert_redirected_to root_url
  end
  test "student should not update school" do
    sign_out :user
    sign_in users(:student)
    patch school_url(@school), params: { school: { name: 'School 1, India' } }
    assert_redirected_to root_url
  end

  # DELETE /schools/1
  test "should delete school" do
    assert_difference('School.count', -1) do
      delete school_url(@school)
    end
    assert_redirected_to schools_url
  end
  test "school_admin should not delete school" do
    sign_out :user
    sign_in users(:school_admin)
    assert_no_difference('School.count') do
      delete school_url(@school)
    end
    assert_redirected_to root_url
  end
  test "student should not delete school" do
    sign_out :user
    sign_in users(:student)
    assert_no_difference('School.count') do
      delete school_url(@school)
    end
    assert_redirected_to root_url
  end
end
