require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "GET /items" do
    it "レスポンスのデータが正しいこと" do
      @item = FactoryBot.create(:item)
      get "/api/v1/items"
      @json = JSON.parse(response.body)
      @subject_item = @json.first
      expect(@subject_item["id"]).to be_truthy
      expect(@subject_item["name"]).to be_truthy
      expect(@subject_item["point"]).to be_truthy
      expect(@subject_item["user_id"]).to be_truthy
      @item.delete
    end
  end

  describe "POST /items", type: :post do
    it "レスポンスのデータが正しいこと" do
      @user = FactoryBot.create(:user)
      req_params = {
        user_id: @user.id,
        name: 'dummy item',
        point: 100
      }
      expect { post "/api/v1/items", params: { item: req_params } }.to change(Item, :count).by(+1)
      @subject_item = JSON.parse(response.body)
      expect(@subject_item["id"]).to be_truthy
      expect(@subject_item["name"]).to eq req_params[:name]
      expect(@subject_item["point"]).to eq req_params[:point]
      expect(@subject_item["user_id"]).to eq req_params[:user_id]
      @user.delete
    end
  end

  describe "PUT /items", type: :put do
    it "レスポンスのデータが正しいこと" do
      @item = FactoryBot.create(:item)
      req_params = {
        user_id: @item.user.id,
        name: 'dummy item put',
        point: 200
      }
      put "/api/v1/items/" + @item.id.to_s, params: { item: req_params }
      @subject_item = JSON.parse(response.body)
      expect(@subject_item["id"]).to be_truthy
      expect(@subject_item["name"]).to eq req_params[:name]
      expect(@subject_item["point"]).to eq req_params[:point]
      expect(@subject_item["user_id"]).to eq req_params[:user_id]
      @item.delete
    end
  end

  describe "DELETE /items", type: :delete do
    it "レスポンスのデータが正しいこと" do
      @item = FactoryBot.create(:item)
      req_params = {
        user_id: @item.user.id,
        name: 'dummy item put',
        point: 200
      }
      expect { delete "/api/v1/items/" + @item.id.to_s }.to change(Item, :count).by(-1)
    end
  end
end
