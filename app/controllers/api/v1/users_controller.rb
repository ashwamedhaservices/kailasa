class Api::V1::UsersController < ApplicationController
  before_action :authorize_user!
  skip_before_action :authorize_user!, only: [:create]
  
  def create
    response = ::Users::Create::Processor.call(params: create_params)
    if response.success?
      render json: render_success("Verification OTP sent successfully, please verify."), status: :created
    else
      render json: render_failure(response.error, 0001), status: :unprocessable_entity
    end
  end

  def verify
    # OTP verify logic goes here
    user.verified!
  end

  def index
    render json: {hi: "hello"}, status: :ok
  end

  private
  
    def create_params
      params.require(:users).permit(:mobile_number, :referral_code, :password)
    end

    def user
      @user ||= if params[:mobile_number]
                  User.find_by(mobile_number: params[:mobile_number])
                elsif params[:id]
                  User.find!(params[:mobile_number])
                end
    end

end
