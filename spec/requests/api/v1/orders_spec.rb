require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  describe "GET /api/v1/orders" do
    before do
      create_list(:order, 3)
    end

    it "returns all orders" do
      get api_v1_orders_path
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /api/v1/orders/:id" do
    let(:order) { create(:order) }

    it "returns the order" do
      get api_v1_order_path(order)
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["id"]).to eq(order.id)
    end

    it "returns a 404 if the order is not found" do
      get api_v1_order_path(id: 'nonexistent')
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/orders" do
    let(:valid_attributes) { { order: { total: "99.99", status: "pending" } } }

    it "creates a new order" do
      expect {
        post api_v1_orders_path, params: valid_attributes
      }.to change(Order, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it "returns validation errors for invalid data" do
      post api_v1_orders_path, params: { order: { total: nil, status: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /api/v1/orders/:id" do
    let(:order) { create(:order) }
    let(:new_attributes) { { order: { status: "completed" } } }

    it "updates the order" do
      put api_v1_order_path(order), params: new_attributes
      expect(response).to have_http_status(:success)
      order.reload
      expect(order.status).to eq("completed")
    end

    it "returns a 404 if the order is not found" do
      put api_v1_order_path(id: 'nonexistent'), params: new_attributes
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /api/v1/orders/:id" do
    let!(:order) { create(:order) }

    it "deletes the order" do
      expect {
        delete api_v1_order_path(order)
      }.to change(Order, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it "returns a 404 if the order is not found" do
      delete api_v1_order_path(id: 'nonexistent')
      expect(response).to have_http_status(:not_found)
    end
  end
end 