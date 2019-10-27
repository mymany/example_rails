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
            it "期待するキーが存在すること" do
                subject
                json = JSON.parse(response.body).first
                expect(json["id"]).to be_truthy
                expect(json["item_id"]).to be_truthy
                expect(json["item_name"]).to be_truthy
                expect(json["user_id"]).to be_truthy
                expect(json["point"]).to be_truthy
            end
            it "ステータスコードが200であること" do
                subject
                expect(response).to have_http_status 200
            end
        end
    end

    describe "POST /buys", type: :post do
        subject{ post "/api/v1/buys", params: { buy: req_params }}
        context "購入処理が成功したとき" do
            let(:user) {FactoryBot.create(:user)}
            let(:item) {FactoryBot.create(:item)}
            let(:req_params) { {user_id: user.id, item_id: item.id} }
            it { expect{subject}.to change{ Buy.count }.by(1) }
            it "期待するキーが存在すること" do
                subject
                json = JSON.parse(response.body)['buy']
                expect(json["id"]).to be_truthy
                expect(json["status"]).to be_truthy
                expect(json["user_id"]).to eq req_params[:user_id]
                expect(json["item_id"]).to eq req_params[:item_id]
                expect(json["point"]).to eq item.point
            end
            it "ユーザのポイントが減算されていること" do
                subject
                expect(User.find(user.id)[:point]).to eq (user.point - item.point)
            end
            it "ステータスコードが正しいこと" do
                subject
                expect(response).to have_http_status 200
            end
        end

        context "購入処理が失敗したとき" do
            let(:user) { FactoryBot.create(:user) }
            let(:item_id) { -1 }
            let(:req_params) { {user_id: user.id, item_id: item_id} }
            it { expect{subject}.to change{ Buy.count }.by(0) }
            it "エラーメッセージ投げること" do
                subject
                json = JSON.parse(response.body)
                expect(json["message"]).to be_truthy
            end
            it "ステータスコードが422であること" do
                subject
                expect(response).to have_http_status 422
            end
        end
    end
end
