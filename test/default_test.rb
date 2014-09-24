require "test_helper"

class DefaultTest < Minitest::Test

  def setup
    @class =
      Class.new do
        include AttributeBoolean
        attr_boolean :default_false, default: false
        attr_boolean :default_true, default: true
      end

    @obj = @class.new
  end

  def test_default_false
    assert_equal false, @obj.default_false?, "expected default_false to default to false"

    @obj.default_false = true
    assert_equal true, @obj.default_false?, "expceted default_false to set to true"

    @obj.default_false = nil
    assert_equal false, @obj.default_false?, "expected default_false to revert to false"
  end

  def test_default_true
    assert_equal true, @obj.default_true?, "expected default_true to default to true"

    @obj.default_true = false
    assert_equal false, @obj.default_true?, "expceted default_true to set to false"

    @obj.default_true = nil
    assert_equal true, @obj.default_true?, "expected default_true to revert to true"
  end

end
