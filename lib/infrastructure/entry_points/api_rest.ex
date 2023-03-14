defmodule ECommersCa.Infrastructure.EntryPoint.ApiRest do

  @moduledoc """
  Access point to the rest exposed services
  """
  alias ECommersCa.Utils.DataTypeUtils
  alias ECommersCa.Infrastructure.EntryPoint.ErrorHandler
  alias ECommersCa.Domain.UseCase.CreateProductUseCase
  alias ECommersCa.Domain.UseCase.GetProductById
  alias ECommersCa.Domain.UseCase.CreateClientUseCase
  alias ECommersCa.Domain.UseCase.CreateInvoiceUseCase
  alias ECommersCa.Domain.Model.Product


  require Logger
  use Plug.Router
  use Timex

  plug(CORSPlug,
    methods: ["GET", "POST", "PUT", "DELETE"],
    origin: [~r/.*/],
    headers: ["Content-Type", "Accept", "User-Agent"]
  )

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug OpentelemetryPlug.Propagation
  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison)
  plug(Plug.Telemetry, event_prefix: [:e_commers_ca, :plug])
  plug(:dispatch)

  forward(
    "/e_commers_ca/api/health",
    to: PlugCheckup,
    init_opts: PlugCheckup.Options.new(json_encoder: Jason, checks: ECommersCa.Infrastructure.EntryPoint.HealthCheck.checks)
  )

  get "/e_commers_ca/api/product/:id" do
    case GetProductById.get_by_id(id) do
      {:ok, product} -> build_response(product, conn)
    end
  end

  post "/e_commers_ca/api/product/" do
    product_params = conn.body_params
    case CreateProductUseCase.create(product_params) do
      {:ok, product} -> build_response(product, conn)
      {:error, error} -> %{status: 500, body: error} |> build_response(conn)
    end
  end

  get "/e_commers_ca/api/client/:id" do
    case GetClientById.get_by_id(id) do
      {:ok, client} -> build_response(client, conn)
    end
  end

  post "/e_commers_ca/api/client/" do
    invoice_params = conn.body_params
    case CreateInvoiceUseCase.create(invoice_params) do
      {:ok, invoice} -> build_response(invoice, conn)
      {:error, error} -> %{status: 500, body: error} |> build_response(conn)
    end
  end

    post "/e_commers_ca/api/invoice/" do
      client_params = conn.body_params
      case CreateClientUseCase.create(client_params) do
        {:ok, client} -> build_response(client, conn)
        {:error, error} -> %{status: 500, body: error} |> build_response(conn)
      end
  end


  def build_response(response, conn) do
    case response do
      %{status: status, body: body} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(status, Poison.encode!(body))
      _ ->
        build_response(%{status: 200, body: response}, conn)
    end
  end

  #def build_response(%{status: status, body: body}, conn) do
  #  conn
  #  |> put_resp_content_type("application/json")
  #  |> send_resp(status, Poison.encode!(body))
  #end


  defp handle_error(error, conn) do
    error
    |> ErrorHandler.build_error_response()
    |> build_response(conn)
  end

  defp handle_bad_request(error, conn) do
    error
    |> ErrorHandler.build_error_response()
    |> build_bad_request_response(conn)
  end

  defp build_bad_request_response(response, conn) do
    build_response(%{status: 400, body: response}, conn)
  end

  defp handle_not_found(conn, :debug) do
    %{request_path: path} = conn
    body = Poison.encode!(%{status: 404, path: path})
    send_resp(conn, 404, body)
  end

  defp handle_not_found(conn, _level) do
    send_resp(conn, 404, "")
  end
end
