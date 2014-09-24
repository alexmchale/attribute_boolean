require "test_helper"

class GlobalFalseValuesTest < Minitest::Test

  def setup
    @class =
      Class.new do
        include AttributeBoolean
        attr_boolean :finished
      end

    @obj = @class.new
  end

  def test_custom_false
    AttributeBoolean.false_values = [ "no way" ]

    assert_equal [ "no way" ], AttributeBoolean.false_values

    @obj.finished = false
    assert_equal true, @obj.finished?, "returns true for values not listed in the global false values"

    @obj.finished = "no way"
    assert_equal false, @obj.finished?, "returns false for value listed in the global false values"

    @obj.finished = :"no way"
    assert_equal false, @obj.finished?, "also returns false for symbolized versions of those values"
  end

  def teardown
    AttributeBoolean.reset_false_values!
  end

end
