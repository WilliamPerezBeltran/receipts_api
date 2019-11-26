# frozen_string_literal: true

class ReceiptsController < ApplicationController
  def index
    @receipts = Receipt.all
    render json: @receipts
  end

  def create
    @receipt = Receipt.new(receipt_params)
    if @receipt.save
      # pago anticipado
      payment = Payment.find_by(name: params[:pago_name])
      @receipt.payment = payment

      render json: @receipt, status: :ok
    else
      render json: { error: @receipt.errors }, status: :bad_request
    end
  end

  private

  def receipt_params
    params.require(:receipt).permit(:pay, :debt, :number, :status, :date, :user_id, :company_id)
  end
end
