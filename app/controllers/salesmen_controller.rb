class SalesmenController < ApplicationController
  before_action :set_salesman, only: [:show, :edit, :update, :destroy]

  # GET /salesmen
  # GET /salesmen.json
  def index
    @supplier = Supplier.find(params[:supplier_id])
    @salesmen = @supplier.salesmen.all
  end

  # GET /salesmen/1
  # GET /salesmen/1.json
  def show
    @supplier=Supplier.find(params[:supplier_id])
  end

  # GET /salesmen/new
  def new
    @supplier=Supplier.find(params[:supplier_id])
    @salesman = Salesman.new
  end

  # GET /salesmen/1/edit
  def edit
    @supplier = Supplier.find(params[:supplier_id])
  end

  # POST /salesmen
  # POST /salesmen.json
  def create
    @supplier = Supplier.find(params[:supplier_id])
    @salesman = Salesman.new(salesman_params)

    respond_to do |format|
      if @salesman.save
        format.html { redirect_to @supplier, notice: 'Salesman was successfully created.' }
        format.json { render action: 'show', status: :created, location: @salesman }
      else
        format.html { render action: 'new' }
        format.json { render json: @salesman.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salesmen/1
  # PATCH/PUT /salesmen/1.json
  def update
    respond_to do |format|
      if @salesman.update(salesman_params)
        format.html { redirect_to @salesman, notice: 'Salesman was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @salesman.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salesmen/1
  # DELETE /salesmen/1.json
  def destroy
    @salesman.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salesman
      @salesman = Salesman.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def salesman_params
      params.require(:salesman).permit(:name, :phone, :supplier_id)
    end
end
