defmodule ApipayWeb.UsersController do
  use ApipayWeb, :controller
  alias Apipay.User

  action_fallback ApipayWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Apipay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

end
