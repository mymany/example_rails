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
        context "ユーザが存在するとき" do
            it "期待するキーが存在すること" do
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
    end

    describe "POST /items", type: :post do
        subject { post "/api/v1/items", params: { item: req_params }}
        context "商品登録処理が成功したとき" do
            let(:user) { FactoryBot.create(:user) }
            let(:req_params) { {user_id: user.id, name: Faker::Name.initials, point: 100 } }
            it { expect{subject}.to change{ Item.count }.by(1) }
            it "期待するキーが存在すること" do
                subject
                json = JSON.parse(response.body)
                expect(json["id"]).to be_truthy
                expect(json["name"]).to eq req_params[:name]
                expect(json["point"]).to eq req_params[:point]
                expect(json["user_id"]).to eq req_params[:user_id]
            end
            it "ステータスコードが201であること" do
                subject
                expect(response).to have_http_status 201
            end
        end
    end

    describe "PUT /items", type: :put do
        subject { put "/api/v1/items/" + item.id.to_s, params: { item: req_params }}
        context "商品更新処理が成功したとき" do
            let(:item) { FactoryBot.create(:item) }
            let(:req_params) { {user_id: item.user.id, name: Faker::Name.initials, point: 100 } }
            it "期待するキーが存在すること" do
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
    end

    describe "DELETE /items", type: :delete do
        before do
            @item = FactoryBot.create(:item)
        end
        subject { delete "/api/v1/items/" + item.id.to_s }
        context "商品削除処理が成功したとき" do
            let(:item) {@item}
            it { expect{subject}.to change{ Item.count }.by(-1) }
            it "ステータスコードが200であること" do
                subject
                expect(response).to have_http_status 200
            end
        end
    end
end
