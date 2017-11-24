module Hyrax
  module Spec
    ##
    # A FactoryBot build strategy for creating Hyrax Works and running them
    # through the actor stack.
    #
    # In a normal RSpec Rails environment, this will  enqueue (but not perform)
    # several background jobs (charactarization, derivatives, etc...). If you
    # want to perform the jobs, configure that with:
    #
    #     ActiveJob::Base.queue_adapter.perform_enqueued_jobs    = true
    #     ActiveJob::Base.queue_adapter.perform_enqueued_at_jobs = true
    #
    # If you only want to perform specific job classes, you can do:
    #
    #     ActiveJob::Base.queue_adapter.filter = [SpecificJobClassYouWantToRun]
    #
    # @example Registering the strategy and creating using an existing factory
    #   FactoryBot.register_strategy(:actor_create, ActorCreate)
    #
    #   work = FactoryBot.actor_create(:a_work_factory)
    #
    # @see Hyrax::CurationConcern#actor
    # @see https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#custom-strategies
    class ActorCreate
      def initialize
        @association_strategy = FactoryBot.strategy_by_name(:create).new
      end

      delegate :association, to: :@association_strategy

      def result(evaluation)
        evaluation.object.tap do |instance|
          evaluation.notify(:after_build, instance)

          # @todo: is there a better way to get the evaluator at this stage?
          #   how should we handle a missing user?
          ability = ::Ability.new(evaluation.instance_variable_get(:@evaluator).user)
          env     = Hyrax::Actors::Environment.new(instance, ability, {})

          evaluation.notify(:before_create,       instance)
          evaluation.notify(:before_actor_create, instance)
          Hyrax::CurationConcern.actor.create(env)
          evaluation.notify(:after_create,       instance)
          evaluation.notify(:after_actor_create, instance)
        end
      end
    end
  end
end
