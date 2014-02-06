class ClientPhonesController < ApplicationController
  before_action :set_client_phone, only: [:show, :edit, :update, :destroy]

  # GET /client_phones
  # GET /client_phones.json
  def index
    #@client_phones = ClientPhone.all
    @client = Client.find(params[:client_id])
    @client_phones = @client.client_phone.all
  end

  # GET /client_phones/1
  # GET /client_phones/1.json
  def show
    @client=Client.find(params[:client_id])
  end

  # GET /client_phones/new
  def new
    @client=Client.find(params[:client_id])
    @client_phone = ClientPhone.new
  end

  # GET /client_phones/1/edit
  def edit
    @client = Client.find(params[:client_id])
  end

  # POST /client_phones
  # POST /client_phones.json
  def create
    @client = Client.find(params[:client_id])
    @client_phone = ClientPhone.new(client_phone_params)

    respond_to do |format|
      if @client_phone.save
        format.html { redirect_to @client_phone, notice: 'Client phone was successfully created.' }
        format.json { render action: 'show', status: :created, location: @client_phone }
      else
        format.html { render action: 'new' }
        format.json { render json: @client_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_phones/1
  # PATCH/PUT /client_phones/1.json
  def update
    respond_to do |format|
      if @client_phone.update(client_phone_params)
        format.html { redirect_to @client_phone, notice: 'Client phone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @client_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_phones/1
  # DELETE /client_phones/1.json
  def destroy
    @client_phone.destroy
    respond_to do |format|
      format.html { redirect_to client_phones_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_phone
      @client_phone = ClientPhone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_phone_params
      params.require(:client_phone).permit(:phone, :client_id)
    end
end
