defmodule MeatGqlWeb.Plugs.Context do
    @behaviour Plug

    import Plug.Conn

    def init(opts), do: opts

    def call(conn, _) do
        IO.puts "========= context call plug"
        IO.inspect conn
        context = build_context(conn)
        IO.puts "============= build a cotext"
        IO.inspect context

        Absinthe.Plug.put_options(conn, context: context)
    end

    defp build_context(conn) do
        with ["Bearer" <> token] <- get_req_header(conn, "authorization"),
        {:ok, claims} <- MeatGql.Guardian.decode_and_verify(token), 
        {:ok, user} <- MeatGql.Guardian.resource_from_claims(claims) do
            %{current_user: user}
        else
            _ -> %{}
        end
    end
end