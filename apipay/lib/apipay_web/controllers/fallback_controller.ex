defmodule ApipayWeb.FallbackController do
  use ApipayWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApipayWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
