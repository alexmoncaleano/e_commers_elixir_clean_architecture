defmodule ECommersCa.Domain.Model.Invoice do
  defstruct [
    :id,
    :items,
    :price,
    :status,
    :tax,
    :client_id,
    :client
  ]

  @type t() :: %__MODULE__{
          id: String.t() | nil,
          items: [map()],
          price: float(),
          status: String.t(),
          tax: float(),
          client_id: String.t() | nil,
          client: ECommersCa.Domain.Model.Client.t() | nil
        }

  @spec new(
          String.t() | nil,
          [map()],
          float(),
          String.t(),
          float(),
          String.t() | nil,
          ECommersCa.Domain.Model.Client.t() | nil
        )

  def new(id, items, price, status, tax, client_id | nil, client | nil)
      when is_nil(id) or is_nil(items) or is_nil(price) or is_nil(status) or is_nil(tax) do
    errors =
      %{
        items:
          if is_nil(items) do
            "The items field is required"
          end,
        price:
          if is_nil(price) do
            "The price field is required"
          end,
        status:
          if is_nil(status) do
            "The status field is required"
          end,
        tax:
          if is_nil(tax) do
            "The tax field is required"
          end
      }
      |> Enum.filter(fn {_key, value} -> value != nil end)
  end

  def new(id, items, price, status, tax, client_id \\ nil, client \\ nil) do
    {:ok,
     %__MODULE__{
       id: id,
       items: items,
       price: price,
       status: status,
       tax: tax,
       client_id: client_id,
       client: client
     }}
  end
end
