class BatchesController < ApplicationController
  load_and_authorize_resource :school
  load_and_authorize_resource :course
  load_and_authorize_resource :batch, through: :course
  before_action :set_school

  include Pagination
  include CommonMethods

  # GET /batches or /batches.json
  def index
    @batches = @batches.order(created_at: :desc).offset(@page_offset).limit(@page_limit)
  end

  # POST /batches or /batches.json
  def create
    @batch = @course.batches.new(batch_params)

    respond_to do |format|
      if @batch.save
        format.html { redirect_to [@school, @course, @batch], notice: "Batch was successfully created." }
        format.json { render :show, status: :created, location: @batch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /batches/1 or /batches/1.json
  def update
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to [@school, @course, @batch], notice: "Batch was successfully updated." }
        format.json { render :show, status: :ok, location: @batch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1 or /batches/1.json
  def destroy
    @batch.destroy
    respond_to do |format|
      format.html { redirect_to school_course_batches_url(@school, @course), notice: "Batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_school
      @school = School.find(params[:school_id])
    end

    # Only allow a list of trusted parameters through.
    def batch_params
      params[:batch][:status] = params[:batch][:status].to_i if params[:batch][:status]
      params.require(:batch).permit(:name, :size, :start_date, :end_date, :status)
    end
end
