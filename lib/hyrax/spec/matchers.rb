require 'rspec/matchers' # @see http://rubygems.org/gems/rspec

module Hyrax
  module Spec
    ##
    # RSpec matchers for common Hyrax tests
    module Matchers
      require 'hyrax/spec/matchers/act'
      require 'hyrax/spec/matchers/have_editable_property'
      require 'hyrax/spec/matchers/have_form_field'
      require 'hyrax/spec/matchers/list_index_fields'
    end
  end
end
