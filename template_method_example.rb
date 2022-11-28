class AbstractTestingPipeline
  def template_method
    run_unit_tests
    run_custom_international_tests
    run_custom_performance_tests
    send_some_info_hook
    teardown
  end

  def run_unit_tests
    puts 'Running unit tests ...'
  end

  def teardown
    puts 'Teardown ...'
  end

  def run_custom_international_tests
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def run_custom_performance_tests
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def send_some_info_hook; end

end


class ConcreteTestingPipeline1 < AbstractTestingPipeline
  def run_custom_international_tests
    puts 'ConcreteTestingPipeline1: international tests running ...'
  end

  def run_custom_performance_tests
    puts 'ConcreteTestingPipeline1: international tests running ...'
  end
end


class ConcreteTestingPipeline2 < AbstractTestingPipeline
  def run_custom_international_tests
    puts 'ConcreteTestingPipeline2: international tests running ...'
  end

  def run_custom_performance_tests
    puts 'ConcreteTestingPipeline2: international tests running ...'
  end

  def send_some_info_hook
    puts 'ConcreteTestingPipeline2: sending some info hook ...'
  end
end


def client_code(abstract_class)
  abstract_class.template_method
end


puts 'Testing pipeline 1:'
client_code(ConcreteTestingPipeline1.new)
puts "\n"

puts 'Testing pipeline 2:'
client_code(ConcreteTestingPipeline2.new)