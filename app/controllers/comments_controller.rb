class CommentsController < ApplicationController

    def index
        @comments = Comment.all
        render json: @comments
    end

    def show
        @comment = Comment.find_by(id: params[:id])
        render json: @comment
    end

    #Special function for creating a comment. First checks if the event being commented has been commented before
    #if found, it creates a new comment for the pre-existing cq object
    #if not found, first creates a cq object, then creates a comment associating it to that new object
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
