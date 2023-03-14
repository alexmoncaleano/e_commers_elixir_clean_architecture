defmodule ECommersCa.Domain.UseCase.CreateProductUseCase do
  alias ECommersCa.Domain.Model.Product


  @product_behaviour Application.compile_env(:e_commers_ca, :product_behaviour)
  @generic_uuid_behaviour Application.compile_env(:e_commers_ca, :generic_uuid_behaviour)

  def create(attrs \\ %{}) do
    id = @generic_uuid_behaviour.generate_uuid()

    with {:ok, producto} <- Product.new(id, attrs["description"], attrs["name"], attrs["price"]),
         { _, new_producto} <- @product_behaviour.create(producto) do
          {_, product1} = new_producto
           {:ok, product1}
         end
  end
end
