class IvasController < ApplicationController
  before_action :set_iva, only: [:show, :edit, :update, :destroy]

  # GET /ivas
  # GET /ivas.json
  def index
    @ivas = Iva.all
  end

  # GET /ivas/1
  # GET /ivas/1.json
  def show
  end

  # GET /ivas/new
  def new
    @iva = Iva.new
  end

  # GET /ivas/1/edit
  def edit
  end

  # POST /ivas
  # POST /ivas.json
  def create
    @iva = Iva.new(iva_params)

    respond_to do |format|
      if @iva.save
        format.html { redirect_to @iva, notice: 'Iva was successfully created.' }
        format.json { render action: 'show', status: :created, location: @iva }
      else
        format.html { render action: 'new' }
        format.json { render json: @iva.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ivas/1
  # PATCH/PUT /ivas/1.json
  def update
    respond_to do |format|
      if @iva.update(iva_params)
        format.html { redirect_to @iva, notice: 'Iva was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @iva.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ivas/1
  # DELETE /ivas/1.json
  def destroy
    @iva.destroy
    respond_to do |format|
      format.html { redirect_to ivas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_iva
      @iva = Iva.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def iva_params
      params.require(:iva).permit(:iva)
    end
end
