defmodule ECommersCa.Domain.UseCase.CreateInvoiceUseCase do
  alias ECommersCa.Domain.Model.Invoice

  @product_behaviour Application.compile_env(:e_commers_ca, :product_behaviour)

  def create(attrs) do
    with {:ok, invoice} <- Invoice.new(price(attrs)),
         {:ok, invoice1} <- @product_behaviour.create(invoice) do
           {:ok, invoice1}
         end
    end

    def price(attrs) do
      items = attrs["items"]
      |> Enum.map(fn %{ "product_id" => product_id, "quantity" => quantity } ->
       product = @product_behaviour.find_by_id(product_id)
       %{ product: product, quantity: quantity }
        end)
      total = Float.floor(Enum.reduce(items, 0.0, fn(item, acc) ->
          price = item.product.price
          quantity = item.quantity
          acc + (price * quantity)
        end), 2)
      tax = Float.floor((total * 19) /100, 2)
      id = @generic_uuid_behaviour.generate_uuid()
      %{"id" => id, "client_id" => attrs["client_id"], "items" => attrs["items"],
      "price" => total, "status" => "active", "tax" => tax}
    end

end
