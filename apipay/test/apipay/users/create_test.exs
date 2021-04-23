defmodule Apipay.Users.CreateTest do
  use Apipay.DataCase, async: true

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

      assert %User{name: "Gui Silva", age: 36, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Gui Silva",
        email: "gui@email.com",
        nickname: "gui",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"], password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
