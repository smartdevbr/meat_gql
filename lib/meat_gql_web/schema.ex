defmodule MeatGqlWeb.Schema do
  use Absinthe.Schema
  alias MeatGqlWeb.Resolver
  alias MeatGqlWeb.Schema.MiddleWare
  # import types
  import_types(MeatGqlWeb.Schema.Types)

  query do
    @desc "Get a list of all restaurants"
    field :restaurants, list_of(:restaurant_type) do
      # middleware(MiddleWare.Authorize, :any)
      resolve(&Resolver.RestaurantResolver.restaurants/3)
    end

    @desc "Get a list of all users"
    field :users, list_of(:user_type) do
      # middleware(MiddleWare.Authorize, :any)
      resolve(&Resolver.UserResolver.users/3)
    end
  end

  mutation do
    @desc "Register a new user"
    field :register_user, type: :user_type do
      arg(:input, non_null(:user_input_type))
      resolve(&Resolver.UserResolver.register_user/3)
    end

    @desc "Login a user and return a jwt token"
    field :login_user, type: :session_type do
      arg(:input, non_null(:session_input_type))
      resolve(&Resolver.SessionResolver.login_user/3)
    end

    @desc "Create a Restaurant"
    field :create_restaurant, type: :restaurant_type do
      arg(:input, non_null(:restaurant_input_type))
      resolve(&Resolver.RestaurantResolver.create_restaurant/3)
    end

    @desc "update a Restaurant"
    field :update_restaurant, type: :restaurant_type do
      arg(:id, non_null(:id))
      arg(:input, non_null(:restaurant_input_type))
      resolve(&Resolver.RestaurantResolver.update_restaurant/2)
    end

    @desc "delete a Restaurant"
    field :delete_restaurant, type: :restaurant_type do
      arg(:id, non_null(:id))
      resolve(&Resolver.RestaurantResolver.delete_restaurant/2)
    end
  end

  # subscription do
  # end
end
