defmodule ECommersCa.Infrastructure.Adapters.Repository.Product.Data.ProductData do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: false}
  schema "products" do
    field :description, :string
    field :name, :string
    field :price, :float
    #many_to_many :invoices, ECommers.Invoices.Invoice, join_through: "invoice_products"

    timestamps()
  end
end
