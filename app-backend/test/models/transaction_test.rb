require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test "should validate" do
    transaction = Transaction.new(account_id: "fbf4a552-2418-46c5-b308-6094ddc493a3", amount: 2)
    assert transaction.valid?
  end

  test "should not validate if uuid is invalid" do
    transaction = Transaction.new(account_id: "fbf4a552-2418-46c5-b308-6094ddca3", amount: 2)
    assert_not transaction.valid?
  end

  test "should not validate if amount is a string" do
    transaction = Transaction.new(account_id: "fbf4a552-2418-46c5-b308-6094ddc493a3", amount: "Ii23e")
    assert_not transaction.valid?
  end
end
