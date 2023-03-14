defmodule ECommersCa.Domain.UseCase.CreateClientUseCase do
alias ECommersCa.Domain.Model.Client

@client_behaviour Application.compile_env(:e_commers_ca, :client_behaviour)
@generic_uuid_behaviour Application.compile_env(:e_commers_ca, :generic_uuid_behaviour)

def create(attrs \\ %{}) do
  id = @generic_uuid_behaviour.generate_uuid()

  IO.inspect(attrs)
  with {:ok, client} <- Client.new(id, attrs["doc_type"], attrs["id_number"],
  attrs["first_name"], attrs["last_name"], attrs["address"], attrs["phone"], attrs["email"]),
       { _, new} <- @client_behaviour.create(client) do
         {:ok, new}
       end
  end
end
