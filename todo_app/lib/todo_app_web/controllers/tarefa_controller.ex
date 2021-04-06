defmodule TodoAppWeb.TarefaController do
  use TodoAppWeb, :controller
  alias TodoApp.Tarefa

  def new(conn, params) do
    IO.inspect conn
    changeset = Tarefa.changeset(%Tarefa{})

    render conn, "new.html", changeset: changeset
  end
end
