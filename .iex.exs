alias Anoma.Arm.Action
alias Anoma.Arm.ComplianceUnit
alias Anoma.Arm.ComplianceWitness
alias Anoma.Arm.Constants
alias Anoma.Arm.DeltaProof
alias Anoma.Arm.DeltaWitness
alias Anoma.Arm.ForwarderCalldata
alias Anoma.Arm.Leaf
alias Anoma.Arm.LogicProof
alias Anoma.Arm.MerklePath
alias Anoma.Arm.MerkleTree
alias Anoma.Arm.NullifierKey
alias Anoma.Arm.NullifierKeyCommitment
alias Anoma.Arm.Resource
alias Anoma.Arm.Transacttion
alias Anoma.Arm.TrivialLogicWitness

# :dbg.tracer()

# # :dbg.start()

# :dbg.p(:all, :c)

# :dbg.tpl(MerkleTree, :_, [])

# MerkleTree.new([])

compare = fn ->
  rust = Anoma.Arm.test()
  local = Anoma.test()

  for {k, v} <- Map.to_list(rust) do
    lv = Map.get(local, k)
    rv = v

    if lv != rv do
      IO.inspect({k, v}, label: "\ndifferent")
    end
  end
end
