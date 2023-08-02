class CoursesController < ApplicationController
  load_and_authorize_resource :school
  load_and_authorize_resource :course, through: :school

  include Pagination
  include CommonMethods

  # GET /courses or /courses.json
  def index
    @courses = @courses.order(created_at: :desc).offset(@page_offset).limit(@page_limit)
  end

  # POST /courses or /courses.json
  def create
    @course = @school.courses.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to [@school, @course], notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to [@school, @course], notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to school_courses_url(@school), notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def course_params
      params[:course][:active] = params[:course][:active].to_i if params[:course][:active]
      params.require(:course).permit(:name, :active)
    end
end
