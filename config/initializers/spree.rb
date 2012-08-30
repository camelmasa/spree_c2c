class ConsumerAbility
  include CanCan::Ability

  def initialize(user)
    user ||= Spree.user_class.new
    if user.respond_to?(:has_spree_role?) && user.has_spree_role?('consumer')
      can :manage, :all
      #   cannot :read, Comment
    end
  end
end

Spree::Ability.register_ability(ConsumerAbility)
