require 'rails_helper'

RSpec.describe "Buys", type: :request do
    describe "GET /buys", type: :get do
        it 'レスポンスのデータが正しいこと' do
            @buy = FactoryBot.create(:buy)
            get "/api/v1/buys"
            @json = JSON.parse(response.body)
            @subject_buy = @json.first
            expect(@subject_buy["id"]).to be_truthy
            expect(@subject_buy["item_id"]).to be_truthy
            expect(@subject_buy["item_name"]).to be_truthy
            expect(@subject_buy["user_id"]).to be_truthy
            expect(@subject_buy["point"]).to be_truthy
            @buy.delete
        end
    end
    describe "POST /buys", type: :post do
        it "レスポンスのデータが正しいこと" do
        @user = FactoryBot.create(:user)
        @item = FactoryBot.create(:item)
        req_params = {
            user_id: @user.id,
            item_id: @item.id,
        }

        expect { post "/api/v1/buys", params: { buy: req_params } }.to change(Buy, :count).by(+1)
        @subject_buy = JSON.parse(response.body)['buy']
        expect(@subject_buy["id"]).to be_truthy
        expect(@subject_buy["status"]).to be_truthy
        expect(@subject_buy["user_id"]).to eq req_params[:user_id]
        expect(@subject_buy["item_id"]).to eq req_params[:item_id]
        expect(@subject_buy["point"]).to eq @item.point
        @user.delete
        @item.delete
        end
    end
end
