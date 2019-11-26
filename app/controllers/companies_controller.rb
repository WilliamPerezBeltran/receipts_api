class CompaniesController < ApplicationController
  def index 
  	@companies = Company.all 
  	render json: @companies 
  end

  def create 
  	@company = Company.new(company_params)
  	if @company.save
  		render json: {msg: "compañia creada satisfactoriamente"}, status: :ok
  	else
  		render json: { error: "Revise los parametros ingresados"}, status: :unauthorized
  	end
  end

  def update 
  	@company = Company.find(params[:id])
  	if @company.update(company_params)
  		render json: {msg: "compañia actualizada satisfactoriamente"}, status: :ok
  	else
  		render json: { error: "Revise los parametros ingresados"}, status: :unauthorized
  	end
  end

  def destroy
  	@company = Company.find(params[:id])
  	if @company.destroy
  		render json: {msg: "compañia eliminada satisfactoriamente"}, status: :ok
  	else
  		render json: { error: "error en la petición "}, status: :unauthorized
  	end
  end


end
