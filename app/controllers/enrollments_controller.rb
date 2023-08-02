class EnrollmentsController < ApplicationController
  load_and_authorize_resource :school
  load_and_authorize_resource :course
  load_and_authorize_resource :batch
  load_and_authorize_resource :enrollment, through: :batch
  before_action :set_school_course_users

  include Pagination
  include CommonMethods

  # GET /enrollments or /enrollments.json
  def index
    @enrollments = @enrollments.order(created_at: :desc).offset(@page_offset).limit(@page_limit)
  end

  # POST /enrollments or /enrollments.json
  def create
    @enrollment = @batch.enrollments.new(enrollment_params)

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to [@school, @course, @batch, @enrollment], notice: "Enrollment was successfully created." }
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to [@school, @course, @batch, @enrollment], notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to school_course_batch_enrollments_url(@school, @course, @batch), notice: "Enrollment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_school_course_users
      @school = School.find(params[:school_id])
      @course = Course.find(params[:course_id])
      @users = Rails.cache.fetch("users"){
        User.student.order(created_at: :desc).pluck(:name, :id)
      }
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params[:enrollment][:user_id] = current_user.id if current_user.student?
      params[:enrollment][:status] = params[:enrollment][:status].to_i if params[:enrollment][:status]
      params.require(:enrollment).permit(:user_id, :status)
    end
end
