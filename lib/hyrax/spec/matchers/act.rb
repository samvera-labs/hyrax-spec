RSpec::Matchers.define :act do
  fake_actor = Class.new do
    attr_reader :created, :updated, :destroyed

    def create(*)
      @created = true
    end

    def update(*)
      @updated = true
    end

    def destroy(*)
      @destroyed = true
    end
  end

  fail_actor = Class.new do
    def create(*)
      false
    end

    def update(*)
      false
    end

    def destroy(*)
      false
    end
  end

  match do |actor_class|
    env       ||= instance_double(Hyrax::Actors::Environment, curation_concern: nil)
    @next_actor = fake_actor.new
    actor       = actor_class.new(@next_actor)
    @create     = actor.create(env)
    @update     = actor.update(env)
    @destroy    = actor.destroy(env)

    failure_actor = actor_class.new(fail_actor.new)
    @fail_create  = failure_actor.create(env)
    @fail_update  = failure_actor.update(env)
    @fail_destroy = failure_actor.destroy(env)

    return false unless @next_actor.created && @next_actor.updated && @next_actor.destroyed
    return false unless (@succeed && @create && @update && @destroy) ||
                        (!@succeed && !@create && !@update && !@destroy)
    return false unless (!@recover && !@fail_create && !@fail_update && !@fail_destroy) ||
                        (@recover && @fail_create && @fail_update && @fail_destroy)
    true
  end

  chain :and_succeed do
     @succeed = true
  end

  chain :and_recover do
    @recover = true
  end

  chain :with_env, :env

  failure_message do |actor|
    msg = "expected #{actor.class} to behave like a Hyrax::Actor but"
    msg += "\n\t#create returned #{@create}"                     unless @create == true || !@succeed
    msg += "\n\t#create was not called on the next actor"        unless @next_actor.created
    msg += "\n\tunexpectedly recovered from failure on #create"  unless @recover || !@fail_create
    msg += "\n\tdid not recover from failure on #create"         unless !@recover || @fail_create
    msg += "\n\t#update returned #{@update}"                     unless @update == true || !@succeed
    msg += "\n\t#update was not called on the next actor"        unless @next_actor.updated
    msg += "\n\tunexpectedly recovered from failure on #update"  unless @recover || !@fail_update
    msg += "\n\tdid not recover from failure on #update"         unless !@recover || @fail_update
    msg += "\n\t#destroy returned #{@destroy}"                   unless @destroy == true || !@succeed
    msg += "\n\t#destroy was not called on the next actor"       unless @next_actor.destroyed
    msg += "\n\tunexpectedly recovered from failure on #destroy" unless @recover || !@fail_destroy
    msg += "\n\tdid not recover from failure on #destroy"        unless !@recover || @fail_destroy
    msg
  end
end
