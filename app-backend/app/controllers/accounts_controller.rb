class AccountsController < ApplicationController
  include ApplicationHelper
  def account_id
    if !validate_uuid(params[:account_id])
      return render json: {error_message: "Account_id missing or has incorrect type."}, status: 400
    end
    account = Account.find_by(account_id: params[:account_id])
    if !account
      return render json: {error_message: "Account not found"}, status: 404
    end
    render json: account.to_json(except: :id)
  end
end
