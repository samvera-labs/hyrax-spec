module Hyrax
  module Spec
    if defined?(FactoryBot) || defined?(FactoryGirl)
      # support legacy FactoryGirl name, but use always FactoryBot internally
      FactoryBot = FactoryGirl unless defined?(FactoryBot)

      require 'hyrax/spec/factory_bot/build_strategies/actor_create'

      FactoryBot.register_strategy(:actor_create, Hyrax::Spec::ActorCreate)
    end
  end
end
