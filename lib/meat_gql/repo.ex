defmodule MeatGql.Repo do
  use Ecto.Repo,
    otp_app: :meat_gql,
    adapter: Ecto.Adapters.Postgres
end
