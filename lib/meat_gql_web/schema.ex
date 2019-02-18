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
