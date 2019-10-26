module Api
    module V1
        class UsersController < ApplicationController
            before_action :set_user, only: [:show, :update, :destroy]

            def index
                @users = User.all
                render json: @users
            end
        end
    end
end
