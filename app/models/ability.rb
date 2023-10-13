class Ability
  include CanCan::Ability

  def initialize(user)
    if user.type == 'Owner'
      can :manage, :all
      cann
    else
      can :read,Restaurent
      can :read,Category
      can :read,Dish
      can :create,Cart 
      can :create,CartItem
      can :create,Order
      can :create,OrderItem
      can :read,Order 
    end
  end
end
