Each application needs its own ZKVM project in native.

Once you have generated that, you get a host folder.

The host folder contains your actual application, or the entrypoint to this application.
We dont need this, since the host will be elixir. But its a good thing to have to test your logic circuits in pure rust.

The methods folder contains your actual logic. The guest is the code that is used to generate the proofs. Think of this as the executable that runs and which is traced to generate a proof. You dont run this directly.

The src folder in methods contains the functions you need to actually run the proofs. These are the ones well call form Elixir.

First, we add a second project that will hold our rust code to wrap in nifs.