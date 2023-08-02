require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "invalid if name missing" do
    user = User.new(email: "jatin@test.com")
    user.valid?
    assert_not user.errors[:name].empty?
  end

  test "invalid if email missing" do
    user = User.new(name: "Jatin")
    user.valid?
    assert_not user.errors[:email].empty?
  end

  test "valid if name and email present" do
    user = users(:one)
    user.valid?
    assert_empty user.errors
  end
end
