defmodule ECommersCa.Utils.CustomTelemetry do
  alias ECommersCa.Utils.DataTypeUtils
  alias ECommersCa.Utils.CustomTelemetry
  import Telemetry.Metrics

  @service_name Application.compile_env!(:e_commers_ca, :custom_metrics_prefix_name)

  @moduledoc """
  Provides functions for custom telemetry events
  """

  def custom_telemetry_events() do
    :telemetry.attach("e_commers_ca-plug-stop", [:e_commers_ca, :plug, :stop], &CustomTelemetry.handle_custom_event/4, nil)
    :telemetry.attach("e_commers_ca-vm-memory", [:vm, :memory], &CustomTelemetry.handle_custom_event/4, nil)
    :telemetry.attach("vm-total_run_queue_lengths", [:vm, :total_run_queue_lengths], &CustomTelemetry.handle_custom_event/4, nil)
  end

  def execute_custom_event(metric, value, metadata \\ %{})
  def execute_custom_event(metric, value, metadata) when is_list(metric) do
    metadata = Map.put(metadata, :service, @service_name)
    :telemetry.execute([:elixir | metric], %{duration: value}, metadata)
  end
  def execute_custom_event(metric, value, metadata) when is_atom(metric) do
    execute_custom_event([metric], value, metadata)
  end

  def handle_custom_event([:e_commers_ca, :plug, :stop], measures, metadata, _) do
    :telemetry.execute(
      [:elixir, :http_request_duration_milliseconds],
      %{duration: DataTypeUtils.monotonic_time_to_milliseconds(measures.duration)},
      %{request_path: metadata.conn.request_path, service: @service_name}
    )
  end

  def handle_custom_event(metric, measures, metadata, _) do
    metadata = Map.put(metadata, :service, @service_name)
    :telemetry.execute([:elixir | metric], measures, metadata)
  end

  # Ecto
  def extract_metadata(%{source: source, result: {_, %{command: command}}}) do
    %{source: source, command: command, service: @service_name}
  end

def metrics do
    [
      #Ecto
      counter("elixir.repo.query.count",
        tag_values: &__MODULE__.extract_metadata/1,
        tags: [:source, :command, :service]
      ),
      distribution("elixir.repo.query.total_time",
        tag_values: &__MODULE__.extract_metadata/1,
        unit: {:native, :millisecond},
        tags: [:source, :command, :service],
        reporter_options: [
          buckets: [100, 200, 500]
        ]
      ),

      #Plug Metrics
      counter("elixir.http_request_duration_milliseconds.count", tags: [:request_path, :service]),
      sum("elixir.http_request_duration_milliseconds.duration", tags: [:request_path, :service]),

      # VM Metrics
      last_value("elixir.vm.memory.total", unit: {:byte, :kilobyte}, tags: [:service]),
      sum("elixir.vm.total_run_queue_lengths.total", tags: [:service]),
      sum("elixir.vm.total_run_queue_lengths.cpu", tags: [:service]),
      sum("elixir.vm.total_run_queue_lengths.io", tags: [:service]),
    ]
  end

end
