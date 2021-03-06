# frozen_string_literal: true

class ConsignationsController < ApplicationController
  def create
    @consignation = Consignation.new(consignation_params)
    @receipt = Receipt.find(params[:receipt_id])
    @payment_id = @receipt.payments[0].id
    @consignation.payment_id = @payment_id

    if @consignation.save
      if params[:photo].present?
        unless create_image
          render json: { error: 'Error en la creación de la foto' }, status: :bad_request
        end

      end

      if params[:consignation][:debt].to_i == 0
        @receipt.update(status: 'recibido y cancelado', pay: params[:consignation][:pay], debt: params[:consignation][:debt])
      end
    end

    render json: @receipt, status: :ok
  end

  def create_image
    title = params[:title_image]
    observation =  params[:observation_photo]
    params[:photo] = JSON.parse(params[:photo])
    photosArray = params[:photo].map { |item| parse_image_data(item) }
    @photo = Photo.create(
      title: title,
      observation: observation,
      attachments: photosArray,
      payment_id: @payment_id,
      refund_id: nil,
      consignation_id: @consignation.id
    )
    @consignation.update(photo: @photo.attachments)
  end

  private

  def consignation_params
    params.require(:consignation).permit(:name, :date, :observation, :payment_id, :type_consignation, :credit, :pay, :debt)
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
