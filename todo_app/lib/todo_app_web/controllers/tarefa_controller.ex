defmodule TodoAppWeb.TarefaController do
  use TodoAppWeb, :controller

  def new(conn, _params) do
    IO.inspect conn
    IO.puts '========'
    IO.inspect _params
  end
end
