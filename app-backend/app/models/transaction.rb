require "securerandom"

class Transaction < ApplicationRecord
  validates :account_id, presence: true, uuid: true
  validates :amount, numericality: {only_integer: true}, presence: true
  before_create :default_transaction_id
  def created_at
    super.iso8601
  end

  private

  def default_transaction_id
    self.transaction_id = SecureRandom.uuid
  end
end
