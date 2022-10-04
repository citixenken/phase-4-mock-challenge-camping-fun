class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

wrap_parameters format: []

    # POST /signups
    def create 
        signup = Signup.create!(signup_params)
        render json: signup.activity, status: :created
    end

    private 

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
