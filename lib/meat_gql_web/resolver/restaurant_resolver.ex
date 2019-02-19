defmodule MeatGqlWeb.Resolver.RestaurantResolver do
  alias MeatGql.Restaurants

  def create_restaurant(parents, %{input: input}, _) do
    with {:ok, restaurant} <- Restaurants.create_restaurant(input) do
      {:ok, restaurant}
    else
      {:error, _error} -> {:error, "Failed to create restaurant"}
    end
  end

  def restaurants(_, _, _), do: {:ok, Restaurants.list_restaurants()}

  def update_restaurant(%{id: id, input: input}, _info) do
    restaurant = Restaurants.get_restaurant!(id)

    case Restaurants.update_restaurant(restaurant, input) do
      {:ok, restaurant} -> {:ok, restaurant}
      {:error, _} -> {:error, "Failed to update restaurant"}
    end
  end

  def delete_restaurant(%{id: id}, _info) do
    restaurant_deleted = Restaurants.get_restaurant!(id)

    with {:ok, restaurant} <- Restaurants.delete_restaurant(restaurant_deleted) do
      {:ok, restaurant_deleted}
    else
      {:error, _} -> {:error, "Failed to delete Restaurant"}
    end
  end
end
