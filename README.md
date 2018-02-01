Hyrax::Spec
===========

[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/gems/hyrax-spec)

Shared examples and smoke tests for [Hyrax](https://github.com/samvera/hyrax) applications.

## `FactoryBot` Build Strategies for Hyrax

If your test suite uses `FactoryBot` (formerly `FactoryGirl`) to create test objects, `Hyrax::Spec` provides useful
custom build strategies that may simplify the setup phase of your tests. To register the build stratgies add the
following to your test helper (usually `spec/rails_helper.rb`):

```ruby
# spec/rails_helper.rb

require 'hyrax/spec/factory_bot/build_strategies'
```

### `ActorCreate`

The `ActorCreate` strategy builds an object and passes it to the [Hyrax Actor
Stack](https://github.com/samvera/hyrax/wiki/Customizing-Actors) to be processed. In a normal RSpec Rails environment,
this will  enqueue (but not perform) several background jobs (charactarization, derivatives, etc...). The specific actor
middleware called is `Hyrax::CurationConcern.actor`.

This strategy is registered by default as `actor_create`. You can use it with an existing factory, which must define
`user` as a [transient attribute](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#transient).

```ruby
# factories/my_works.rb
FactoryBot.define do
  factory(:my_work) do
    title ['Comet in Moominland']

    transient do
      user { FactoryBot.create(:user) }
    end
  end
end

# my_work_spec.rb
RSpec.describe MyWork do
  subject(:my_work) { FactoryBot.actor_create(:my_work) }

  it { is_expected.to have_attributes(date_uploaded: an_instance_of(DateTime)) }
end
```

## License

`Hyrax::Spec` is available under [the Apache 2.0 license](LICENSE).
