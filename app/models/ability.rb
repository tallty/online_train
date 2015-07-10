class Ability
  include CanCan::Ability

  def initialize(admin)
    admin ||= Admin.new
    if admin.blank?
      cannot :manage, :all
    elsif admin.has_role?(:admin)
      can :manage, :all
    end
  end

  # 角色（教育部门）
  def role_education_department
    can :manage, :all
  end

  # 角色（管理部门）
  def role_manage_department
    can :manage, :all
  end

  # 角色（培训机构）
  def role_training_agency
    can :manage, :all
  end

  # 角色（评审专家）
  def role_expert
    can :manage, :all
  end

  # 角色（班级负责人）
  def role_grade_manager
    can :manage, :all
  end
end
