# `Stattool.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `Stattool.obj`

Source TU: `recon/frontend/common/stattool.cpp`

The retail graph proves Statchk.obj's complete 89-record graph is a strict
subset of Stattool.  `stattool_types.h` reuses that exact owner surface and
adds only Stattool's eight remaining records: the four retained PsyQ/kernel
records, `Sched_tSchedule`, the indexed list iterator, track information, and
track manager.

Stattool observes only `GameSetup_gData.numPlayerRaceCars` and
`numOpponentRaceCars` at offsets 0x3c8/0x3cc.  Its SYM omits the foreign
2600-byte `GameSetup_tData` body, so the extern boundary exposes those exact
word indices without inventing a source record.  The replacement is
instruction-neutral and all retail functions remain byte-identical.

Strict compiler-emitted comparison:

- named records: 97/97 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/stattool.cpp`
  runs: 11/11 PASS
- focused graph: `stattool_type_graph_p263_20260828.tsv`
- full frontend/common sweep: 13 exact owners, 28 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing/extra/type/storage findings
- both relink lanes and all undefcall, TU-order, vtable, text-move, phantom,
  and call-target gates: green
