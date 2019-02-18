defmodule MeatGqlWeb.Schema do
  use Absinthe.Schema
  alias MeatGqlWeb.Resolver
  # import types
  import_types(MeatGqlWeb.Schema.Types)

  query do
    @desc "Get a list of all restaurants"

    field :restaurants, list_of(:restaurant_type) do
      resolve(&Resolver.RestaurantResolver.restaurants/3)
    end
  end

  mutation do
    @desc "Create a Restaurant"
    field :create_restaurant, type: :restaurant_type do
      arg(:input, non_null(:restaurant_input_type))
      resolve(&Resolver.RestaurantResolver.create_restaurant/3)
    end
  end

  # subscription do
  # end
end
