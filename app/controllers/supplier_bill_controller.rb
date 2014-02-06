class SupplierBillController < ApplicationController
  skip_before_filter :logged_in?, only:[:add_to_temp, :delete_row]
  before_action :set_supplier_bill_head, only:[:destroy, :show_details]
  before_action :set_collection_views, only:[:new]
  protect_from_forgery with: :null_session

  def new
  	@head = SupplierBillHead.new
  	@body = SupplierBillBody.new

    # select every body_temp from that IP
    @body_temps = BillBodyTemp.where(user_id: request.remote_ip)
  end

  def save
    # Save the bill head
    @head = SupplierBillHead.new(head_params)
    @head.total = BillBodyTemp.where(user_id: request.remote_ip).sum("quantity * price")
    if @head.save
      # Update Stock
      SupplierBillBody.update_stock(request.remote_ip)
      # Copies from temporal table to body table 
      @body_temps = BillBodyTemp.where(user_id: request.remote_ip)
      if SupplierBillBody.copyFromTemp(@head.id, request.remote_ip)
        redirect_to root_url
      else
        # put an error message
      end
    else
      redirect_to supplier_bills_new_path
    end
  end

  def add_to_temp
    # parse param from ajax
    @parsed_json = ActiveSupport::JSON.decode(params[:term])
    # creates the new object
    @new_obj = BillBodyTemp.new
    @new_obj.quantity = @parsed_json["quantity"]
    @new_obj.user_id = @parsed_json["ip"]
    @new_obj.price = @parsed_json["price"]
    @new_obj.product_id = @parsed_json["id"]
    if Product.exists?(@new_obj.product_id)
      if @new_obj.save
        # select every body_temp from that IP
        @body_temps = BillBodyTemp.where(user_id: request.remote_ip)
        # render the partial with @body_temps variable
        render partial: 'table', locals: { body_temps: @body_temps}   
      end
    end
  end

  def delete_row
    # finds the bill_body_temp with the id from the button sent with ajax
    @body_temps = BillBodyTemp.find(params[:term])
    @body_temps.destroy
    # select every body_temp from that IP
    @body_temps = BillBodyTemp.where(user_id: request.remote_ip)    
    # render the partial with @body_temps variable
    render partial: 'table', locals: { body_temps: @body_temps} 
  end

  def index
    @supplier_bills = SupplierBillHead.search(params[:supplier], params[:product]).order('date DESC').paginate(:page => params[:page], :per_page => 50)
  end

  def destroy
    if  SupplierBillBody.rollback_stock(@supplier_bill_head.id)
      @supplier_bill_head.destroy
      redirect_to root_url
    end
  end

  def show_details
    @records = SupplierBillBody.where(supplier_bill_head_id: params[:id])
  end

  def suggestions
    @products = Product.where("name ILIKE '%#{params[:query]}%' or cod ILIKE '%#{params[:query]}%'")
    # function .pluck() converts the active record in an array
    render :json => {:suggestions => @products.as_json(:only => [ :id, :name, :cod])}
  end

  private
    def set_collection_views
      @suppliers=Supplier.all.order('name ASC')
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier_bill_head
      @supplier_bill_head = SupplierBillHead.find(params[:id])
    end

  def head_params
      params.require(:head).permit(:supplier_id, :date, :total, :type, :number)
  end
end
