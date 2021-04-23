defmodule ApipayWeb.UsersViewTest do
  use ApipayWeb.ConnCase

  import Phoenix.View

  alias Apipay.{Account, User}
  alias ApipayWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "Gui Silva",
      email: "gui@email.com",
      password: "1234567",
      nickname: "gui",
      age: 36
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Apipay.create_user(params)
    response = render(UsersView, "create.json", user: user)

    expected_reponse = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
          id: user_id,
          name: "Gui Silva",
          nickname: "gui"
      }
    }

    assert expected_reponse == response
  end
end
