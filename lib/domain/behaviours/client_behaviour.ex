defmodule ECommersCa.Domain.Behaviours.ClientBehaviour do
  alias ECommersCa.Domain.Model.Client

  @callback create(Client.t()) :: {:ok, Client.t()} | {:error, atom()}

end
