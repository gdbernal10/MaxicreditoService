class ProductsController < ApplicationController


  skip_before_action :verify_authenticity_token, :only =>  [:create,:update_by_code,:create_from_collection]


  def index
    puts('Inicio index')
    @products = Product.all
    respond_to do |format|
      format.json {render json: @products}
    end
  end

  def create
    puts('Inicio create')
    result = false
    params[:product].permit!
    @product = Product.new(params[:product])
    if @product.save
      result = true
    end
    @restriction = @product.restrictions.create(minSalary: params[:minSalary],employee: params[:employee] ,mesesemployee: params[:mesesemployee])
    respond_to do |format|
      if result
        format.json { render json: @product, status: :created }
      else
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_from_collection
  end

  def update_by_code
  end

end
