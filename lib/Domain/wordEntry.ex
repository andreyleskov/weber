defmodule BankAccount do
  defstruct [:account_number, :balance]

  # public command API

  def open_account(%BankAccount{account_number: nil}, account_number, initial_balance)
    when initial_balance > 0
  do
   # %BankAccountOpened{account_number: account_number, initial_balance: initial_balance}
  end

  def open_account(%BankAccount{}, _account_number, initial_balance)
    when initial_balance <= 0
  do
    {:error, :initial_balance_must_be_above_zero}
  end

  def open_account(%BankAccount{}, _account_number, _initial_balance) do
    {:error, :account_already_opened}
  end

  # state mutators

  #def apply(%BankAccount{} = account, %BankAccountOpened{account_number: account_number, initial_balance: initial_balance}) do
  #  %BankAccount{account |
  ##    account_number: account_number,
   #   balance: initial_balance
  #  }
 # end
end
