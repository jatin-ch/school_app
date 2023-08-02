class UserMailer < ApplicationMailer

  def notify_school_admin
    @school = School.find(params[:school_id])
    @user = @school.user
    mail(to: @user.email, subject: 'New School added')
  end

  def notify_old_school_admin
    @school = School.find(params[:school_id])
    @user = User.find(params[:user_id_was])
    mail(to: @user.email, subject: 'School Admin access removed')
  end

  def user_role_update
    @user = User.find(params[:user_id])
    mail(to: @user.email, subject: 'Update on your role')
  end

  def enrollment_status_update
    @enrollment = Enrollment.find(params[:enrollment_id])
    @user = @enrollment.user
    @batch = @enrollment.batch
    @course = @batch.course
    @school = @course.school
    @enrollment_url = enrollment_users_url(params[:enrollment_id])
    mail(to: @user.email, subject: "Update on your enrollment request ##{@enrollment.id}")
  end

  def welcome
    @user = User.find(params[:user_id])
    @reset_password_url = new_user_password_url
    @login_url = new_user_session_url
    mail(to: @user.email, subject: 'Welcome to School App')
  end
end
