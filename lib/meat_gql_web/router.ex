defmodule MeatGqlWeb.Router do
  use MeatGqlWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/api", MeatGqlWeb do
  scope "/api" do
    pipe_through :api

    forward("/graphql", Absinthe.Plug, schema: MeatGqlWeb.Schema, json_codec: Jason)

    if(Mix.env() == :dev) do
      forward("/graphiql", Absinthe.Plug.GraphiQL,
        schema: MeatGqlWeb.Schema,
        json_codec: Jason
      )
    end
  end
end