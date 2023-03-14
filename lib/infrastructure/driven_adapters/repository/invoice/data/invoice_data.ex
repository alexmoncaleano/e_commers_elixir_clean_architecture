defmodule ECommersCa.Infrastructure.Adapters.Repository.Invoice.Data.InvoiceData do
  use Ecto.Schema
  alias ECommersCa.Infrastructure.Adapters.Repository.Client.Data.ClientData

  ## TODO: Add schema definition
  # Types https://hexdocs.pm/ecto/Ecto.Schema.html#module-primitive-types

  @primary_key {:id, :binary_id, autogenerate: false}
  schema "invoices" do
    field :items, {:array, :map}
    field :price, :float
    field :status, :string
    field :tax, :float
    belongs_to :client, ClientData
    #many_to_many :products, ECommers.Products.Product, join_through: "invoice_products"
    timestamps()
  end
end
