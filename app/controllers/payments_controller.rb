class PaymentsController < ApplicationController

	def create
		@payment = Payment.new(payment_params)
		@payment.name = current_user.name
		@payment.date = params[:payment][:date]
		@receipt = Receipt.find( params[:payment][:receipt_id])

		# if params[:payment][:consignation_type].present?
			
		# end

		


		# @payment. 
		# whoPay = 


		# @receipt = Receipt.find(params[:receipt_id])
		# @payment_id = @receipt.payments[0].id
		# @consignation.payment_id = @payment_id

		if @payment.save
			# binding.pry

			if params[:photo].present?
				if !create_image
					render json: { error: "Error en la creación de la foto" }, status: :bad_request
				end
			end
			# binding.pry

			if params[:payment][:debt].to_i == 0
				# binding.pry
				@receipt.update(status: "Pagado")
				# @receipt.update(status: "recibido y cancelado", pay: params[:consignation][:pay], debt: params[:consignation][:debt])
			end
			# binding.pry
		end

		render json: @receipt, status: :ok
	end


	def create_image
		title =  ""
		# title =  params[:title_image]
		observation =  ""
		# observation =  params[:observation_photo]
		params[:photo] = JSON.parse(params[:photo])
		photosArray = params[:photo].map { |item| parse_image_data(item) }
		@photo = Photo.create(
			title: title,
			observation: observation,
			attachments: photosArray,
			payment_id: @payment.id,
			refund_id: nil,
			consignation_id: nil,
			)
		@payment.update(photo: @photo.attachments)
	end

	def get_payments
		@receipt = Receipt.find(params[:receipt_id])
		payments = @receipt.payments

		render json: payments, status: :ok

	end


	private
	def payment_params
		params.require(:payment).permit(:name, :receipt_id, :total_payment, :pay, :debt, :observation,:consignation_type, :date)
	end
	def parse_image_data(data)
		filename = data[:fileName]
		in_content_type = 'data:' + data[:type]
		encoding = 'base64'
		string = data[:data]

		@tempfile = Tempfile.new(filename)
		@tempfile.binmode
		@tempfile.write Base64.decode64(string)
		@tempfile.rewind
	    # for security we want the actual content type, not just what was passed in
	    content_type = `file --mime -b #{@tempfile.path}`.split(';')[0]
	    # we will also add the extension ourselves based on the above
	    # if it's not gif/jpeg/png, it will fail the validation in the upload model
	    extension = content_type.match(/gif|jpeg|png|jpg/).to_s
	    filename += ".#{extension}" if extension
	    ActionDispatch::Http::UploadedFile.new(
	    	tempfile: @tempfile,
	    	content_type: content_type,
	    	filename: filename
	    	)
	end




end
