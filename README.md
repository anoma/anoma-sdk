# Anoma SDK Elixir

The Anoma SDK exposes an API for developers to create applications in Elixir on
top of Anoma. The SDK exposes the core data structures (e.g., `Transaction`) and
their operationg (e.g., `prove`).


## Repository Organisation

The repository is intended to be used as a plain Elixir dependency. The
repository relies on Rustler to wrap the
[arm-risc0](https://github.com/anoma/arm-risc0) repository and expose its
functionality. See `native/arm` for its implementation.

## Using the SDK

Add the repository as a dependency in your `mix.exs`.

```elixir
defp deps do
  [
    {:jason, git: "https://github.com/anoma/anoma-sdk"}
  ]
end
```

To use the SDK, you need a few configuration parameters to create transactions.
Consult the below table.

Here's a markdown table with the environment variables and their descriptions:

| Variable                           | Description                                                         | Type        |
|------------------------------------|---------------------------------------------------------------------|-------------|
| `API_KEY_ALCHEMY`                  | Alchemy API key for blockchain node access and services             | String      |
| `PRIVATE_KEY`                      | Private key for blockchain wallet/account (64-character hex string) | 64-char hex |
| `PROTOCOL_ADAPTER_ADDRESS_SEPOLIA` | Contract address for the Protocol Adapter contract                  | String      |
| `RISC0_DEV_MODE`                   | Generate proofs or use fake proofs.                                 | Boolean     |
| `BONSAI_API_URL`                   | Bonsai URL                                                          | URL         |
| `BONSAI_API_KEY`                   | Authentication key for Bonsai API access                            | String      |

To find the latest protocol adapter address, see here.

> [!TIP]
> If you want to try local development without actually submitting transactions to
the protocol adapter, you can set `RISC0_DEV_MODE` to `true`. This will
significantly speed up the proof generation. Note that the proofs are not valid.