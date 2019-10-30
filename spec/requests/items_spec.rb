require 'rails_helper'

RSpec.describe "Items", type: :request do
    describe "GET /items", type: :get do
        subject { get "/api/v1/items" }
        @item
        before do
            @item = FactoryBot.create(:item)
        end
        after do
            @item.delete
        end
        context "すでに商品が存在するとき" do
            it "レスポンスに期待するキーが存在すること" do
                subject
                json = JSON.parse(response.body).first
                expect(json["id"]).to be_truthy
                expect(json["name"]).to be_truthy
                expect(json["point"]).to be_truthy
                expect(json["user_id"]).to be_truthy
            end
            it "ステータスコードが200であること" do
                subject
                expect(response).to have_http_status 200
            end
        end
        context "商品が存在しないとき" do
        end
    end

    describe "POST /items", type: :post do
        subject { post "/api/v1/items", params: { item: req_params }}
        let(:user) { FactoryBot.create(:user) }
        let(:valid_item_name) { Faker::Name.initials }
        context "期待するパラメータでリクエストされたとき" do
            let(:req_params) { {user_id: user.id, name: valid_item_name, point: 100 } }
            it { expect{subject}.to change{ Item.count }.by(1) }
            it "レスポンスに期待するキーが存在すること" do
                subject
                json = JSON.parse(response.body)
                expect(json["id"]).to be_truthy
                expect(json["name"]).to be_truthy
                expect(json["point"]).to be_truthy
                expect(json["user_id"]).to be_truthy
            end
            it "ステータスコードが201であること" do
                subject
                expect(response).to have_http_status 201
            end
        end
        context "期待するパラメータでリクエストされなかったとき" do
            let(:req_params) { {user_id: -1, name: valid_item_name, point: 100 } }
            it { expect{subject}.to change{ Item.count }.by(0) }
            it "ステータスコードが422であること" do
                subject
                expect(response).to have_http_status 422
            end
        end
        context "期待するパラメータでnameが空文字でリクエストされたとき" do
            let(:req_params) { {user_id: user.id, name: '', point: 100 } }
            it { expect{subject}.to change{ Item.count }.by(0) }
            it "ステータスコードが422であること" do
                subject
                expect(response).to have_http_status 422
            end
        end
        context "期待するパラメータでpointが空文字でリクエストされたとき" do
            let(:req_params) { {user_id: user.id, name: valid_item_name, point: '' } }
            it { expect{subject}.to change{ Item.count }.by(0) }
            it "ステータスコードが422であること" do
                subject
                expect(response).to have_http_status 422
            end
        end
        context "期待するパラメータでpointが文字列でリクエストされたとき" do
            let(:req_params) { {user_id: user.id, name: valid_item_name, point: 'one hundred' } }
            it { expect{subject}.to change{ Item.count }.by(0) }
            it "ステータスコードが422であること" do
                subject
                expect(response).to have_http_status 422
            end
        end
    end

    describe "PUT /items", type: :put do
        subject { put "/api/v1/items/" + item.id.to_s, params: { item: req_params }}
        let(:valid_item_name) { Faker::Name.initials }
        let(:item) { FactoryBot.create(:item) }
        let(:valid_item_name) { Faker::Name.initials }
        context "期待するパラメータでリクエストされたとき" do
            let(:req_params) { {user_id: item.user.id, name: valid_item_name, point: 100 } }
            it "レスポンスに期待するキーが存在すること" do
                subject
                json = JSON.parse(response.body)
                expect(json["id"]).to be_truthy
                expect(json["name"]).to be_truthy
                expect(json["point"]).to be_truthy
                expect(json["user_id"]).to be_truthy 
            end
            it "データが更新されていること" do
                subject
                json = JSON.parse(response.body)
                expect(json["name"]).to eq req_params[:name]
                expect(json["point"]).to eq req_params[:point]
                expect(json["user_id"]).to eq req_params[:user_id]
            end
            it "ステータスコードが200であること" do
                subject
                expect(response).to have_http_status 200
            end
        end
        context "期待するパラメータでリクエストされなかったとき" do
            let(:req_params) { {user_id: -1, name: valid_item_name, point: 100 } }
            it "ステータスコードが422であること" do
                subject
                expect(response).to have_http_status 422
            end
        end
    end

    describe "DELETE /items", type: :delete do
        before do
            @item = FactoryBot.create(:item)
        end
        subject { delete "/api/v1/items/" + item.id.to_s }
        context "期待するパラメータでリクエストされたとき" do
            let(:item) {@item}
            it { expect{subject}.to change{ Item.count }.by(-1) }
            it "ステータスコードが200であること" do
                subject
                expect(response).to have_http_status 200
            end
        end
        context "期待するパラメータでリクエストされなかったとき" do
            let(:item) {@item}
            it "ステータスコードが404であること" do
                item.id = -1
                subject
                expect(response).to have_http_status 404
            end
        end
    end
end
