class Api::V1::UsersController < ApplicationController
  before_action :authorize_user!
  skip_before_action :authorize_user!, only: [:create]
  
  def create
    response = ::Users::Create::Processor.call(params: create_params)
    if response.success?
      render json: render_success("User record created successfully", response.user), status: :created
    else
      render json: render_failure(response.error, 0001,), status: :unprocessable_entity
    end
  end

  def verify
    
  end

  def index
    render json: {hi: "hello"}, status: :ok
  end
  private
  
  def create_params
    params.require(:users).permit(:mobile_number, :referral_code)
  end

end
