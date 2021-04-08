defmodule ApipayWeb.WelcomeController do
  use ApipayWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome to the Apipay")
  end
end
