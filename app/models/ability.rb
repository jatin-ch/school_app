# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can [:profile, :edit_profile], User

    if user.student?
      can [:enrollments, :new_enrollment, :show_enrollments], User
    elsif user.school_admin?
      can [:read, :update], School, user_id: user.id
      can :manage, Course
      can :manage, Batch
      can :manage, Enrollment
      can :create, User, kind: 'student'
    elsif user.admin?
      can :manage, :all
      cannot :manage, User, kind: 'admin'
      cannot [:enrollments, :new_enrollment, :show_enrollments], User
    else
      cannot :manage, :all
    end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
