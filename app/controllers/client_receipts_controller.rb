class ClientReceiptsController < ApplicationController

  def new
  end

  def create
      @current_account = ClientCurrentAccount.find(params[:account])

      # Set params
      ammount = params[:ammount].to_i
      receipt_number = params[:number]
      payment_date = params[:date]
      description = params[:description]
      date = params[:date]

      # Save the receipt
      @receipt = ClientReceipt.new
      @receipt.ammount = ammount
      @receipt.number = receipt_number
      @receipt.client_current_account_id = @current_account.id
      @receipt.description = description
      @receipt.date = date
      @receipt.save

      #Goes through every client_fee
      @current_account.client_fees.order('id ASC').each_with_index do |cf, index|
        difference = cf.ammount - cf.ammount_paid
        # Check if fee is already paid
        if (cf.ammount != cf.ammount_paid) & (ammount > 0)
          if ammount <= difference
             cf.ammount_paid = cf.ammount_paid + ammount
             cf.payment_date = payment_date
             cf.receipt_id = @receipt.id
             cf.save
             break
          else 
               cf.ammount_paid = cf.ammount
               ammount = ammount - difference
               cf.payment_date = payment_date
               cf.receipt_id = @receipt.id
               cf.save
          end
        end
      end
      redirect_to root_url
  end

  def destroy
    @receipt = ClientReceipt.find(params[:id])
    @current_account = ClientCurrentAccount.find(@receipt.client_current_account_id)
    ammount = @receipt.ammount
    @current_account.client_fees.where("ammount_paid != 0").order('id DESC').each do |cf|
        difference = cf.ammount - cf.ammount_paid
        # Check if fee is already paid
        if (ammount > 0)
          if ammount <= cf.ammount_paid
             cf.ammount_paid = cf.ammount_paid - ammount
             cf.payment_date = nil
             cf.receipt_id = nil
             cf.save
             break
          else 
               ammount = ammount - cf.ammount_paid
               cf.ammount_paid = 0
               cf.payment_date = nil
               cf.receipt_id = nil
               cf.save
          end
        end
      end
      @receipt.destroy
      redirect_to root_url
  end

  def suggestions_client
    @clients = Client.where("name ILIKE '%#{params[:query]}%' or last_name ILIKE '%#{params[:query]}%'")
    # function .pluck() converts the active record in an array
    render :json => {:suggestions => @clients.as_json(:only => [ :id, :name, :last_name, :cod])}
  end

  def get_accounts
  	@accounts = ClientCurrentAccount.where("client_id = #{params[:query]}")
    # function .pluck() converts the active record in an array
    render :json => @accounts
  end

end
