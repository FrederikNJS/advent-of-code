require 'rspec/core/formatters/documentation_formatter'
require 'rspec/core/formatters/console_codes'

class ProfilingDocumentationFormatter < RSpec::Core::Formatters::DocumentationFormatter
  RSpec::Core::Formatters.register self, :example_passed, :example_pending, :example_failed
private
  def passed_output(example)
    RSpec::Core::Formatters::ConsoleCodes.wrap("#{current_indentation}#{example.description.strip} (%.6fs)" % example.execution_result.run_time, :success)
  end
end
