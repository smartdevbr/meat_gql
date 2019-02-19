defmodule MeatGqlWeb.Resolver.UserResolver do
  alias MeatGql.Accounts

  def users(_, _, %{context: context}) do
    IO.puts("============= context for users resolver =======")
    IO.inspect(context)

    {:ok, Accounts.list_users()}
  end

  def register_user(_, %{input: input}, _) do
    Accounts.create_user(input)
  end
end