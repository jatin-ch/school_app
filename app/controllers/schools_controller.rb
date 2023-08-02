class SchoolsController < ApplicationController
  load_and_authorize_resource
  before_action :set_users, only: %i[ new edit ]

  include Pagination
  include CommonMethods

  # GET /schools or /schools.json
  def index
    @schools = @schools.order(created_at: :desc).offset(@page_offset).limit(@page_limit)
  end

  # POST /schools or /schools.json
  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: "School was successfully created." }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1 or /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @school, notice: "School was successfully updated." }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1 or /schools/1.json
  def destroy
    if current_user.admin?
      @school.destroy
      respond_to do |format|
        format.html { redirect_to schools_url, notice: "School was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to root_url
    end
  end

  private

    def set_users
      @users = User.where(kind: 'school_admin').order(created_at: :desc).pluck(:name, :id)
    end

    # Only allow a list of trusted parameters through.
    def school_params
      params[:school][:active] = params[:school][:active].to_i if params[:school][:active]
      params.require(:school).permit(:name, :user_id, :active)
    end
end
