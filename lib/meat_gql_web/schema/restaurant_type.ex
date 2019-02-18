defmodule MeatGqlWeb.Schema.Types.RestaurantType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: MeatGql.Repo

  object :restaurant_type do
    field :id, :uuid
    field :name, :string
    field :description, :string
    field :image, :string
  end

  input_object :restaurant_input_type do
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :image, non_null(:string)
  end
end
