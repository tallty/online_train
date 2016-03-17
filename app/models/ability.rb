class Ability
  include CanCan::Ability

  def initialize(admin)
    admin ||= Admin.new
    if admin.system?
      role_system
    elsif admin.education?
      role_education
    elsif admin.trainer?
      role_trainer
    elsif admin.specialist?
      role_specialist
    elsif admin.management?
      role_management
    else
      can :manage, :all
    end
  end

  # 角色（教育部门, 对后台栏目拥有查阅权限）
  def role_education
    can :index, :home
    can :index, Notification
    can [:show, :list], TrainingCourse
    can [:index, :list], UserTrainingCourse
    can [:index, :list], Journal
    can :index, Task
    can :list, UserTask
    can [:index, :edit_profile, :update_profile, :edit_password, :update_password], Admin
    can :index, User
    can :index, Teacher
  end

  # 角色（管理部门, 即秘书处, 对后台拥有超级管理员权限）
  def role_system
    can :index, :home
    can :manage, :all
    can :manage, TrainingCourse
    can :manage, Journal
    cannot [:list], AdminUserTask
    cannot [:list_by_school, :list_by_teacher], TrainingCourse
    can [:add, :added, :update_multiple], UserTrainingCourse
    can :manage, Material
    can :manage, User
  end

  # 角色（培训机构）
  def role_trainer
    can :index, :home
    can [:list_by_school, :detail], TrainingCourse
    cannot :list, TrainingCourse
    can [:index, :list], UserTrainingCourse
    cannot [:applied, :disapplied, :add, :added], UserTrainingCourse
    can [:index, :list, :show], Journal
    can :index, Task
    can :list, UserTask
    can [:index, :edit_profile, :update_profile, :edit_password, :update_password], Admin
  end

  # 角色（评审专家）
  def role_specialist
    can :index, :home
    can [:list, :edit, :update], AdminUserTask
    can [:index, :edit_profile, :update_profile, :edit_password, :update_password], Admin
  end

  # 角色（班级负责人）
  def role_management
    can :index, :home
    can :index, Journal
    can [:manage], UserTrainingCourse
    can [:index, :list, :show], Journal
    can :manage, Task
    can [:list, :show, :index, :download, :unsubmit_users], UserTask
    can :manage, ManagerFeedback
    can :manage, StudentFeedback
    can :manage, Appraise
    can :manage, CourseResource
    can [:list_by_teacher, :detail], TrainingCourse
    can [:index, :edit_profile, :update_profile, :edit_password, :update_password], Admin
  end
end
