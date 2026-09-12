# P913 verified native-scope proposal

Eligible patch: `proposed.patch`, targeting the frozen actual source
`1ef3fe6c...`. It reproduces `inputs/tail_expression.cpp` text exactly.

The two inner braces recover the native leaf-load and MONF empty parent blocks
and place their original `pmx` locals at depth 5. An ordinary final brace wrapper
was **falsified**: it disappears from debug and leaves only 47 of 48 scopes.
That failed assertion is preserved in `peer_scopes_attempt48.py`, with the actual
47-scope receipt in `scopes_carrier_peer_47.json`.

The authorized final **GNU statement expression**, containing only the three
existing separate ChangeTPage calls, restores native empty block27bd2a at depth
5, 8009BC74..8009BD64. It needs no new local, dummy expression, macro or qualifier.
The final proposal has **all 48 ordered native scopes, all 34 declarations with
their exact names/types/homes/owners, 593 PASS instructions and 18 exact branches**.
The whole normal object is identical except its precise scratch FILE pathname.
SLD remains 0 merges / 1,377 splits, with exactly the previous partition and no
new bad pairs. The 27 allocation/load/store groups are still source-recovery debt.

This is verified expression/scope restoration, not proof of original macro
spelling. Parent owns the candid carrier-comment update and actual-path build.

## Carrier and compiler facts

Both root trace receipts were independently hash-checked against the real
production CC1PLPSX compiler, their preprocessed inputs, all 11 trace files per
stage, and byte-identical untraced assembly outputs. The baseline starts with
one user pseudo84 = 160, appears in the global allocation list but not the final
assigned-register table, and reload emits all 21 materializations in t0.
The plain-literal form begins with 21 temporary constant pseudos; CSE reuses
quantities, including pseudo128 assigned to fp, leaving eight immediate loads
(six v0, one fp, one s5) and shortening the function.

**Qualification:** baseline pseudo84 also gains REG_EQUAL during CSE. Its lack
of REG_EQUAL is an initial-RTL distinction, not the complete explanation. GCC
reload1.c:616..696 explains constant-equivalent substitution for unallocated
pseudos; this supports the observed mechanism, not an original variable name.
The constant feeds native callee `ry`, not its separate `h` local.

The literal-removal experiment was repeated on the **genuinely restored full
scope source shape**: `tail_literal` remains 579 instructions, 494 detailed
diffs and five branch-target differences. It is retained only as a diagnostic.
The root's whole-operation statement-expression and fabricated inline-helper
experiments remain failed, unlanded probes; no macro/helper is invented here.

No independently supported replacement carrier name or complete original header
body has been recovered. The next useful direction remains actual header/macro
context or an evidence-directed allocation/use expression using existing native
locals, not an invented semantic rename, pin, or audit exemption. Only the
verified scope proposal is eligible in this round.

Artifacts: `proposal_receipt.json`, `tail_expression_inspection.json`,
`rtl_peer_review.json`, and both final isolated gate/debug stages. Earlier P912
and P913 receipts remain frozen. No production or normal-output writes.
