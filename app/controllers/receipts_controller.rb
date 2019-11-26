class ReceiptsController < ApplicationController
	def index
		@receipts = Receipt.all
		render json: @receipts
	end

	def create
		@receipt = Receipt.new(receipt_params)

		# company = Company.find(params[:receipt][:company_id])
		params[:receipt][:user_id] = current_user.id
		# params[:receipt][:company_id] = company
		if params[:receipt][:payment_id] != nil
			# payment = Payment.find(params[:receipt][:payment_id]) 
			# params[:receipt][:payment_id] = payment
			# params[:receipt][:refund_id] = nil if params[:receipt][:refund_id] = ""
		else
			puts "entro aca "
			# payment = Refund.find_by(name: params[:receipt][:payment_id]) 
			# params[:receipt][:payment_id] = payment
			# params[:receipt][:refund_id] = nil

		end 

		# binding.pry

		if @receipt.save!
			render json: {
				msg: "recibo guardado satisfactoriamente",
				status: :ok

			}
			
		end



	end

	private
	def receipt_params
		params.require(:receipt).permit(:pay,:debt,:company_id,:user_id,:number,:status,:payment_id,:date,:refund_id)

	end
end
