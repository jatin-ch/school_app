module ProfileController
  extend ActiveSupport::Concern

  included do
    before_action :set_profile, only: %i[ profile edit_profile ]

    def edit_profile
      render 'users/profile/edit'
    end

    def new_enrollment
      @enrollment = Enrollment.new
      @schools = Rails.cache.fetch("schools"){
        School.order(created_at: :desc).pluck(:name, :id)
      }
      render 'users/enrollments/new'
    end

    def show_enrollments
      @enrollment = current_user.enrollments.find_by_id(params[:enrollment_id])
      redirect_to enrollments_users_path and return unless @enrollment
      @enrollments = Enrollment.includes(:user).where(batch_id: @enrollment.batch_id).order(created_at: :desc).offset(@page_offset).limit(@page_limit)
      render 'users/enrollments/show'
    end

    def enrollments
      if request.post?
        @enrollment = current_user.enrollments.new(params.require(:enrollment).permit(:batch_id))
        respond_to do |format|
          if @enrollment.save
            format.html { redirect_to enrollments_users_path, notice: "Enrollment was successfully created." }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :new_enrollment, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      elsif request.get?
        if request.format.html?
          @enrollments = current_user.enrollments.order(created_at: :desc)
          render 'users/enrollments/index'
        elsif request.format.json?
          @enrollments = current_user.enrollments.order(created_at: :desc)
          render 'users/enrollments/index'
        else
          if params[:school_id]
            _response =  Course.where(school_id: params[:school_id]).order(created_at: :desc).pluck(:name, :id)
          elsif params[:course_id]
            _response =  Batch.where(course_id: params[:course_id]).order(created_at: :desc).pluck(:name, :id)
          else
            _response = []
          end
          render json: _response
        end
        
      end
    end

    def profile
      if request.post?
        respond_to do |format|
          if @profile.update(params.require(:user).permit(:name))
            format.html { redirect_to profile_users_path, notice: "Profile was successfully updated." }
            format.json { render :profile, status: :ok, location: profile_users_path }
          else
            format.html { render :edit_profile, status: :unprocessable_entity }
            format.json { render json: @profile.errors, status: :unprocessable_entity }
          end
        end
      elsif request.get?
        render 'users/profile/show'
      end
    end

    private
    def set_profile
      @profile = current_user
    end
  end
end