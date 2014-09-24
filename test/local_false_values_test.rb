require "test_helper"

class LocalFalseValuesTest < Minitest::Test

  def setup
    @class =
      Class.new do
        include AttributeBoolean
        attr_boolean :finished, false_values: [ "nope", "nut uh" ]
      end

    @obj = @class.new
  end

  def test_custom_false
    @obj.finished = false
    assert_equal true, @obj.finished?, "returns true for values not listed in the global false values"

    @obj.finished = "nut uh"
    assert_equal false, @obj.finished?, "returns false for value listed in the global false values"

    @obj.finished = :"nut uh"
    assert_equal false, @obj.finished?, "also returns false for symbolized versions of those values"
  end

end
