# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new([5])
  end

  def test_add_element_to_stack
    @stack.push!(6)

    assert { @stack.to_a == [5, 6] }
  end

  def test_remove_element_from_stack
    @stack.push!(6)

    assert { @stack.pop! == 6 }
  end

  def test_clear_the_stack
    @stack.clear!

    assert { @stack.size == 0 }
  end

  def test_the_stack_is_not_empty
    assert { @stack.empty? == false }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
