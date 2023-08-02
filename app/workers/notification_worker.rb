class NotificationWorker
  include Sidekiq::Worker

  def perform(options)
    case options['action']
    when 'notify_school_admin'
      UserMailer.with(school_id: options['school_id']).notify_school_admin.deliver_now
    when 'notify_old_school_admin'
      UserMailer.with(school_id: options['school_id'], user_id_was: options['user_id_was']).notify_old_school_admin.deliver_now
    when 'user_role_update'
      UserMailer.with(user_id: options['user_id']).user_role_update.deliver_now
    when 'enrollment_status_update'
      UserMailer.with(enrollment_id: options['enrollment_id']).enrollment_status_update.deliver_now
    when 'welcome'
      UserMailer.with(user_id: options['user_id']).welcome.deliver_now
    end
  end
end
