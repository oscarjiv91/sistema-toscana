class ProductDataController < ApplicationController
  before_action :set_product_datum, only: [:show, :edit, :update, :destroy]

  # GET /product_data
  # GET /product_data.json
  def index
    @product_data = ProductDatum.all
  end

  # GET /product_data/1
  # GET /product_data/1.json
  def show
  end

  # GET /product_data/new
  def new
    @product_datum = ProductDatum.new
  end

  # GET /product_data/1/edit
  def edit
  end

  # POST /product_data
  # POST /product_data.json
  def create
    @product_datum = ProductDatum.new(product_datum_params)

    respond_to do |format|
      if @product_datum.save
        format.html { redirect_to @product_datum, notice: 'Product datum was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product_datum }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_data/1
  # PATCH/PUT /product_data/1.json
  def update
    respond_to do |format|
      if @product_datum.update(product_datum_params)
        format.html { redirect_to @product_datum, notice: 'Product datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_data/1
  # DELETE /product_data/1.json
  def destroy
    @product_datum.destroy
    respond_to do |format|
      format.html { redirect_to product_data_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_datum
      @product_datum = ProductDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_datum_params
      params.require(:product_datum).permit(:quantity, :price, :product_id)
    end
end
