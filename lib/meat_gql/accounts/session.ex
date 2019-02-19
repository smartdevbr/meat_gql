defmodule MeatGql.Accounts.Session do
  alias MeatGql.Accounts.User
  alias MeatGql.Repo

  def authentication(args) do
    IO.puts("============ authentication ================")
    IO.inspect(args)
    user = Repo.get_by(User, email: String.downcase(args.email))

    case check_password(user, args) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end

  defp check_password(user, args) do
    IO.puts("================== check_password =================")
    IO.inspect(user)

    case user do
      nil -> Comeonin.Argon2.dummy_checkpw()
      _ -> Comeonin.Argon2.checkpw(args.password, user.password_hash)
    end
  end
end
