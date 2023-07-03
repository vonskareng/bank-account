class TransactionsController < ApplicationController
  include ApplicationHelper
  def handle_transaction
    allowed_methods = ["GET", "POST"]
    unless allowed_methods.include?(request.method)
      return render plain: "Method Not Allowed", status: :method_not_allowed
    end
    if request.method == "GET"
      all
    else
      unless request.content_type == "application/json"
        return render plain: "Specified content type not allowed.", status: 415
      end
      create
    end
  end

  def all
    render json: Transaction.order(created_at: :desc).to_json(except: :id)
  end

  def transaction_by_id
    if !validate_uuid(params[:transaction_id])
      return render json: {error_message: "Transaction_id missing or has incorrect type."}, status: 400
    end
    transaction = Transaction.find_by(transaction_id: params[:transaction_id])
    if !transaction
      return render json: {error_message: "Transaction not found"}, status: :not_found
    end
    render json: transaction.to_json(except: :id)
  end

  def create
    transaction = Transaction.new(account_id: params[:account_id], amount: params[:amount])
    if transaction.invalid?
      return render json: {error_message: "account_id missing or has incorrect type."}, status: 400
    end
    account = Account.find_by(account_id: params[:account_id])
    if !account
      account = Account.new(account_id: params[:account_id], balance: 0)
    end
    account.balance += params[:amount]
    ActiveRecord::Base.transaction do
      if account.save && transaction.save
        render json: transaction.to_json, status: 201
      else
        raise ActiveRecord::Rollback
      end
    end
  end
end
