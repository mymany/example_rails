module Api
    module V1
        class UsersController < ApplicationController
            before_action :set_user, only: [:show, :update, :destroy]

            def index
                @users = User.all
                render json: @users
            end

            def create
                @user = User.new(user_params)
                @user.point = User::INITIAL_POINT
                begin
                    @user.save!
                    render json: @user, status: :created
                rescue => e
                    logger.error(e)
                    render status: :unprocessable_entity, json: {message: e.message }
                end
            end

            private
            def user_params
                params.require(:user).permit(:email, :password)
            end

            def set_user
            #   params.require(:user).permit(:email)
            end
        end
    end
end
