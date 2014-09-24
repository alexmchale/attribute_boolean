require "test_helper"

class AttrBooleanTest < Minitest::Test

  def setup
    @class =
      Class.new do
        include AttributeBoolean
        attr_boolean :field
      end

    @obj = @class.new
  end

  def test_truthiness
    [ "y", "yes", true, 1, 2, :y ].each do |value|
      @obj.field = value
      assert_equal true, @obj.field, "expected field #{ value.inspect } to result in true"
      assert_equal true, @obj.field?, "expected field? #{ value.inspect } to result in true"
    end
  end

  def test_falsiness
    [ false, 0, '0', 'f', 'F', 'false', 'FALSE', 'off', 'OFF', 'n', 'N', 'no', 'NO' ].each do |value|
      @obj.field = value
      assert_equal false, @obj.field, "expected field #{ value.inspect } to result in false"
      assert_equal false, @obj.field?, "expected field? #{ value.inspect } to result in false"
    end
  end

end
