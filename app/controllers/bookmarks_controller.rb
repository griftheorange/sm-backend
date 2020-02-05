class BookmarksController < ApplicationController
    def index
        @bookmarks = Bookmark.all
        render json: @bookmarks
    end

    def create
        @bookmark = Bookmark.create({
            user_id: params[:user_id],
            quake_db_id: params[:quake_db_id],
            place: params[:place],
            dateAndTime: params[:dateAndTime],
            mag: params[:mag],
            lat: params[:lat],
            long: params[:long]
        })
        if @bookmark.valid?
            render json: @bookmark
        else
            render json: {errors: @bookmark.errors}
        end
    end
end
