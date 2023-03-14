defmodule ECommersCa.Domain.UseCase.GetClientById do


  @client_behaviour Application.compile_env(:e_commers_ca, :client_behaviour)

  def get_by_id(id) do
    @client_behaviour.find_by_id(id)
  end

end
