RSpec::Matchers.define :have_form_field do |name|
  match do |rendered_form|
    raise 'Specify a model with `.on_model(Klass)` to use this matcher.' unless
      model_class

    @selector = "#{model_class.to_s.downcase}_#{name}"
    @field    = rendered_form.find_css("##{@selector}").first

    @options_missing = []

    return false unless @field

    @multiple = case @field.node_name
                when 'input'
                  @field.attributes['class'].value.include? 'multi_value'
                when 'select'
                  @field.attributes['multiple'] || @field.attributes['class'].value.include?('multi_value')
                end

    if label
      label_node   = rendered_form.find_css("label[for=\"#{@selector}\"]")
      @label_text  = label_node && label_node.xpath('text()').first.text
      @label_match = @label_text =~ /\s*#{label}\s*$/
    end

    if @options
      @option_values =
        @field.css('option').map { |opt| opt.attributes['value'].try(:value) }
      @options_missing = (@options - @option_values)
    end

    @field &&
      (@single ^ @multiple) &&
      (!label || @label_match) &&
      @options_missing.empty?
  end

  chain :on_model,   :model_class
  chain :and_label,  :label
  chain :with_label, :label

  chain :as_single_valued do
    @single = true
  end

  chain :and_options do |*options|
    @options = options
  end

  chain :with_options do |*options|
    @options = options
  end

  failure_message do |rendered_form|
    msg = "expected #{rendered_form} to have field #{name}"
    msg += ' as ' + (@single ? 'single valued' : 'multivalued')
    msg += " for class #{model_class}"          if     model_class
    msg += " with label #{label}"               if     label
    msg += " with options #{@options}"          if     @options
    msg += "\n\tNo field found: #{@selector}."  unless @field
    msg += "\n\tField not multivalued."         unless @single || @multiple
    msg += "\n\tField not single valued."       if     @single && @multiple
    msg += "\n\tLabel was #{@label_text}."      unless @label_match && @field
    msg += "\n\tOptions were #{@option_values}" unless @options_missing.empty?
    msg += "\n\t#{@field}."                     if     @field
    msg
  end
end

RSpec::Matchers.alias_matcher :have_multivalued_field, :have_form_field
