defmodule ApipayWeb.AccountsController do
  use ApipayWeb, :controller

  alias Apipay.Account
  alias Apipay.Accounts.Transactions.Response, as: TransactionResponse

  action_fallback ApipayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Apipay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Apipay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    #task = Task.async(fn -> Apipay.transaction(params) end)
    #result = Task.await(task)

    with {:ok, %TransactionResponse{} = transaction} <- Apipay.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
