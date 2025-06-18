import Config

config :anoma_sdk,
  # the list of targets the SDK will be precompiled for. changes to this list must
  # be keps in sync with the CI file (rustler.yml).
  targets: [
    "aarch64-apple-darwin",
    "x86_64-apple-darwin",
    "x86_64-unknown-linux-gnu"
  ]
