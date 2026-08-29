# `PSXFront.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `b4871d68`.

## Source graph restoration

`psxfront_types.h` now composes the exact 95-definition overlap with
`Fetools.obj` while omitting Fetools' four owner-only menu classes and
Fecntl's `Input_tDeviceCall` typedef. It restores PSXFront's twelve completed
owner definitions: `CdlLOC`, `charactertbl`, `DR_OFFSET`, `eacelement`,
`POLY_F4`, `POLY_FT4`, `POLY_G4`, `POLY_GT4`, `SNDSAMPLEFORMAT`, `SNDSYSCAP`,
`SNDSYSSET`, and `SNDSYSVEC`, together with the owner-visible `CdlCB`,
`FONTFILECHAR`, `EACELEMENT`, and `qfunc` typedefs. The fixed render cursors
remain address-bearing lvalue macros and do not claim storage.

The completed foreign-owner tags for `GameSetup_gData`, `gCView`, and
`gEnviro` are absent from the linked `PSXFront.obj` graph even though the
owner dereferences them. Exact private compiler-boundary views retain their
complete known retail extents and original field offsets. The canonical audit
accepts each view only when its owner header, private name, size, members,
fields, offsets, and implicit C++ typedef pair match the recorded fingerprint.
PSXFront's local four-byte packet-link tag is independently pair-locked as the
canonical PsyQ addPrim address/length macro carrier.

The broad `nfs4_types.h` and `libfns.h` dependencies were replaced with the
exact owner surface and the precise runtime declaration subset used by this
translation unit. Original return types, C linkage, and old-style varargs
boundaries are retained. No executable statement was added, removed, or
rewritten.

## SYM and matching proof

Focused board `psxfront_type_graph_p393_20260829.tsv`:

- named definitions: 107/107 exact;
- anonymous definitions: 2/2 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report 25/25 PASS
for `recon/frontend/psx/psxfront.cpp`, spanning 8 through 245 instructions per
function. This includes `AdjustShapeDrawing` (203), `DrawGouraudShape` (245),
`ScaleGouraudShape` (175), and `FontUpsideDownBlit` (82). The shared-header
neighbor `fetools.cpp` remains 6/6 PASS in both lanes and retains its exact
99/99 named plus 2/2 anonymous owner graph.

The full board also exposed a correct four-byte `Hrz_PTag` added by the recent
matched sky/horizon work after the preceding board snapshot. Its exact
anonymous body and typedef are now pair-locked at `hrzsku.cpp`; focused board
`hrzsku_type_graph_p394_20260829.tsv` reports 75/75 named and 2/2 anonymous
definitions with zero extras.

Full board `sym_type_graph_board_p394_20260829.tsv` reports 407 `OK`, 10
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
PSXFront moved from `DIFF` to `OK`; Hrz's newly visible canonical macro
carrier is also classified exact. No owner regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 1,001 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- intended-compiler phantom census: 513/513 TUs available, 3,484/3,484 oracle
  names exact, zero hidden phantoms, and zero ownership gaps.
