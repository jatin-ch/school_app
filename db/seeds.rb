['admin', 'school_admin', 'student'].each do |role|
  User.create(name: role.titleize, email: "#{role}@app.com", kind: role, password: '123456')
end

def create_user(kind='student')
   _name = Faker::Name.unique.name
  _email = "#{_name.downcase.gsub(/[." "]/, '.' => '', ' ' => '.')}@app.com"
  user = User.create(name: _name, email: _email, kind: kind, password: '123456')
end

5.times do
  school = School.create(name: "#{Faker::Name.unique.name}, #{Faker::Address.city}", user_id: create_user('school_admin').id)
  5.times do
    course = school.courses.create(name: Faker::Name.unique.name)
    5.times do
      start_date = Date.today + 1.day
      end_date = start_date + 1.day
      batch = course.batches.create(name: Faker::Name.unique.name, size: 10, start_date: start_date, end_date: end_date, status: 'started')
      5.times do
        batch.enrollments.create(user_id: create_user.id, status: 'pending')
      end
    end
  end
end