
require 'rails_helper'

RSpec.describe "Users", type: :request do
    describe "GET /users", type: :get do
        subject { get "/api/v1/users" }
        @user
        before do
            @user = FactoryBot.create(:user)
        end
        after do
            @user.delete
        end
        context "ユーザが存在するとき" do
            it "期待するキーが存在すること" do
                subject
                json = JSON.parse(response.body).first
                expect(json["id"]).to be_truthy
                expect(json["email"]).to be_truthy
            end
            it "ステータスコードが200であること" do
                subject
                expect(response).to have_http_status 200
            end
        end
    end

    describe "POST /users", type: :post do
        subject{ post "/api/v1/users", params: { user: req_params }}
        context "ユーザ作成処理が成功したとき" do
            let(:req_params) { {email: Faker::Internet.email, password: Faker::Alphanumeric.alphanumeric(number: 10) } }

            it { expect{subject}.to change{ User.count }.by(1) }
            it '期待するキーが存在すること' do
                subject
                json = JSON.parse(response.body)
                expect(json["id"]).to be_truthy
                expect(json["email"]).to be_truthy
                expect(json["point"]).to eq User::INITIAL_POINT
            end
            it "ステータスコードが200であること" do
                subject
                expect(response).to have_http_status 200
            end
        end
        context "ユーザ作成処理が失敗したとき" do
            let(:req_params) { {email: '', password: '' } }
            it { expect{subject}.to change{ User.count }.by(0) }
            it 'エラーメッセージを投げること' do
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
