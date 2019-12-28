# frozen_string_literal: true

class ReceiptsController < ApplicationController
  def index
    # @receipts = Receipt.all
    @receipts =Receipt.all.order(id: :asc).includes( :company, :user,).as_json(
        include: {
          company: { only: [:name,:phone,:email] },
          user: { only: [:name,:email] },
        }, except: [:created_at, :updated_at])
    # @receipts = Receipt.all.includes(:company, :user)


    
     # render json: Receipt.all.order(id: :asc).includes( :company, :user,).as_json(
     #    include: {
     #      company: { only: [:name,:phone,:email] },
     #      user: { only: [:name,:email] },
     #    }, except: [:created_at, :updated_at])

    # binding.pry
    render json: @receipts
  end

  def create
    params[:company_id] = JSON.parse(params[:selected_company])
    @receipt = Receipt.new(receipt_params)
    @receipt.user_id = current_user.id
    @receipt.company_id = params[:company_id][:id]
    if params[:receipt_type] === "pago_anticipado"
      @receipt.status = "recibido y cancelado "
    elsif params[:receipt_type] === "pago_contra_entrega"
      @receipt.status = "recibido y cancelado "
    elsif params[:receipt_type] === "pago_credito"
      @receipt.status = "recibido"
    elsif params[:receipt_type] === "devolucion"
      @receipt.status = "recibido"
    end
    if @receipt.save

      payment = Payment.new(name: params[:receipt_type], receipt_id: @receipt.id)
      @receipt.payments << payment


      if params[:attachments].present?
        if !create_image
          render json: { error: "Error en la creación de la foto" }, status: :bad_request
        end
        
      end

      render json: @receipt, status: :ok
    else
      render json: { error: @receipt.errors }, status: :bad_request
    end
  end

  def create_image
    title =  params[:title_image]
    observation =  params[:observation_photo]
    params[:attachments] = JSON.parse(params[:attachments])
    photosArray = params[:attachments].map { |item| parse_image_data(item) }
    @photo = Photo.create(
      title: title,
      observation: observation,
      attachments: photosArray,
      payment_id: @receipt.payments[0].id,
      refund_id: nil,
      consignation_id: nil
      )
  end

  private

  def receipt_params
    params.require(:receipt).permit(:pay, :debt, :number, :status, :date, :user_id, :company_id, :pay_invoice)
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
