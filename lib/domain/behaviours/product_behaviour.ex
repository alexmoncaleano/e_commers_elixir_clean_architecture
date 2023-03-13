defmodule ECommersCa.Domain.Behaviours.ProductBehaviour do
alias ECommersCa.Domain.Model.Product

@callback create(Product.t()) :: {:ok, Product.t()} | {:error, atom()}

end
