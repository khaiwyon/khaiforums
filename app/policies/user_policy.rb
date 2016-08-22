class UserPolicy < ApplicationPolicy

  def edit?
    user.present? &&
    (user.admin? || user == record)
  end

  def update?
    user.present? &&
    (user.admin? || user == record)
  end

  def destory?
    user.present? && user.admin?
  end
end
