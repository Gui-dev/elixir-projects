defmodule ApipayWeb.AccountsControllerTest do
  use ApipayWeb.ConnCase

  alias Apipay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Gui Silva",
        email: "gui@email.com",
        password: "1234567",
        nickname: "gui",
        age: 36
      }

      {:ok, %User{account: %Account{id: account_id}}} = Apipay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic YWRtaW46MTIzNDU2")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
        "account" => %{"balance" => "50.00", "id" => _id},
        "message" => "Balance changes successfully"
      } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "money"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid deposit value!"}
      assert response == expected_response
    end
  end
end
