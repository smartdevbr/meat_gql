defmodule MeatGqlWeb.Resolver.RestaurantResolver do
    alias MeatGql.Restaurants
  
    def create_restaurant(parents,  %{input: input}, _) do
        Restaurants.create_restaurant input
    end

  end
  