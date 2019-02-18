defmodule MeatGqlWeb.Router do
  use MeatGqlWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MeatGqlWeb do
    pipe_through :api
  end
end
