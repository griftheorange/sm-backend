class CommentedQuakesController < ApplicationController
    def index
        @commented_quakes = CommentedQuake.all
        render json: @commented_quakes
    end

    #commented quake objects only exist if an event has been commented on before.
    #show controller renders conditionally based on whether a pre-existing comment exists
    def show
        @commented_quake = CommentedQuake.find_by(quake_db_id: params[:id])
        if @commented_quake
            render json: @commented_quake
        else
            render json: {not_found: true}
        end
    end
end
