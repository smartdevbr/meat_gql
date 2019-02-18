defmodule MeatGqlWeb.Schema.Types do
    use Absinthe.Schema.Notation
    alias MeatGqlWeb.Schema.Types

    import_types(Types.RestaurantType)
end
