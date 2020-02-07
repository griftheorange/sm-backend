class CommentedQuakesController < ApplicationController
    def index
        @commented_quakes = CommentedQuake.all
        render json: @commented_quakes
    end
end
