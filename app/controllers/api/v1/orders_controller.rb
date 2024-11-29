module Api
  module V1
    class OrdersController < ApplicationController
      def index
        orders = Order.all
        render json: orders
      end

      def show
        order = Order.find(params[:id])
        render json: order
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Record not found' }, status: :not_found
      end

      def create
        order = Order.new(order_params)
        if order.save
          render json: order, status: :created
        else
          render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        order = Order.find(params[:id])
        if order.update(order_params)
          render json: order
        else
          render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Record not found' }, status: :not_found
      end

      def destroy
        order = Order.find(params[:id])
        order.destroy
        head :no_content
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Record not found' }, status: :not_found
      end

      private

      def order_params
        params.require(:order).permit(:total, :status)
      end
    end
  end
end 