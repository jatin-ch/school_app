require "test_helper"

class SchoolTest < ActiveSupport::TestCase
  test "invalid if name missing" do
    school = School.new
    school.valid?
    assert_not school.errors[:name].empty?
  end

  test "invalid if duplicate name" do
    school = School.new(name: "School1")
    school.valid?
    assert_not school.errors[:name].empty?
  end

  test "valid if unique name present" do
    school = schools(:one).dup
    school.name = "School1 New"
    school.valid?
    assert_empty school.errors
  end
end
