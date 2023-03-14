defmodule ECommersCa.Infrastructure.Adapters.Repository.Invoice.InvoiceDataRepository do
  alias ECommersCa.Infrastructure.Adapters.Repository.Repo
  alias ECommersCa.Infrastructure.Adapters.Repository.Invoice.Data.InvoiceData
  # alias ECommersCa.Domain.Model.Invoice

  ## TODO: Update behaviour
  # @behaviour ECommersCa.Domain.Behaviours.InvoiceBehaviour

  def find_by_id(id), do: InvoiceData |> Repo.get(id) |> to_entity

  def create(entity) do
    case to_data(entity) |> Repo.insert do
      {:ok, entity} -> entity |> to_entity()
      error -> error
    end
  end

  defp to_entity(nil), do: nil
  defp to_entity(data) do
    ## TODO: Update Entity
    struct(Invoice, data |> Map.from_struct)
    %{}
  end

  defp to_data(entity) do
    struct(InvoiceData, entity |> Map.from_struct)
  end
end
