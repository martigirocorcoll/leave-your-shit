class LocationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    return true
  end

  def create?
    return true
  end


  def destroy?
    return true
  end

  def show?
    return true
  end
    
end
