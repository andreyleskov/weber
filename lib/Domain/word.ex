defmodule Word.Commands do
  defmodule Create do
    defstruct [:normalForm, :language]
  end
end

defmodule Word.Events do
  defmodule Created do
    defstruct [:normalForm, :language]
  end
end

defmodule Word do

  defstruct [:normalForm, :language, :explanation, :antonyms, :synonyms, :examples, :images]

# public command API
  def execute(%Word{normalForm: nil},
              %Word.Commands.Create{normalForm: normalForm, language: language})
    when normalForm != nil and language != nil
  do
    %Word.Events.Created{normalForm: normalForm, language: language}
  end

# def open_account(%BankAccount{}, _account_number, initial_balance)
#   when initial_balance <= 0
#  do
#    {:error, :initial_balance_must_be_above_zero}
#  end

#  def open_account(%BankAccount{}, _account_number, _initial_balance) do
#    {:error, :account_already_opened}
#  end

  # state mutators

#  def apply(%BankAccount{} = account, %BankAccountOpened{account_number: account_number, initial_balance: initial_balance}) do
#    %BankAccount{account |
#      account_number: account_number,
#      balance: initial_balance
#    }
#  end
end
