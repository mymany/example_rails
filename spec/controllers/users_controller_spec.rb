require 'rails_helper'

RSpec.describe "Users", type: :request do

    it 'get_users' do
        @user = FactoryBot.create(:user)
        get "/api/v1/users"
        @json = JSON.parse(response.body)
        @subject_user = @json.first

        expect(@subject_user["id"]).to be_truthy
        expect(@subject_user["email"]).to be_truthy
        @user.delete
    end
end
