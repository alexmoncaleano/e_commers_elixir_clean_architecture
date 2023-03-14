defmodule ECommersCa.Infrastructure.Adapters.Repository.Client.ClientDataRepository do
  alias ECommersCa.Infrastructure.Adapters.Repository.Repo
  alias ECommersCa.Infrastructure.Adapters.Repository.Client.Data.ClientData
  # alias ECommersCa.Domain.Model.Client

  ## TODO: Update behaviour
  @behaviour ECommersCa.Domain.Behaviours.ClientBehaviour

  def find_by_id(id), do: ClientData |> Repo.get(id) |> to_entity

  def create(entity) do
    case to_data(entity) |> Repo.insert do
      {:ok, entity} -> entity |> to_entity()
      error -> error
    end
  end

  defp to_entity(nil), do: nil
  defp to_entity(data) do
    ## TODO: Update Entity
    struct(Client, data |> Map.from_struct)
    %{}
  end

  defp to_data(entity) do
    struct(ClientData, entity |> Map.from_struct)
  end
end
