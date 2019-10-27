require 'rails_helper'

RSpec.describe "Buys", type: :request do
    describe "GET /buys", type: :get do
        subject { get "/api/v1/buys" }
        @buy
        before do
            @buy = FactoryBot.create(:buy)
        end
        after do
            @buy.delete
        end

        context "購入履歴が存在するとき" do
            it "期待するレスポンスのキーが存在する" do
                subject
                json = JSON.parse(response.body)
                @subject_buy = json.first
                expect(@subject_buy["id"]).to be_truthy
                expect(@subject_buy["item_id"]).to be_truthy
                expect(@subject_buy["item_name"]).to be_truthy
                expect(@subject_buy["user_id"]).to be_truthy
                expect(@subject_buy["point"]).to be_truthy
            end
            it "ステータスコードが200" do
                subject
                expect(response).to have_http_status 200
            end
        end
    end

    describe "POST /buys", type: :post do
        context "正常系" do
            it "レスポンスのデータが正しいこと" do
                @user = FactoryBot.create(:user)
                @item = FactoryBot.create(:item)
                req_params = {
                    user_id: @user.id,
                    item_id: @item.id,
                }
                expect { post "/api/v1/buys", params: { buy: req_params } }.to change(Buy, :count).by(+1)
                @subject_buy = JSON.parse(response.body)['buy']
                expect(response).to have_http_status 200
                expect(@subject_buy["id"]).to be_truthy
                expect(@subject_buy["status"]).to be_truthy
                expect(@subject_buy["user_id"]).to eq req_params[:user_id]
                expect(@subject_buy["item_id"]).to eq req_params[:item_id]
                expect(@subject_buy["point"]).to eq @item.point
                @user.delete
                @item.delete
            end
            it "ユーザのポイントが減算されていること" do
                # be_success
            end
            it "ステータスコードが正しいこと" do
                # be_success
            end
        end

        context "異常系" do
            it "例外を投げること" do
                @user = FactoryBot.create(:user)
                req_params = {
                    user_id: @user.id,
                    item_id: -1,
                }
                post "/api/v1/buys", params: { buy: req_params }
                json = JSON.parse(response.body)
                expect(json["message"]).to be_truthy
                expect(response).to have_http_status 422
            end
            it "ステータスコードが正しいこと" do
                # be_success
            end
        end
    end
end
