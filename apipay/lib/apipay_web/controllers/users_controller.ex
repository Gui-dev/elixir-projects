defmodule ApipayWeb.UsersController do
  use ApipayWeb, :controller
  alias Apipay.User

  def create(conn, params) do
    params
    |> Apipay.create_user
    |> handle_response(conn)
  end

  defp handle_response({:ok, %User{} = user}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", user: user)
  end

  defp handle_response({:error, result}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApipayWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
