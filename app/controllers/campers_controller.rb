class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

wrap_parameters format: []

    # GET /campers
    def index 
        campers = Camper.all 
        render json: campers, status: :ok
    end

    # GET /campers/:id
    def show 
        camper = Camper.find(params[:id])
        render json: camper, status: :ok, serializer: CamperActivitySerializer
    end

    # POST /campers
    def create 
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private 

    def camper_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
