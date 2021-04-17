defmodule ApipayWeb.AccountsController do
  use ApipayWeb, :controller

  alias Apipay.Account

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
end
