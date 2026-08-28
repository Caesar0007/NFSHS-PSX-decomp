# `pad.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `..\eaclib\psx\pad.obj`

Source TU: `recon/eaclib/psx/pad.c`

`pad_types.h` restores the exact source-visible PsyQ kernel/GTE/GPU and EA
shape/CD-stream declarations retained by PAD.C.  It also restores the retail
pad variant: `PAD_COMMON::data` is a six-byte anonymous union containing only
`PAD_PSX standard` and `PAD_ANALOG analog`.  The old reconstruction exposed a
source-invented named union and omitted the analog member and 18 retained
platform records.

The retail `.59fake`, `.62fake`, and `.63fake` spellings are not source names.
GCC 2.8.1 `sdbout.c` proves `gen_fake_label()` creates them from the
process-local `unnamed_struct_number` debug-emission counter through the MIPS
`SDB_GENERATE_FAKE` hook.  CC1PSX emits the reconstruction's identical three
anonymous layouts as `.0fake`, `.1fake`, and `.2fake` because the reconstructed
owner header deliberately omits unrelated declaration traffic.  The canonical
audit now classifies both `.Nfake` and CC1PL's `._N` spellings as anonymous and
compares every byte, member, offset, leaf tag, and use.  It does not suppress
or whitelist any layout difference.

Strict compiler-emitted comparison:

- named records: 20/20 exact
- anonymous records: 3/3 exact
- typedef records: 41/41 exact
- source-only named, anonymous, or typedef records: 0
- retail's second byte-identical TCB debug block is retained as duplicate-link
  evidence; one legal C definition covers its complete semantic body
- result: `OK`

Matching regression:

- `PAD_restore`: PASS, 21/21 instructions
- `PAD_convert`: PASS, 5/5 instructions
- `PAD_update`: PASS, 66/66 instructions
- `padinit`: unchanged pre-existing 3-diff epilogue residual, 27/28
- `PAD_state`: unchanged pre-existing 4-diff epilogue-order residual, 20/20

Project-wide graph regression: 458 owners scanned, 329 `OK`, 88 `DIFF`, 30
known debug-compile failures, and 11 unresolved owner mappings.  This improves
the immediately preceding census by exactly one owner (`pad.obj`: `DIFF` to
`OK`) with no owner regression.

Evidence:

- focused graph: `pad_type_graph_p295_20260828.tsv`
- project graph: `project_type_graph_p296_20260828.tsv`
- audit-tool pre-change backup: Git commit `dcb11301`

Repository integrity regression:

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols
- zero calls to undefined symbols in both lanes and zero proven wrong call
  targets
- 513 objects with zero TU-order inversions
- no unsafe direct vtable-row indexing in 981 files
- no post-compiler text moves or branch retargets
- full phantom rebuild: 513/513 TUs compiled, 3,484/3,484 exact retail names,
  zero hidden phantoms, and zero unmatched ownership gaps
