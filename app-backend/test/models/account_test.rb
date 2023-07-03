require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "should create account with valid uuid" do
    account = Account.new(account_id: "fbf4a552-2418-46c5-b308-6094ddc493a3", balance: 0)
    assert account.valid?
  end

  test "should not create account with an invalid uuid" do
    account = Account.new(account_id: "I'm fake", balance: 0)
    assert_not account.valid?
  end

  test "should not create account without account_id and balance" do
    account = Account.new()
    assert_not account.valid?
  end
end
