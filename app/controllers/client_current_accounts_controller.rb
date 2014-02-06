class ClientCurrentAccountsController < ApplicationController
  def index
  end

  def show
  	@account_detail = ClientCurrentAccount.find(params[:id])
  	@client = Client.find(params[:client_id])
  	@first_payment = ClientReceipt.where(client_current_account_id: @account_detail.id).where(first_payment: 1)
  end
end
