class Ability
  include CanCan::Ability

  # Aliased actions
  # alias_action :index, :show, :to => :read
  # alias_action :new, :to => :create
  # alias_action :edit, :to => :update

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # Main Logic
    if user.role == "admin"
      # An admin has control of everything
      can :manage, :all
    elsif user.role == "moderator"
      
    elsif user.role == "registered"
      
    elsif user.role == "banned"
      cannot :manage, :all
    else
      
    end

  end
end
