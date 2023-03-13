defmodule ECommersCa.Domain.Model.Client do
  defstruct [
    :id,
    :doc_type,
    :id_number,
    :first_name,
    :last_name,
    :address,
    :phone,
    :email,
    :invoices
  ]

  @type t() :: %__MODULE__{
          id: number() | nil,
          doc_type: String.t(),
          id_number: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          address: String.t(),
          phone: String.t(),
          email: String.t(),
          invoices: [%ECommersCa.Domain.Model.Invoice{}]
        }

  @spec new(
          number() | nil,
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          list()
        ) ::
          {:ok,
           %__MODULE__{
             id: number() | nil,
             doc_type: String.t(),
             id_number: String.t(),
             first_name: String.t(),
             last_name: String.t(),
             address: String.t(),
             phone: String.t(),
             email: String.t(),
             invoices: list(%ECommersCa.Domain.Model.Invoice{})
           }}
          | %{
              id: nil,
              doc_type: String.t(),
              id_number: String.t(),
              first_name: String.t(),
              last_name: String.t(),
              address: String.t(),
              phone: String.t(),
              email: String.t(),
              invoices: list(%ECommersCa.Domain.Model.Invoice{})
            }

  def new(id, doc_type, id_number, first_name, last_name, address, phone, email)
      when is_nil(doc_type) or is_nil(id_number) or is_nil(first_name) or is_nil(last_name) or
             is_nil(address) or is_nil(phone) or is_nil(email) do
    errors =
      %{
        doc_type:
          if is_nil(doc_type) do
            "The document type field is required"
          end,
        id_number:
          if is_nil(id_number) do
            "The document number field is required"
          end,
        first_name:
          if is_nil(first_name) do
            "The first name field is required"
          end,
        last_name:
          if is_nil(last_name) do
            "The last name field is required"
          end,
        address:
          if is_nil(address) do
            "The address field is required"
          end,
        phone:
          if is_nil(phone) do
            "The phone field is required"
          end,
        email:
          if is_nil(email) do
            "The email field is required"
          end
      }
      |> Enum.filter(fn {_key, value} -> value != nil end)
  end

  def new(id, doc_type, id_number, first_name, last_name, address, phone, email) do
    {:ok,
     %__MODULE__{
       id: id,
       doc_type: doc_type,
       id_number: id_number,
       first_name: first_name,
       last_name: last_name,
       address: address,
       phone: phone,
       email: email,
       invoices: invoices
     }}
  end
end
