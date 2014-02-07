class ClientBillController < ApplicationController
skip_before_filter :logged_in?, only:[:add_to_temp, :delete_row]
before_action :set_client_bill_head, only:[:destroy, :show_details]
protect_from_forgery with: :null_session

  def new
  	@head = ClientBillHead.new
  	@body = ClientBillBody.new

    # select every body_temp from that IP
    @body_temps = ClientBillBodyTemp.where(user_id: request.remote_ip)
  end

  def save
  	# Save the bill head
    @head = ClientBillHead.new(head_params)
    @head.total = ClientBillBodyTemp.where(user_id: request.remote_ip).sum("quantity * price")
    if @head.save
      # Update Stock
      ClientBillBody.update_stock(request.remote_ip)
      # Copies from temporal table to body table 
      @body_temps = ClientBillBodyTemp.where(user_id: request.remote_ip)
      ClientBillBody.copyFromTemp(@head.id, request.remote_ip)

      # Saving to current account if type is "financiado"
      if params[:head][:type] == "financiado"
          @current_account = ClientCurrentAccount.new
          @current_account.client_id = params[:head][:client_id]
          @current_account.client_bill_head_id = @head.id
          @current_account.status = "Pendiente"
          @current_account.save
          redirect_to payment_plan_path(@current_account.id), flash: {notice: "La factura se ha guardado correctamente. Elija un plan de pago."}
      else
          redirect_to "/client_bill/index"
      end
    else
      respond_to do |format|
        format.html { redirect_to "/client_bill/new", alert: 'Complete correctamente todos los campos de la cabecera.' }
      end
    end
  end

  def payment_plan
      @current_account = ClientCurrentAccount.find(params[:id])
      @client = Client.find(@current_account.client_id)
      @client_bill = ClientBillHead.find(@current_account.client_bill_head_id)
  end

  def save_payment_plan
    @quantity1 = params[:quantity]
    @ammount1 = params[:ammount]
    @quantity2 = params[:quantity2]
    @ammount2 = params[:ammount2]
    @quantity3 = params[:quantity3]
    @ammount3 = params[:ammount3]
    @expiration_date = Date.strptime(params[:expiration_date], "%Y/%m/%d")

    @current_account = ClientCurrentAccount.find(params[:current_account_id])
    # Check total ammount
    sum = @quantity1.to_i * @ammount1.to_i + @quantity2.to_i * @ammount2.to_i + @ammount3.to_i * @quantity3.to_i + params[:first_payment].to_i
    if !(sum == ClientBillHead.find(@current_account.client_bill_head_id).total)
       respond_to do |format|
             format.html { redirect_to payment_plan_path(params[:current_account_id]), alert: "La suma de las cuotas y la entrega no coincide con el monto total." }     
        end
        return
    end
    # Saves the client fee
    @expiration_date.to_time
    @quantity1.to_i.times do |q|
        @client_fee = ClientFee.new(:ammount=>@ammount1, :expiration_date =>@expiration_date, :payment_date => "", :client_current_account_id => params[:current_account_id], :ammount_paid => 0)
        @expiration_date = @expiration_date + 1.month
        @client_fee.save
    end
    if @quantity2.to_i > 0 
      @quantity2.to_i.times do |q|
        @client_fee = ClientFee.new(:ammount=>@ammount2, :expiration_date =>@expiration_date, :payment_date => "", :client_current_account_id => params[:current_account_id], :ammount_paid => 0)
        @expiration_date = @expiration_date + 1.month
        @client_fee.save
      end
    end
    if @quantity3.to_i > 0 
      @quantity3.to_i.times do |q|
        @client_fee = ClientFee.new(:ammount=>@ammount2, :expiration_date =>@expiration_date, :payment_date => "", :client_current_account_id => params[:current_account_id], :ammount_paid => 0)
        @expiration_date = @expiration_date + 1.month
        @client_fee.save
      end
    end

    # Save the receipt
    if (params[:first_payment].to_i > 0)
      @receipt = ClientReceipt.new(:ammount => params[:first_payment], :client_id => params[:client_id], :number => params[:receipt], :client_current_account_id => params[:current_account_id], :description => params[:description], :date => Time.now.strftime("%Y/%m/%d"), :first_payment => 1)
      if !@receipt.save
          respond_to do |format|
             format.html { redirect_to payment_plan_path(params[:current_account_id]), alert: 'Complete los campos de recibo. Si no hay entrega, deje el campo "Entrega" en 0' }     
          end
          return
      end
    end

    # Redirect to that client
    @clients = Client.find(@current_account.client_id)
    redirect_to @clients

  end

  def add_to_temp
    # parse param from ajax
    @parsed_json = ActiveSupport::JSON.decode(params[:term])
    # creates the new object
    @new_obj = ClientBillBodyTemp.new
    @new_obj.quantity = @parsed_json["quantity"]
    @new_obj.user_id = @parsed_json["ip"]
    @new_obj.price = @parsed_json["price"]
    @new_obj.product_id = @parsed_json["id"]
    if Product.exists?(@new_obj.product_id)
      if @new_obj.save
        # select every body_temp from that IP
        @body_temps = ClientBillBodyTemp.where(user_id: request.remote_ip)
        # render the partial with @body_temps variable
        render partial: 'table', locals: { body_temps: @body_temps}   
      end
    end
  end

  def show_details
    @records = ClientBillBody.where(client_bill_head_id: params[:id])
  end

  def index
    @client_bills = ClientBillHead.search(params[:product]).order('date DESC').paginate(:page => params[:page], :per_page => 50)
  end

  def destroy
    if ClientBillBody.rollback_stock(@client_bill_head.id)
       # ClientCurrentAccount.where(client_bill_head_id: params[:id]).destroy
        @client_bill_head.destroy
        redirect_to root_url
    end
  end

  def delete_row
    # finds the bill_body_temp with the id from the button sent with ajax
    @body_temps = ClientBillBodyTemp.find(params[:term])
    @body_temps.destroy
    # select every body_temp from that IP
    @body_temps = ClientBillBodyTemp.where(user_id: request.remote_ip)    
    # render the partial with @body_temps variable
    render partial: 'table', locals: { body_temps: @body_temps} 
  end

  def suggestions
    @products = Product.where("name ILIKE '%#{params[:query]}%' or cod ILIKE '%#{params[:query]}%'")
    # function .pluck() converts the active record in an array
    render :json => {:suggestions => @products.as_json(:only => [ :id, :name, :cod])}
  end

  def suggestions_client
    @clients = Client.where("name ILIKE '%#{params[:query]}%' or last_name ILIKE '%#{params[:query]}%'")
    # function .pluck() converts the active record in an array
    render :json => {:suggestions => @clients.as_json(:only => [ :id, :name, :last_name,:cod])}
  end

 private
  # Use callbacks to share common setup or constraints between actions.
  def set_client_bill_head
    @client_bill_head = ClientBillHead.find(params[:id])
  end

  def head_params
      params.require(:head).permit(:client_id, :date, :total, :type, :number, :ruc)
  end
end
