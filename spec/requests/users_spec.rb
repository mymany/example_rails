
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

    describe "POST /users" do
        it 'post_user' do
            req_params = {
                email: 'dummy_user@example.com',
                password: 'password'
            }

            expect { post "/api/v1/users", params: { user: req_params } }.to change(User, :count).by(+1)

            @subject_user = JSON.parse(response.body)
            expect(@subject_user["id"]).to be_truthy
            expect(@subject_user["email"]).to be_truthy
            expect(@subject_user["point"]).to eq User::INITIAL_POINT
        end
    end
end
