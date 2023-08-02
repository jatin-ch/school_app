require "test_helper"

class BatchTest < ActiveSupport::TestCase
  test "invalid if name missing" do
    batch = batches(:one).dup
    batch.name = nil
    batch.valid?
    assert_not batch.errors[:name].empty?
  end

  test "invalid if course_id missing" do
    batch = batches(:one).dup
    batch.course_id = nil
    batch.valid?
    assert_not batch.errors[:course_id].empty?
  end

  test "invalid if size missing" do
    batch = batches(:one).dup
    batch.size = nil
    batch.valid?
    assert_not batch.errors[:size].empty?
  end

  test "invalid if size less then 1" do
    batch = batches(:one).dup
    batch.size = 0
    batch.valid?
    assert_not batch.errors[:size].empty?
  end

  test "invalid if start_date missing" do
    batch = batches(:one).dup
    batch.start_date = nil
    batch.valid?
    assert_not batch.errors[:start_date].empty?
  end

  test "invalid if end_date missing" do
    batch = batches(:one).dup
    batch.end_date = nil
    batch.valid?
    assert_not batch.errors[:end_date].empty?
  end

  test "invalid if start_date less then today" do
    batch = batches(:one).dup
    batch.start_date = Date.today - 1.day
    batch.valid?
    assert_not batch.errors[:start_date].empty?
  end

  test "invalid if end_date less then today" do
    batch = batches(:one).dup
    batch.end_date = Date.today - 1.day
    batch.valid?
    assert_not batch.errors[:end_date].empty?
  end

  test "invalid if start_date greter then or eqal to end_date" do
    batch = batches(:one).dup
    batch.start_date = batch.end_date + 1.day
    batch.valid?
    assert_not batch.errors[:start_date].empty?
  end

  test "invalid if name is duplicate w.r.t course_id, start_date and end_date" do
    batch = batches(:one).dup
    batch.name = "B1"
    batch.valid?
    assert_not batch.errors[:name].empty?
  end

  test "valid if unique name present w.r.t course_id, start_date and end_date" do
    batch = batches(:one).dup
    batch.name = "B1 New"
    batch.valid?
    assert_empty batch.errors
  end
end
