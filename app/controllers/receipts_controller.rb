# frozen_string_literal: true

class ReceiptsController < ApplicationController
  def index
    # @receipts = Receipt.all.order(id: :desc).includes(:company, :user).as_json(
    #   include: {
    #     company: { only: %i[name phone email] },
    #     user: { only: %i[name email] }
    #   }, except: %i[created_at updated_at]
    #   )

    # render json: @receipts

    params.slice(:number, :status, :date, :user_id, :company_id, :receipt_type)
    get_params=params.slice(:number, :status, :date, :user_id, :company_id, :receipt_type)
    final_params = {}
    get_params.each { |key, value| (value == "null" || value == "undefined" )?final_params[key]=nil : final_params[key]=value }
    final_params.delete_if { |_k, v| v.nil? }

    if final_params.values(&:value).uniq.all? &:blank?
      @receipts = Receipt.all.order(id: :desc).includes(:company, :user).as_json(
        include: {
          company: { only: %i[name phone email] },
          user: { only: %i[name email] }
        }, except: %i[created_at updated_at]
        )
      render json: @receipts
    else
      @receipts = Receipt.where(final_params).includes(:company, :user).as_json(
        include: {
          company: { only: %i[name phone email] },
          user: { only: %i[name email] }
        }, except: %i[created_at updated_at]
        )
      render json: @receipts
    end

  end

  def create
    params[:company_id] = JSON.parse(params[:selected_company])
    @receipt = Receipt.new(receipt_params)
    @receipt.user_id = current_user.id
    @receipt.company_id = params[:company_id][:id]

    @receipt.status = 'Pendiente'

    if @receipt.save

      if params[:attachments].present?
        unless create_image
          render json: { error: 'Error en la creación de la foto' }, status: :bad_request
        end

      end

      render json: @receipt, status: :ok
    else
      render json: { error: @receipt.errors }, status: :bad_request
    end
  end

  def create_image
    title = ''
    observation = ''
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
      render json: { receipt: @receipt, user: @user, company: @company }, status: :ok
    else
      render json: { error: 'Error en la peticion del find_by_id' }, status: :bad_request
    end
  end

  def get_consignations
    @receipt = Receipt.find(params[:receipt_id])
    @payment = @receipt.payments.first
    @consignations = @payment.consignations
    if @receipt
      render json: @consignations, status: :ok
    else
      render json: { error: 'Error en la peticion de get_consignations' }, status: :bad_request
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
