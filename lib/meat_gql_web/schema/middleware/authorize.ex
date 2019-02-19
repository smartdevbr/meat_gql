defmodule MeatGqlWeb.Schema.MiddleWare.Authorize do
    @beheaviour Absinthe.Middleware

    def call(resolution, role) do
        IO.puts "===============midddleware authorize"
        IO.inspect resolution
        IO.inspect role

        with %{current_user: current_user} <- resolution.context, true <- current_role?(current_user, role)
            IO.inspect current_user
            resolution
        else
            _ -> 
                resolution
                |> Absinthe.Resolution.put_result({:error, "unauthorized"})
        end
    end

    defp current_role?(%{}, :any), do: true
    defp current_role?(%{role: role}, :role), do: true
    # defp correct_role?(%{role: role}, role), do: true
    defp correct_role?(_, _), do: false
end