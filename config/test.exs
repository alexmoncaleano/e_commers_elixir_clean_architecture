import Config

config :e_commers_ca, timezone: "America/Bogota"

config :e_commers_ca,
  http_port: 8083,
  enable_server: true,
  secret_name: "",
  version: "0.0.1",
  in_test: true,
  custom_metrics_prefix_name: "e_commers_ca_test"

config :logger,
  level: :info

# tracer
config :opentelemetry,
  span_processor: :batch,
  traces_exporter: {:otel_exporter_stdout, []}
