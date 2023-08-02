require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome" do
    user = users(:one)
    email = UserMailer.with(user_id: user.id).welcome

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [user.email], email.to
    assert_equal ['school@app.com'], email.from
    assert_equal "Welcome to School App", email.subject
  end

  test "enrollment_status_update" do
    enrollment = enrollments(:one)
    email = UserMailer.with(enrollment_id: enrollment.id).enrollment_status_update

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [enrollment.user.email], email.to
    assert_equal ['school@app.com'], email.from
    assert_equal "Update on your enrollment request ##{enrollment.id}", email.subject
  end

  test "user_role_update" do
    user = users(:one)
    email = UserMailer.with(user_id: user.id).user_role_update

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [user.email], email.to
    assert_equal ['school@app.com'], email.from
    assert_equal "Update on your role", email.subject
  end

  test "notify_old_school_admin" do
    school = schools(:one)
    user = users(:school_admin_2)
    email = UserMailer.with(school_id: school.id, user_id_was: user.id).notify_old_school_admin

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [user.email], email.to
    assert_equal ['school@app.com'], email.from
    assert_equal "School Admin access removed", email.subject
  end

  test "notify_school_admin" do
    school = schools(:one)
    email = UserMailer.with(school_id: school.id).notify_school_admin

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [school.user.email], email.to
    assert_equal ['school@app.com'], email.from
    assert_equal "New School added", email.subject
  end
end
