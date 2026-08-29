# `bworld.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `7749e58c`.

## Source graph restoration

`bworld_types.h` now composes the exact 106-definition overlap with
`DrawW.obj`, while a narrow include guard omits DrawW's fourteen owner-only
records. It restores BWorld's two owner definitions, `Trk_SFX` and
`BW_tContextMgr`, and its owner-visible `CarLogic_tObservations` typedef.
The broad `nfs4_types.h` dependency is no longer part of this translation
unit or its public/extern declaration boundary.

Six completed foreign-owner tags are absent from BWorld's linked SYM graph
even though retail dereferences their storage: the road slice table, camera
array, game setup, track specification, flare cache, and extended draw cache.
Private compiler-boundary views preserve the exact consumed offsets and
aggregate MEM shapes. The canonical audit accepts each view only when its
owner header, private name, size, members, offsets, and implicit C++ typedef
pair match the recorded fingerprint. Exact `asm` symbol aliases on the two
Flare declarations preserve their original C++ link names; the four EA/libc
runtime declarations retain C linkage. No post-compiler rewrite is used.

## SYM and matching proof

Focused board `bworld_type_graph_p402_20260829.tsv`:

- named definitions: 108/108 exact;
- anonymous definitions: 2/2 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report 21/21 PASS
for `recon/game/common/bworld.cpp`, spanning 2 through 203 instructions per
function. The shared-header neighbor `draww.cpp` retains its exact 120/120
named plus 2/2 anonymous owner graph. Representative DrawW functions using
each guarded type region remain PASS in both lanes; its pre-existing
`Draw_kCtrlSkidmark` residual remains unchanged at 10 diffs.

Full board `sym_type_graph_board_p401_20260829.tsv` reports 408 `OK`, 9
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
BWorld moved from `DIFF` to `OK`; no owner regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 1,002 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- intended-compiler phantom census: 513/513 TUs available, 3,484/3,484 oracle
  names exact, zero hidden phantoms, and zero ownership gaps.
