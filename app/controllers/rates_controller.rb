class RatesController < ApplicationController

  skip_before_action :verify_authenticity_token, :only =>  [:create,:create_from_collection]

  def index
    puts('Inicio index')
    @rates = RatesController.all
                            .as_json(include: [
                                {products: {only: [:id,:code,:name,:description]}},
                                {rates: {only: [:minMonths,:maxMonths,:value]}},
                                {restrictions: {only: [:minSalary,:employee,:mesesemployee]}}
                            ])
    puts('Result')
    puts(@rates)
    result = ({list:@rates})
    respond_to do |format|
      format.json {render json: result }
    end

  end

  def self.all
    puts('BEGIN all')
    @rates = Bank.all
                 .joins(:products,:rates,:restrictions)
                 .where('rates.product_id = products.id')
                 .select('banks.id','banks.code','banks.name As bank')
                 .distinct()
                 #.as_json(include: [
                 #    {products: {only: [:id,:code,:name,:description]}},
                 #    {rates: {only: [:minMonths,:maxMonths,:value]}},
                 #    {restrictions: {only: [:minSalary,:employee,:mesesemployee]}}
                 #])
    puts('END all')
    return @rates
  end

  def create
    puts('Inicio create')
    puts(params)
    result = false
    params[:rate].permit!
    @rate = Rate.new(params[:rate])
    @bank = Bank.find_by_code(params[:bank_code])
    puts(@bank)
    @product = Product.find_by_code(params[:product_code])
    puts(@product)
    @rate.bank_id = @bank.id
    @rate.product_id = @product.id
    if @rate.save
      result = true
    end
    respond_to do |format|
      if result
        format.json { render json: @rate, status: :created }
      else
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_from_collection
    puts('Inicio create_from_collection')
    #puts(params[:_json][1])
    puts(params)
    result = true
    params.permit!
    params[:_json].each do |param|
      puts(param)

      @rate = Rate.new(minMonths: param[:minMonths],maxMonths: param[:maxMonths],value: param[:value])
      @bank = Bank.find_by_code(param[:bank_code])
      puts(@bank)
      @product = Product.find_by_code(param[:product_code])
      puts(@product)
      @rate.bank_id = @bank.id
      @rate.product_id = @product.id
      if !@rate.save and result
        result = false
      end
      puts('Result Value?')
      puts(result)
    end
    respond_to do |format|
      if result
        format.json { render json: @rate, status: :created }
      else
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  def index_by_product
    puts('Inicio index_by_product')
    @product =Product.find_by_code(params[:code])
    @rates = Rate.all.where(product_id: @product.id)
    respond_to do |format|
      format.json {render json: @rates}
    end
  end

  def index_by_bank
    puts('Inicio index_by_bank')
    #@bank =Bank.find_by_code(params[:code])
    bank_code = params[:code]
    @rates = Rate.all
                 .joins(:product,:bank)
                 .where('banks.code': bank_code).as_json(include: [:product, :bank, :rate])
    puts(@rates)
    #@product =Product.find_by_code(params[:code])
    result = {list:@rates}
    respond_to do |format|
      format.json {render json: result }
    end
  end
end
