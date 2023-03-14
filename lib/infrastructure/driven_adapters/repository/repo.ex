defmodule ECommersCa.Infrastructure.Adapters.Repository.Repo do
  use Ecto.Repo,
  otp_app: :e_commers_ca,
  adapter: Ecto.Adapters.Postgres
end
