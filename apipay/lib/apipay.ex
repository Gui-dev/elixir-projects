defmodule Apipay do
  alias Apipay.Users.Create, as: UserCreate
  alias Apipay.Accounts.Deposit

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate deposit(params), to: Deposit, as: :call
end
