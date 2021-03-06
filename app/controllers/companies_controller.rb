# frozen_string_literal: true

class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    render json: @companies
  end

  def all_companies_for_filter
    # binding.pry
    @companies = Company.select('id,name')
    @all_companies = @companies.map { |value| { id: value[:id], label: value[:name], value: value[:name] } }

    render json: @all_companies
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      render json: { msg: 'compañia creada satisfactoriamente' }, status: :ok
    else
      render json: { error: 'Revise los parametros ingresados' }, status: :unauthorized
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      render json: { msg: 'compañia actualizada satisfactoriamente', company: @company }, status: :ok
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @company = Company.find(params[:id])
    if @company.destroy
      render json: { msg: 'compañia eliminada satisfactoriamente' }, status: :ok
    else
      render json: { error: 'error en la petición ' }, status: :unauthorized
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :type_identification, :identification, :address, :phone, :email, :bank, :type_account, :account_number)
  end
end
