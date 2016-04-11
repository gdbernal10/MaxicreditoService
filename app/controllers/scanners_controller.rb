class ScannersController < ApplicationController

  skip_before_action :verify_authenticity_token, :only =>  [:create,:index_by_user]

  def index
    puts('Inicio index')
    @Scanners = Scanner.all
    respond_to do |format|
      format.json {render json: @Scanners}
    end
  end

  def index_by_user
    puts('Inicio index_by_user')
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
    puts('Inicio create')
    result = false
    puts(params)
    params[:scanner].permit!
    @user = User.find_by_email(params[:email])
    if @user == nil
      @user = User.new(name:params[:name],lastName: params[:lastName],email:params[:email])

      puts("Guardo Usuario")
      puts(@user.email)

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
  end
end
