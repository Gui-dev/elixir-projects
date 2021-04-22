defmodule Apipay.Users.CreateTest do
  use Apipay.DataCase

  alias Apipay.Repo
  alias Apipay.User
  alias Apipay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Gui Silva",
        email: "gui@email.com",
        password: "1234567",
        nickname: "gui",
        age: 36
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Gui Silva", age: 26, id: ^user_id} = user
    end
  end
end
