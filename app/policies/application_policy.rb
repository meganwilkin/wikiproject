class PostPolicy < ApplicationPolicy
  def update?
    user.present?
  end
end
