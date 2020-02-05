require 'jwt'

class UsersController < ApplicationController
    def index
        @users = User.all
        render json: @users
    end

    def login
        @user = User.find_by(username: params[:username])
        if(@user)
            if(@user.authenticate(params[:password]))
                render json: {token: gen_user_token(@user), user_id: @user[:id], username: @user[:username]}
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
            render json: {token: gen_user_token(@user), user_id: @user[:id], username: @user[:username]}
        else
            render json: {errors: @user.errors}
        end
    end

    private

    def gen_user_token(user)
        hmac_secret = 'seismik_sekrets'
        payload = {
            user_id: user[:id],
            username: user[:username]
        }
        token = JWT.encode payload, hmac_secret, 'HS256'
        token
    end
end
