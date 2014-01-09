class Ability
  include CanCan::Ability

  # Aliased actions
  # alias_action :index, :show, :to => :read
  # alias_action :new, :to => :create
  # alias_action :edit, :to => :update

  def initialize(user)
    # Non-Login
    if user == nil
      can :index, Download
      can :index, Post
      can :show, Post
    # Admin
    elsif user.role == "admin"
      can :manage, :all
    # Moderator, comments
    elsif user.role == "moderator"
      can :index, Download
      can :index, Post
      can :show, Post
      can :create, Comment
      can :update, Comment
      can :destroy, Comment
    # Normal Login
    elsif user.role == "registered"
      can :index, Download
      can :index, Post
      can :show, Post
      can :create, Comment
      can :update, Comment do |comment|
        comment.try(:user) == user
      end
    # Banned!
    elsif user.role == "banned"
      can :index, Post
      can :show, Post
    end

  end
end
