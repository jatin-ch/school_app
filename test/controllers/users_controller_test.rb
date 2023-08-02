require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
    @user = users(:one)
  end

  # GET users/profile
  test "redirect if not logged in" do
    sign_out :user
    get profile_users_url
    assert_response :redirect
  end

  # GET users/enrollments
  test "should not get enrollments" do
    get enrollments_users_url
    assert_response :redirect
  end
  test "school_admin should not get enrollments" do
    sign_out :user
    sign_in users(:school_admin)
    get enrollments_users_url
    assert_response :redirect
  end
  test "student should get enrollments" do
    sign_out :user
    sign_in users(:student)
    get enrollments_users_url
    assert_response :success
  end

  # GET users/enrollments/new
  test "should not get new enrollment" do
    get enrollments_new_users_url
    assert_response :redirect
  end
  test "school_admin should not get new enrollment" do
    sign_out :user
    sign_in users(:school_admin)
    get enrollments_new_users_url
    assert_response :redirect
  end
  test "student should get new enrollment" do
    sign_out :user
    sign_in users(:one)
    get enrollments_new_users_url
    assert_response :success
  end

  # GET users/enrollments/1
  test "should not get enrollment" do
    get enrollment_users_url(enrollments(:one))
    assert_response :redirect
  end
  test "school_admin should not get enrollment" do
    sign_out :user
    sign_in users(:school_admin)
    get enrollment_users_url(enrollments(:one))
    assert_response :redirect
  end
  test "student should get enrollment" do
    sign_out :user
    sign_in users(:one)
    get enrollment_users_url(enrollments(:one))
    assert_response :success
  end
  test "student should not get unauthorized enrollment" do
    sign_out :user
    sign_in users(:one)
    get enrollment_users_url(enrollments(:two))
    assert_response :redirect
  end

  # GET users/profile
  test "should get profile" do
    get profile_users_url
    assert_response :success
  end
  test "school_admin should get profile" do
    sign_out :user
    sign_in users(:school_admin)
    get profile_users_url
    assert_response :success
  end
  test "student should get profile" do
    sign_out :user
    sign_in users(:student)
    get profile_users_url
    assert_response :success
  end

  # GET users/profile/edit
  test "should edit profile" do
    get profile_edit_users_url
    assert_response :success
  end
  test "school_admin should edit profile" do
    sign_out :user
    sign_in users(:school_admin)
    get profile_edit_users_url
    assert_response :success
  end
  test "student should edit profile" do
    sign_out :user
    sign_in users(:student)
    get profile_edit_users_url
    assert_response :success
  end

  # POST users/profile
  test "should update profile" do
    post profile_users_url, params: { user: { name: 'Jatin Choudhary' } }
    assert_redirected_to profile_users_url
  end
  test "school_admin should update profile" do
    sign_out :user
    sign_in users(:school_admin)
    post profile_users_url, params: { user: { name: 'Jatin Choudhary' } }
    assert_redirected_to profile_users_url
  end
  test "student should update profile" do
    sign_out :user
    sign_in users(:student)
    post profile_users_url, params: { user: { name: 'Jatin Choudhary' } }
    assert_redirected_to profile_users_url
  end

  # GET /users
  test "should get index" do
    get users_url
    assert_response :success
  end
  test "school_admin should not get index" do
    sign_out :user
    sign_in users(:school_admin)
    get users_url
    assert_response :redirect
  end
  test "student should not get index" do
    sign_out :user
    sign_in users(:student)
    get users_url
    assert_response :redirect
  end

  # GET users/new
  test "should get new" do
    get new_user_url
    assert_response :success
  end
  test "school_admin should get new" do
    sign_out :user
    sign_in users(:school_admin)
    get new_user_url
    assert_response :success
  end
  test "student should not get new" do
    sign_out :user
    sign_in users(:student)
    get new_user_url
    assert_response :redirect
  end

  # POST /users
  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { name: 'Jatin', email: 'jatin@test.com' } }
    end

    assert_redirected_to user_url(User.last)
  end
  test "should not create admin" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { name: 'Jatin', email: 'jatin@test.com', kind: 2 } }
    end

    assert_redirected_to root_url
  end
  test "school_admin should create user" do
    sign_out :user
    sign_in users(:school_admin)
    assert_difference('User.count') do
      post users_url, params: { user: { name: 'Jatin', email: 'jatin@test.com' } }
    end

    assert_redirected_to user_url(User.last)
  end
  test "school_admin should not create school_admin or admin" do
    sign_out :user
    sign_in users(:school_admin)
    assert_no_difference('User.count') do
      post users_url, params: { user: { name: 'Jatin', email: 'jatin@test.com', kind: 1 } }
    end

    assert_redirected_to root_url
  end
  test "student should not create user" do
    sign_out :user
    sign_in users(:student)
    assert_no_difference('User.count') do
      post users_url, params: { user: { name: 'Jatin', email: 'jatin@test.com' } }
    end
    assert_redirected_to root_url
  end

  # GET /users/1
  test "should show user" do
    get user_url(@user)
    assert_response :success
  end
  test "school_admin should not show user" do
    sign_out :user
    sign_in users(:school_admin)
    get user_url(@user)
    assert_response :redirect
  end
  test "student should not show user" do
    sign_out :user
    sign_in users(:student)
    get user_url(@user)
    assert_response :redirect
  end

  # GET /users/1/edit
  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end
  test "school_admin should not edit user" do
    sign_out :user
    sign_in users(:school_admin)
    get user_url(@user)
    assert_response :redirect
  end
  test "student should not edit user" do
    sign_out :user
    sign_in users(:student)
    get user_url(@user)
    assert_response :redirect
  end

  # PATCH /users/1
  test "should update user" do
    patch user_url(@user), params: { user: { name: 'Jatin Choudhary' } }
    assert_redirected_to user_url(@user)
  end
  test "school_admin should not update user" do
    sign_out :user
    sign_in users(:school_admin)
    patch user_url(@user), params: { user: { name: 'Jatin Choudhary' } }
    assert_redirected_to root_url
  end
  test "student should not update user" do
    sign_out :user
    sign_in users(:student)
    patch user_url(@user), params: { user: { name: 'Jatin Choudhary' } }
    assert_redirected_to root_url
  end

  # DELETE /users/1
  test "should delete user" do
    assert_difference('User.count', -1) do
      @user = users(:one)
      delete user_url(@user)
    end
    assert_redirected_to users_url
  end
  test "school_admin should not delete user" do
    sign_out :user
    sign_in users(:school_admin)
    assert_no_difference('User.count') do
      delete user_url(@user)
    end
    assert_redirected_to root_url
  end
  test "student should not delete user" do
    sign_out :user
    sign_in users(:student)
    assert_no_difference('User.count') do
      delete user_url(@user)
    end
    assert_redirected_to root_url
  end
end
