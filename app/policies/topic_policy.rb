class TopicPolicy < ApplicationPolicy

  def new?
    user.present? && user.admin?
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destory?
    new?
  end
end
