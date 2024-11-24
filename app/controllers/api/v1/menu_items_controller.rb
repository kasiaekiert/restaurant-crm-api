module Api
  module V1
    class MenuItemsController < ApplicationController
      def index
        menu_items = MenuItem.all
        render json: menu_items
      end

      def show
        menu_item = MenuItem.find(params[:id])
        render json: menu_item
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Record not found' }, status: :not_found
      end
    end
  end
end 