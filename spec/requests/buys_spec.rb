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
end
