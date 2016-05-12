class ScannersController < ApplicationController

  skip_before_action :verify_authenticity_token, :only =>  [:create,:update,:destroy,:index_by_user, :send_rates_notification_all, :send_rates_notification_by_user]

  def index
    puts('BEGIN INDEX')
    @Scanners = Scanner.all
    respond_to do |format|
      format.json {render json: @Scanners}
    end
  end

  def index_by_user
    puts('BEGIN INDEX_BY_USER')
    puts(params);
    puts(params[:email])
    params.permit!
    user = User.find_by_email(params[:email])
    if user != nil
      @Scanners = Scanner.all.where(user_id: user.id)
      respond_to do |format|
        format.json {render json: @Scanners}
      end
    else
      respond_to do |format|
        format.json { render json: "", status: :not_found }
      end
    end
  end

  def create
    puts('BEGIN CREATE')
    result = false
    puts(params)
    params[:scanner].permit!
    @user = User.find_by_email(params[:email])
    if @user == nil
      @user = User.new(name:params[:name],lastName: params[:lastName],email:params[:email])
      if !@user.save
        respond_to do |format|
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
    @scanner = Scanner.new(salary: params[:salary],
                           term: params[:term],
                           amount: params[:amount],
                           employee: params[:employee],
                           active: params[:active],
                           tn_email: params[:tn_email],
                           user_id: @user.id
    )
    if @scanner.save
      result = true
      @products = RatesController.all
      ScannerMailer.rates_notification(@scanner,@products).deliver
    end
    respond_to do |format|
      if result
        format.json { render json: @scanner, status: :created }
      else
        format.json { render json: @scanner.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    puts("BEGIN UPDATE")
    result = false
    params.permit!
    @scanner = Scanner.find(params[:id])
    puts(@scanner)
    if @scanner != nil
      @scanner.update(salary: params[:salary],
                      term: params[:term],
                      amount: params[:amount],
                      employee: params[:employee],
                      active: params[:active],
                      tn_email: params[:tn_email]
      )
      result = true
    end
    respond_to do |format|
      if result
        format.json { render json: "", status: :ok }
      else
        format.json { render json: "", status: :ok }
      end
    end
  end

  def destroy
    puts("BEGIN DESTROY")
    result = false
    params.permit!
    @scanner = Scanner.find(params[:id])
    if @scanner != nil
      @scanner.destroy
      result = true
    end
    respond_to do |format|
      if result
        format.json { render json: "", status: :ok }
      else
        format.json { render json: "", status: :not_found }
      end
    end
  end

  def send_rates_notification_all
    puts('BEGIN send_rates_notification_all')
    @products = RatesController.all
    @scanners = Scanner.all.joins(:user).where(active:1)
    @scanners.each do | s |
      ScannerMailer.rates_notification(s,@products).deliver
    end
    puts('END send_rates_notification_all')
    respond_to do |format|
      format.json { render json: "", status: :ok }
    end
  end

  def send_rates_notification_by_user
    puts('BEGIN send_rates_notification_by_user')
    params.permit!
    @products = RatesController.all
    @scanners = Scanner.all.joins(:user).where("active=1 and users.email =  '" + params[:email] + "'")
    #@scanners = Scanner.all.joins(:user).where('active=1 and user.email =' + params[:email])
    @scanners.each do | s |
      ScannerMailer.rates_notification(s,@products).deliver
    end
    puts('END send_rates_notification_by_user')
    respond_to do |format|
      format.json { render json: "", status: :ok }
    end
  end
end
