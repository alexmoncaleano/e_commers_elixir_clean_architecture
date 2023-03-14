defmodule ECommersCa.Infrastructure.Adapters.Repository.Product.ProductDataRepository do
  alias ECommersCa.Infrastructure.Adapters.Repository.Repo
  alias ECommersCa.Infrastructure.Adapters.Repository.Product.Data.ProductData
  alias ECommersCa.Domain.Model.Product

  ## TODO: Update behaviour
  @behaviour ECommersCa.Domain.Behaviours.ProductBehaviour

  def find_by_id(id), do: ProductData |> Repo.get(id) |> to_entity

  def create(entity) do
    case to_data(entity) |> Repo.insert do
      {:ok, entity} -> {:ok, entity |> to_entity()}
      error -> {:error, error}
    end
  end

  defp to_entity(nil), do: nil
  defp to_entity(data) do
    product = struct(Product, data |> Map.from_struct)
    {:ok, product}
  end

  defp to_data(entity) do
    struct(ProductData, entity |> Map.from_struct)
  end
end
