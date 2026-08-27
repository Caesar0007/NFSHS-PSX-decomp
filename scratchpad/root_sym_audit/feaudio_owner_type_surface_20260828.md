# `Feaudio.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `Feaudio.obj`

Source TU: `recon/frontend/common/feaudio.cpp`

The retail graph is the shared exact frontend/color core with the unrelated
car-manager tail absent.  `feaudio_types.h` adds only the nine audio/VIV
records and the three retained indexed-track records visible in Feaudio.obj.
The existing ten function bodies are unchanged.

Strict compiler-emitted comparison:

- named records: 91/91 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/feaudio.cpp`
  runs: 10/10 PASS
- focused graph: `feaudio_type_graph_p265_20260828.tsv`
- full frontend/common sweep: 15 exact owners, 26 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit and repository-wide regression gates:
  green
