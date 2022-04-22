class UsersController < ApplicationController
  def create
    if verify_otp_code?
        user = User.find_or_create_by(
          country_code: user_params[:country_code],
          phone_number: user_params[:phone_number]
        )
        token = JsonWebToken.encode(user_id: user.id)
        user.api_token ? user.api_token.save_token(token) : user.build_api_token.save_token(token)
        render json: {
          user: user,
          auth_token: token,
          message: 'Phone number verified!'
        }, status: :created
    else
      render json: { data: {}, message: 'Please enter a valid phone number' },
             status: :unprocessable_entity
    end
  rescue Twilio::REST::RestError => e
    render json: { message: 'otp code has expired. Resend code' }, status: :unprocessable_entity
  end

  def checkAuth
     render json: {
      phone_number: @current_user.phone_number,
      country_code: @current_user.country_code
    }
  end

  def verify_otp_code?
    VerificationService.new(
      user_params[:phone_number],
      user_params[:country_code]
    ).verify_otp_code?(params['otp_code'])
  end

  def send_code
    response = VerificationService.new(
      user_params[:phone_number],
      user_params[:country_code]
    ).send_otp_code

    render json: {
      phone_number: user_params[:phone_number],
      country_code: user_params['country_code'],
      message: response
    }
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :country_code, :phone_number
    )
  end
end
