class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.admin? ? scope.all : scope.all_by_user(user)
    end
  end

  def index?
    true
  end

  def new?
    true
  end

  def show?
    true
  end

  def edit?
    update?
  end

  def create?
    true
  end
  
  def update?
    # user 
    # record
    # TESTER : 3 || RESTAURANT.USER_ID: 1
    is_owner_or_admin?
  end

  def destroy?
    update?
  end

  def is_owner_or_admin?
    record.user == user || user.admin?
  end
end
