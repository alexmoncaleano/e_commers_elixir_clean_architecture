defmodule ECommersCa.Domain.Model.Product do

  defstruct [
    :id,
    :description,
    :name,
    :price
  ]

  @type t() :: %__MODULE__{
          id: binary(),
          description: String.t(),
          name: String.t(),
          price: float()
        }

  @spec new(binary(), String.t(), String.t(), float()) :: {:ok, __MODULE__.t()} | {:error, :invalid_attrs}
  def new(id, description, name, price) when is_nil(id) or is_nil(description) or is_nil(name) or price < 1 do
    errors =
      %{
        id:
        if is_nil(id) do
          "id is required"
        end,
        description:
          if is_nil(description) do
            "Description is required"
          end,
        name:
          if is_nil(name) do
            "Name is required"
          end,
        price:
          if price < 1 do
            "Price must be greater than 0"
          end
      }
      |> Enum.filter(fn {_key, value} -> value != nil end)

    {:error, errors}
  end

  def new(id, description, name, price) do
    {:ok, %__MODULE__{id: id, description: description, name: name, price: price}}
  end

end
