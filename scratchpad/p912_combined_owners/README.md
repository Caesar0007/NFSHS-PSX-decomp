# P912 combined Collide, Camera and GenericPMX source owners

This is a private proposal; no production or normal build output was changed.
The three strict rows are appended to the existing 35 data-owner rows, so all
previous `source_data_N` output identities remain stable. Validator predicates
are unchanged; existing flags/visibility/symbol/payload/relocation checks apply.

| Owner | Native range | Source recovery |
|---|---|---|
| Collide registry | 80110C30..80110C70, 64 bytes | Existing typed pointer array; correct placement and remove duplicate raw r07. |
| Camera | 8010F2AC..8010F828, 1,404 bytes | Correctly braced native coordinate/bitfield initializers restore 102 bytes; explicit existing Camera_gInfo zero initialization restores data order. |
| GenericPMX | 80112B2C..80113044, 1,304 bytes | Native order of seven named arrays, not a payload-only match of zeros. |

The source declarations retain all original known names and types. Original
initializer/macro token spellings are not asserted. GenericPMX's unresolved
`pmx_height` and its documented SLD grouping debt remain explicit. Only the
verified `.data` sections are claimed native; other Camera BSS/external
references are not automatically repaired by these owners.

## Private checks

- Collide: 14 PASS / 716 branch checks, identical actual-path object.
- Camera: 38 PASS / 382 branch checks; all existing local/scope/SLD graphs
  unchanged. Seven compiler `.text` LO16 addends change with the corrected
  data order; all 204 own data references preserve native cell/interior meaning.
- GenericPMX: 1 PASS / 18 branch checks; code and data payloads unchanged,
  only proven native array symbol offsets/order and dependent relocation
  symbol records change. Local/scope/SLD graphs remain unchanged.
- Owner controls: Collide 100, Camera 1,609 and GenericPMX 1,452 — all pass.
  Every Camera/GenericPMX data byte is mutation-tested. Crucially, the old
  GenericPMX object is rejected despite identical zero bytes: its named
  array offsets are wrong. All 38 candidate owners validate together.
- Standing src/recon relink checks pass in private outputs. Src retains raw
  r06/r07/r09. Recon excludes only those exact validated leaves; no aliases,
  new storage, padding, compiler flags or instruction rewriting are introduced.

## Complete image preservation

Final private ELF:
`3eb55d8ad28e83da3192acaa15946cea1b09e20a15062d13b1189dee2dee2e95`.
Map:
`2df3c52ac22d3d25c87fa226e2e41d258815e79c4030cb2604dd4ebc6d7b4f17`.

All 698 original objects remain unchanged on disk. The private response file
contains 693 unchanged normal inputs and two exact candidate objects; three
raw duplicates are omitted. The two private source FILE strings are mapped
explicitly, never broadly ignored. Relocation symbol-table index changes,
including `.rel.pdr`, are compared as complete semantic target records, with
only the verified `.data` symbol offsets projected to their native order.

All 466 executable input sections / 249,505 words are audited. Exactly 1,356
linked words change at existing relocations: 1,193 LO16 and 163 HI16. Both
old/new encodings are recomputed from actual symbols/addends; non-relocation
instruction bits are identical. No code input, including the unanchored spill
inputs, moves. All 3,874 previously native public records, 104 FILE-qualified
LOCAL records and 3,238 native function records are preserved.

All 2,381 GP targets and statuses remain unchanged: 1,372 correct, 1,006 wrong,
3 unknown; zero overflow, unresolved, encoding mismatch or native/raw conflict.
Allocated size falls by 2,772 bytes. There is no new overlap area or multiplicity.
Following unanchored legacy data sections move backward by 2,772 bytes; their
exact changes are recorded. Existing broad overlap/layout debt remains, and
this does not unblock the rejected HUD BSS proposal by itself.

## Handoff and frozen stages

`apply_manifest.json` pins the five metadata/raw-comment files and the two
root-owned source proposals. `proposed_metadata.patch` contains metadata and
raw comments only. Root also plans its separately verified one-line Collide
comment clarification. No generator code or shared header edit is necessary;
the persistent fragment and strict registry drive regeneration and exclusion.

The Collide-only and two-owner private stages remain frozen. `two_proposal`
preserves the 37-row helper used by the Camera controls before GenericPMX was
added. All controls and failed diagnostic comparisons remain distinguishable;
there are no geometry or metadata exemptions.
