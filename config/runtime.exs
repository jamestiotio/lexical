import Config

cond do
  Code.ensure_loaded?(LoggerFileBackend) ->
    log_file_name = Path.join(File.cwd!(), "lexical.log")

    config :logger,
      handle_sasl_reports: true,
      handle_otp_reports: true,
      backends: [{LoggerFileBackend, :general_log}]

    config :logger, :general_log,
      path: log_file_name,
      level: :debug

  Code.ensure_loaded?(JsonRpcBackend) ->
    config :logger,
      backends: [JsonRpcBackend]

    config :logger, JsonRpcBackend,
      level: :debug,
      format: "$message",
      metadata: []

  true ->
    :ok
end