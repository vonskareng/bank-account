class Account < ApplicationRecord
  validates :account_id, presence: true, uuid: true
  validates :balance, numericality: {only_integer: true}, presence: true
end
