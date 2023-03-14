defmodule ECommersCa.Domain.UseCase.GetProductById do


  @product_behaviour Application.compile_env(:e_commers_ca, :product_behaviour)

  def get_by_id(id) do
    @product_behaviour.find_by_id(id)
  end

end
