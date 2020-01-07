# frozen_string_literal: true

class ReceiptsController < ApplicationController
  def index
    @receipts =Receipt.all.order(id: :desc).includes( :company, :user,).as_json(
      include: {
        company: { only: [:name,:phone,:email] },
        user: { only: [:name,:email] },
      }, except: [:created_at, :updated_at])

    # binding.pry

    render json: @receipts
  end

  def create
    params[:company_id] = JSON.parse(params[:selected_company])
    @receipt = Receipt.new(receipt_params)
    @receipt.user_id = current_user.id
    @receipt.company_id = params[:company_id][:id]

    @receipt.status = "Pendiente"



    # if params[:receipt_type] === "pago_anticipado"
    #   @receipt.status = "recibido y cancelado "
    # elsif params[:receipt_type] === "pago_contra_entrega"
    #   @receipt.status = "recibido y cancelado "
    # elsif params[:receipt_type] === "pago_credito"
    #   @receipt.status = "recibido"
    # elsif params[:receipt_type] === "devolucion"
    #   @receipt.status = "recibido"
    # end


    if @receipt.save

      # payment = Payment.new(name: params[:receipt_type], receipt_id: @receipt.id)
      # @receipt.payments << payment


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
    title =  ""
    # title =  params[:title_image]
    observation =  ""
    # observation =  params[:observation_photo]
    params[:attachments] = JSON.parse(params[:attachments])
    photosArray = params[:attachments].map { |item| parse_image_data(item) }
    @photo = Photo.create(
      title: title,
      observation: observation,
      attachments: photosArray,
      payment_id: nil,
      refund_id: nil,
      consignation_id: nil,
      receipt_id: @receipt.id
      )
    @receipt.update(photo: @photo.attachments)
  end

  def find_by_id
    @receipt = Receipt.find(params[:receipt_id])
    @user = User.where(id: @receipt.user_id).select(:name, :email).first
    @company = Company.where(id: @receipt.company_id).select(:name).first

    if @receipt
      render json: {receipt: @receipt, user: @user, company: @company}, status: :ok
    else
      render json: { error: "Error en la peticion del find_by_id" }, status: :bad_request
    end
    
  end

  def get_consignations
    @receipt = Receipt.find(params[:receipt_id])
    @payment = @receipt.payments.first
    @consignations = @payment.consignations
    if @receipt
      render json: @consignations, status: :ok
    else
      render json: { error: "Error en la peticion de get_consignations" }, status: :bad_request
    end

  end

  private

  def receipt_params
    params.require(:receipt).permit(:pay, :debt, :number, :status, :date, :user_id, :company_id, :pay_invoice, :receipt_type, :observation)
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
