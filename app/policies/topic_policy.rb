class TopicPolicy < ApplicationPolicy

  def new?
    user.present? && user.admin?
  end

  def create?
    user.present? && user.admin?
  end

  def edit?
    user.present? && user.admin?
  end

  def update?
    user.present? && user.admin?
  end

  def destory?
    user.present? && user.admin?
  end
end
