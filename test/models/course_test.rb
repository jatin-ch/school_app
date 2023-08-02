require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "invalid if name missing" do
    course = Course.new
    course.valid?
    assert_not course.errors[:name].empty?
  end

  test "invalid if school_id missing" do
    course = Course.new(name: "Test Course")
    course.valid?
    assert_not course.errors[:school].empty?
  end

  test "invalid if duplicate name w.r.t school_id" do
    course = Course.new(name: "Course1", school_id: 1)
    course.valid?
    assert_not course.errors[:name].empty?
  end

  test "valid if unique name present w.r.t school_id" do
    course = Course.new(name: "Course1", school_id: 3)
    course.valid?
    assert_empty course.errors
  end
end
