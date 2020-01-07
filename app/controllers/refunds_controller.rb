# frozen_string_literal: true

class RefundsController < ApplicationController
  def create
    @refund = Refund.new(refund_params)
    @refund.user_refund = current_user.name
    @receipt = Receipt.find(params[:refund][:receipt_id])
    if @refund.save

      new_pay_invoice = @receipt.pay_invoice - @refund.refund

      @receipt.update(pay_invoice: new_pay_invoice)

    end
    render json: @refund, status: :ok
  end

  def create_image
    title = ''
    observation =  ''
    params[:photo] = JSON.parse(params[:photo])
    photosArray = params[:photo].map { |item| parse_image_data(item) }
    @photo = Photo.create(
      title: title,
      observation: observation,
      attachments: photosArray,
      payment_id: @payment.id,
      refund_id: nil,
      consignation_id: nil
    )
    @payment.update(photo: @photo.attachments)
  end

  def get_refunds
    @receipt = Receipt.find(params[:receipt_id])
    refunds = @receipt.refunds

    render json: refunds, status: :ok
  end

  private

  def refund_params
    params.require(:refund).permit(:date, :receipt_id, :actual_payment, :refund, :observations)
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
    content_type = `file --mime -b #{@tempfile.path}`.split(';')[0]
    extension = content_type.match(/gif|jpeg|png|jpg/).to_s
    filename += ".#{extension}" if extension
    ActionDispatch::Http::UploadedFile.new(
      tempfile: @tempfile,
      content_type: content_type,
      filename: filename
    )
  end
end
