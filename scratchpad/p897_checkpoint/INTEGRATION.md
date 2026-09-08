# P897 publication integration

The local checkpoint was finalized before integration. The repository then
fast-forwarded from `acbe34775f4e5dfce7e93d2ec25d515c61416e66` to upstream
`7728c5ea6ca9cc21e8aff19b18292da04fcce03c`, preserving all local edits and
the three incoming speech-library commits. No rebase, reset, force push,
discarded source, or instruction rewrite was used.

The incoming nine-file diff has an eleven-TU include closure: nine SPCH C
units and base/USA Speech C++ units. Ten compile. The independent before,
after and actual-source review preserves all **182/182 oracle-known symbols**:
80 SPCH and 102 base Speech. The scaffold-only count is 180 because it omits
two TU-local helper copies in spchevnt; those are not two newly matched
functions. Root's ordinary-source gates reproduce the exact wider counts.

Only spchpick's ordinary object changes. Three LO16 immediates gain 12 while
six paired HI/LO relocations move from the interior DAT_80148448 symbol to
gSentenceChoice, whose chosen field is at +12. Complete symbols, BSS extent,
other code/data and relocation order are unchanged. The paired proof checks
retail raw words and signed-low carry boundary cases in verifier memory only.

After recompiling the complete compilable closure through the ordinary tools:

- 517 of 518 normal source objects remain literally identical to P897.
  The remaining object is exactly the qualified spchpick relocation change.
- All 831 local protected functions retain their verified source hashes and
  object code. The added closure gates preserve all 182 incoming matches.
- The **complete regenerated linked ELF and map are byte-identical** to the
  frozen premerge outputs. All previously verified native data/GP bindings
  therefore remain preserved; known layout debt is not declared repaired.
- Relink policy, vtable indexing and source-only matching policy checks pass.
- The protected user scratch file retains its exact SHA256 and is excluded.

Final linked ELF SHA256:
`52800553415581618c04766bca85e3d943de8343f60b78c62ff7c62af9e32ae0`.

## Existing issues explicitly preserved

USA speech.cpp already failed to compile at its char-pointer calls to
SPCH_ResolveData(VoxEventDat*) and SPCH_AddBank(VoxBank*). Before/after/actual
diagnostics agree after the exact source-root pathname substitution. It is
not counted as a successful regional build.

Base SubmitRequest__6Speechlll retains its existing branch-distance discrepancy,
ours -2 versus oracle +8, despite passing the normalized instruction comparison.
Its entire code is unchanged. No statement that all Speech branches or the
whole eleven-TU closure are clean is justified.

Incoming VoxSample/VoxChoice/VoxSentenceChoice layouts are integrated existing
upstream work, not new assertions that every type/field spelling was recovered
from native SYM. Their provenance remains subject to the main original-source
goal. This publication does not close the source/name/SLD/final-image backlog.

## Publication selection

User approval covers the verified checkpoint on origin/main. The selection is
111 modified production files, the tracked source-name backlog, eleven required
new production inputs (ten oracle data leaves and source_zero_owners.py), compact
historical/final receipts, and nine pre-edit tool backups. Compiled objects,
ELFs, maps, reports, unrelated scratch/backups, status-only changes and the
user's w85/o2.txt are excluded. The oracle leaves preserve existing raw data;
they are required build inputs, not discarded data or generated binaries.

Primary integration receipt: integration_receipts.json. The independent paired
review is in ../p897_upstream_spch. Compact published receipts are historical
evidence, not standalone runners without their local frozen fixtures.
