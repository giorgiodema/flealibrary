class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :banned_user, :admin_user, :booklover_user, :to => :manage_user
    if user.present?
      if user.role == "superadmin"
        can :manage, :all
        cannot :manage_user, user, :id => user.id
      elsif user.role == "admin"
        can :manage, User
        cannot :manage_user, user, :id => user.id
        cannot :admin_destroy_user, User, :role => "admin"
        cannot :admin_destroy_user, user, :id => user.id
        cannot :manage, User, :role => "superadmin"
      elsif user.role == "banned"
        cannot :manage, :all
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
