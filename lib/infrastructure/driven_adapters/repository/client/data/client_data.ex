defmodule ECommersCa.Infrastructure.Adapters.Repository.Client.Data.ClientData do
  alias ECommersCa.Infrastructure.Adapters.Repository.Invoice.Data.InvoiceData
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: false}
  schema "clients" do
    field :address, :string
    field :doc_type, :string
    field :email, :string
    field :first_name, :string
    field :id_number, :string
    field :last_name, :string
    field :phone, :string
    has_many :invoices, InvoiceData


    timestamps()
  end
end
