require 'test_helper'

class Shared::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Shared
  end
end
