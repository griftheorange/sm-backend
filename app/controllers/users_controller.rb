require 'jwt'

class UsersController < ApplicationController

    #users go through token authorization before relavent data sent out
    before_action :authenticate, only: [:show]

    def index
        @users = User.all
        render json: @users
    end

    def show
        @user = User.find_by(id: params[:id])
        if @user
            render json: @user
        else 
            render json: {errors: {user: ["no account found"]}}
        end
    end

    #Update controller used to modify profile pic, address, radius concern attr of user.
    #If profile pic updated, runs cloudinary function in private field below to delete old
    #pics from cloud, upload new pics and assign appropriate url and img_ids to user
    def update
        @user = User.find_by(id: params[:id])
        if @user
            if params["file"]
                file = params["file"].tempfile
                if @user.public_img_id
                    deleteFromCloud(@user.public_img_id)
                end
                cloudRet = uploadToCloud(file)
                @user.update(image_url: cloudRet["url"], public_img_id: cloudRet["public_id"])
                render json: @user
            elsif params["address"]
                render json: @user.update(address: params[:address])
            elsif params["radius"]
                render json: @user.update(radius_concern: params[:radius].to_i)
            end
        end
    end

    def login
        @user = User.find_by(username: params[:username])
        if(@user)
            if(@user.authenticate(params[:password]))
                render json: {token: gen_user_token(@user), user_id: @user[:id]}
            else
                render json: {errors: {password: ["is incorrect"]}}
            end
        else
            render json: {errors: {username: [": no account matching that username"]}}
        end
    end

    def create
        @user = User.create(username: params[:username], password: params[:password])
        if @user.valid?
            render json: {token: gen_user_token(@user), user_id: @user[:id]}
        else
            render json: {errors: @user.errors}
        end
    end

    private

    #generates a user token with hmac encryption. Secret stored in non-committed yml credentials file
    #de-encryption accesses the same secret key, confirms token id matches decrypted id
    
    def gen_user_token(user)
        hmac_secret = Rails.application.credentials[:hmac][:secret_key]
        payload = {
            user_id: user[:id]
        }
        token = JWT.encode payload, hmac_secret, 'HS256'
        token
    end

    def authenticate
        hmac_secret = Rails.application.credentials[:hmac][:secret_key]
        token = JSON.parse(request.headers["Authorization"])
        decoded = JWT.decode token["token"], hmac_secret, true, { algorithm: 'HS256' }
        if
            decoded[0]["user_id"] == token["user_id"]
            return
        else
            render json: {unauthorized: {go_away: "Go Away"}}
        end
    end

    #uses Cloudinary server specs to authorize uploads and deletions from external server

    def uploadToCloud(file)
        auth = {
            cloud_name: 'dzzbsrh9a',
            api_key: '499476266595425',
            api_secret: '93EtXNtQuJNZcBOWODqGHx-_nWQ',
            resource_type: "raw"
        }
        return Cloudinary::Uploader.upload(file, auth)
    end

    def deleteFromCloud(name)
        auth = {
            cloud_name: 'dzzbsrh9a',
            api_key: '499476266595425',
            api_secret: '93EtXNtQuJNZcBOWODqGHx-_nWQ',
            resource_type: "raw"
        }
        Cloudinary::Uploader.destroy(name, auth)
    end
end
