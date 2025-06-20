defmodule Anoma do
  alias Anoma.Arm.NullifierKey
  alias Anoma.Arm.Resource

  @test_guest_id [
    115,
    46,
    90,
    182,
    221,
    164,
    139,
    3,
    72,
    121,
    239,
    156,
    172,
    144,
    63,
    152,
    226,
    182,
    236,
    83,
    133,
    151,
    61,
    113,
    135,
    101,
    21,
    20,
    64,
    143,
    50,
    150
  ]

  def test do
    {_nullifier_key, commitment} = NullifierKey.random_pair()

    consumed_resource = %Resource{
      logic_ref: @test_guest_id,
      nk_commitment: commitment,
      label_ref: List.duplicate(0, 32),
      quantity: 0,
      value_ref: List.duplicate(0, 32),
      is_ephemeral: true,
      nonce: List.duplicate(0, 32),
      rand_seed: List.duplicate(0, 32)
    }

    _created_resource = consumed_resource
  end
end
