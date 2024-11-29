require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe "Api::V1::MenuItems", type: :request do
  describe "GET /api/v1/menu_items" do
    before do
      create_list(:menu_item, 3)
    end

    it "returns all menu items" do
      get api_v1_menu_items_path
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /api/v1/menu_items/:id" do
    let(:menu_item) { create(:menu_item) }

    it "returns the menu item" do
      get api_v1_menu_item_path(menu_item)
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["id"]).to eq(menu_item.id)
    end

    it "returns a 404 if the menu item is not found" do
      get api_v1_menu_item_path(id: 'nonexistent')
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ "error" => "Record not found" })
    end
  end
end

