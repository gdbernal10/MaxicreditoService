class BanksController < ApplicationController

  skip_before_action :verify_authenticity_token, :only =>  [:create,:update_by_code,:create_from_collection, :set_bank_products]

  def index
    puts('Inicio index')
    @banks = Bank.all
    respond_to do |format|
      format.json {render json: @banks}
    end
  end

  def create
    puts('Inicio create')
    puts(params[:bank]);
    #puts(params[:bank][:email]);
    params[:bank].permit!
    @bank = Bank.new(params[:bank])
    respond_to do |format|
      if @bank.save
        format.json { render json: @bank, status: :created }
        format.xml { render xml: @bank, status: :created }
      else
        #format.json { render json: @user.errors, status: :not_found }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
        format.xml { render xml: @bank.errors, status: :unprocessable_entity }
        #format.xml { render xml: @user.errors, status: :uri_too_long }
      end
    end
  end

  def update_by_code
    respond_to do |format|
      puts('Inicio_update_by_code')
      puts(params[:bank])
      puts(params[:bank][:code])
      params[:bank].permit!
      @bank = Bank.find_by_code(params[:bank][:code]);
      #puts("Bank: #{@bank}")
      if @bank.update_attributes(params[:bank])
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @bank.errors, status: :unprocessable_entity }
        format.xml { render xml: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def create_from_collection
    puts('Inicio create_from_collection')
    #puts(params[:_json][1])
    puts(params)
    result = true
    params.permit!
    params[:_json].each do |bank|
      puts(bank)
      @bank = Bank.new(bank)
      puts('Saved?')
      puts(@bank.save)
      if !@bank.save and result
        result = false
      end
      puts('Result Value?')
      puts(result)
    end
    respond_to do |format|
      if result
        format.json { render json: @bank, status: :created }
      else
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_bank_products
    puts('Inicio set_bank_products')
    puts(params)
    result = true
    params[:_json].each do |p|
      puts(p)
      bank = Bank.find_by_code(p[:bank_code])
      product = Product.find_by_code(p[:product_code])
      @saved = bank.bank_products.create(product_id: product.id)
      puts('Created?')
      puts(@saved[:id] != nil)
      if !(@saved[:id] != nil) and result
          result = false
      end
    end
    respond_to do |format|
      if result
        format.json { render json: @saved, status: :created }
      else
        format.json { render json: @saved.errors, status: :unprocessable_entity }
      end
    end
  end
end
