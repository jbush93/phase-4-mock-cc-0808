class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid 

    def index 
        campers = Camper.all 
        render json: campers, status: :ok
    end

    def show 
        camper = Camper.find(params[:id])
        render json: camper, status: :ok, serializer: CamperShowSerializer   
    end

    def create 
        camper = Camper.create!(campers_params)
        render json: camper, status: :created 
    end

    private
    def campers_params 
        params.permit(:name, :age)
    end

    def render_not_found 
        render json: {"error": "Camper not found"}, status: 404
    end

    def render_record_invalid 
        render json: {"errors": ["validation errors"]}, status: 422
    end
end
