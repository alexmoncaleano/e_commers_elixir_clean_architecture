defmodule ECommersCa.Infrastructure.Adapters.Generic.UuidData do
  alias Ecto.UUID
  
  @behaviour ECommersCa.Domain.Behaviours.Generic.GenericUuidBehaviour

  def generate_uuid() do
    UUID.generate()
  end
end
