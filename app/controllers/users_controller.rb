class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user_kind, only: %i[ new edit ]

  include ProfileController
  include Pagination
  include CommonMethods

  # GET /users or /users.json
  def index
    @users = @users.order(created_at: :desc).offset(@page_offset).limit(@page_limit)
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params.merge(password: Devise.friendly_token.first(6)))

    respond_to do |format|
      if @user.save
        format.html { redirect_to (params[:ref].present? ? params[:ref] : @user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        set_batches
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy unless @user.admin?
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # DELETE /users/sign_out
  def sign_out
    sign_out current_user
    redirect_to root_path
  end

  private

    # restrict user type to manage only authorizated user type 
    def set_user_kind
      if current_user.admin?
       @user_kind = User.kinds.except("admin").to_a
      else
        @user_kind = User.kinds.slice("student").to_a
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params[:user][:kind] = params[:user][:kind].to_i if params[:user][:kind]
      params.require(:user).permit(:name, :email, :kind, :active)
    end
end
