# README

## School App
An application that allows management of schools, courses, batches, enrollments and users, this application offers a flexible and secure platform for educational organizations.
There will be three types of user including Admin, School Admin, and Student. With different user types and their respective capabilities, 

### User types and their role
All the users can manage their profile i.e they can update their password and name.

##### Admin:
- Admins have full control over the system and can create all type of except Admin user type.
- Admins can manage users (School Admins & students), schools, courses, batches and enrollments.

##### School Admin:
- SchoolAdmins can update information about the school.
- SchoolAdmins are responsible for managing courses
- SchoolAdmins are responsible for managing batches
- SchoolAdmins are responsible for adding students to batches by enrollments.
- They can also approve or deny enrollment requests made by students.

##### Student:
- Students can raise a request to enroll in a batch.
- Students from the same batch can see their classmates and their progress.


### Application functionality:

#### This application is also available as an API.

##### Users
- Admin can manage users.
- School Admin can only create new students.
- If a user is registered by a Admin/ School Admin then system will send an welcome email to user and link to reset their password.

##### Schools
- Admin can manage schools. 
- A school will be assigned to a dedicated School Admin and that particular admin only can edit school information like name, courses etc.
- An email will be sent to an School Admin if he/she is assigned/ unassigned to a school.
- A school can have multiple courses.

##### Courses
- A course will belongs to an school.
- Admin/ School Admin can manage their courses.
- A course can have multiple batches.


##### Batches
- A batch will belongs to an course.
- Admin/ School Admin can manage their batches.
- A batch can have multiple enrollments.

##### Enrollments
- An enrollment will belongs to an batch.
- Admin/ School Admin can manage and approve enrollments.
- A student can request an enrollment, and he/she can track all the enrollments request details in dashboard.
- If an enrollment is accepted/ rejected then system will send an intimation email.


### How to install and run application

##### Ruby version:
- Using ruby `2.7.1` in not installed on your system then install it using **rvm**.

##### Database
- sqlite

##### Gems included: 
- `sidekiq` for background processing
- `redis` as cache server
- `mailcatcher` for emails in development environment
- `devise` for authentication
- `cancancan` for authorization
- `faker` to insert fake data for development and testing purpose
- `foreman` to run all the services using a simple bash command

##### Services
- Sidekiq for background processing
- Redis cache server
- Mailcatcher for emails in development

##### Installation
- Got to project repository and then run following commands
- `bundle install` to install all the dependencies 
- `rails db:setup` to setup database and insert same data.
* Run the test suite: `bin/test`
* Command to run application: `bin/dev`
* Running web application [URL](http://localhost:3000)
* Credentials to login into web application:
Admin:[admin@app.com, 123456], School Admin:[school_admin@app.com, 123456], Student:[student@app.com, 123456]
* Check your email [here](http://127.0.0.1:1080/)
* Check background jobs and their progress [here](http://localhost:3000/sidekiq/) using username: 'admin' & password: 'admin'



 Thank you!
