module Api
    module V1
        class BuysController < ApplicationController
        before_action :set_buy, only: [:show, :update, :destroy]

        def index
            @buys = Buy.all
            render "buys/index.json.jbuilder"
        end

        # def show
        #     render json: @buy
        # end

        def create
            @buy = Buy.new(buy_params)

            if @buy.save
                render "buys/create.json.jbuilder"
            else
                render json: @buy.errors, status: :unprocessable_entity
            end
        end

        # def update
        #     if @buy.update(buy_params)
        #     render json: @buy
        #     else
        #     render json: @buy.errors, status: :unprocessable_entity
        #     end
        # end

        # def destroy
        #     @buy.destroy
        # end

        private
            def set_buy
                @buy = Buy.find(params[:id])
            end

            def buy_params
                params.require(:buy).permit(:item_id, :user_id)
            end
        end
    end
end