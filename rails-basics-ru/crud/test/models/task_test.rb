# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  status      :string           default("new"), not null
#  creator     :string           not null
#  performer   :string
#  completed   :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end