# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @resume = Resume.find(params["resume"])
    pyscript_path = Rails.root.join('../sign_up_devise_sample/python_script/main.py')
    resume_url = Rails.root.join('../sign_up_devise_sample/public' + @resume.attachment_url)
    py_result = `python #{pyscript_path} #{resume_url}`.chomp
    py_result = JSON.parse(py_result)
    @check_user = User.find_by(email: py_result["Email"])
    if @check_user
      @resume.destroy
      redirect_to new_resume_path, notice:  "This email already registered."
    else
      @user = User.new
      # @user[:first_name] = py_result["First Name"]
      # @user[:last_name] = py_result["Last Name"]
      @user[:email] = py_result["Email"]
      @user[:encrypted_password] = py_result["Password"]
      @user[:experience_detail] = py_result["Experience Detail"]
      # @user[:contact_number] = py_result["Contact Number"]
      # @user[:correspondence_address] = py_result["Address"]
    end 
  end

  # POST /resource
  # def create
  #   puts sign_up_params
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, experience_detail: [:Location, :Tenure, :Designation])
    # params[:user][:experience_detail]
  end
  

end
