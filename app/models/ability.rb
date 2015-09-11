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

  # 角色（教育部门）
  def role_education
    can :read, :all
  end

  # 角色（管理部门）
  def role_system
    can :manage, :all
  end

  # 角色（培训机构）
  def role_trainer
    can :manage, :all
  end

  # 角色（评审专家）
  def role_specialist
    can :manage, :all
  end

  # 角色（班级负责人）
  def role_management
    can :manage, :all
  end
end
