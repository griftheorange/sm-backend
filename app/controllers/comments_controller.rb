class CommentsController < ApplicationController

    def index
        @comments = Comment.all
        render json: @comments
    end

    def show
        @comment = Comment.find_by(id: params[:id])
        render json: @comment
    end

    def create
        cqs = CommentedQuake.all
        found = cqs.find{|cq|
            cq.quake_db_id == params[:quake_db_id]
        }
        if(found)
            @comment = Comment.create(user_id: params[:user_id], commented_quake_id: found.id, date_posted: formatDate, content: params[:content], quake_name: params[:quake_name], quake_mag: params[:quake_mag])
            if @comment.valid?
                render json: @comment
            else
                render json: {errors: @comment.errors}
            end
        else
            cq = CommentedQuake.create(quake_db_id: params[:quake_db_id])
            @comment = Comment.create(user_id: params[:user_id], commented_quake_id: cq.id, date_posted: formatDate, content: params[:content], quake_name: params[:quake_name], quake_mag: params[:quake_mag])
            if @comment.valid?
                render json: @comment
            else
                render json: {errors: @comment.errors}
            end
        end
    end

    def destroy
        render json: Comment.find_by(id: params[:id]).destroy()
    end

    private

    def formatDate
        params[:date_posted].delete_suffix(" - EST")
    end

    def user_id
        self.user.id
    end
end
