# EA library untyped-codegen carrier receipt

Date: 2026-08-28

Retail owners:

- `systask.obj`
- `sbhdrcpy.obj`
- `sdma.obj`
- `sdmemman.obj`
- `sdresolv.obj`
- `sfxlevel.obj`
- `slimits.obj`
- `smasterv.obj`
- `smath64.obj`

These linked EA library members retain no named, anonymous, or typedef type
records in the retail SYM.  Their retail instructions nevertheless prove the
aggregate-copy, by-value ABI, or foreign-storage member shapes used by the
reconstruction.  The former canonical comparison reported one source-only
named record per owner even though those records are necessary compiler
boundary evidence rather than claims about retained retail debug types.

The canonical audit now accepts only these exact owner-local shapes:

- `LimitsBlock`: 20 bytes, `int value[5]` at offset 0
- `SNDu64Value`: 8 bytes, unsigned words at offsets 0 and 4
- `SNDMasterState`: 152 bytes, channel count at 17 and play-record pointer at
  148, with every intervening byte priced
- `SNDfxBusView`: 164 bytes, master word at offset 160
- `SNDResolveEntry`: 8 bytes, offset/SPU words at offsets 0 and 4
- `PackedAllocSlot`: 1,316 bytes, word at offset 1,312
- `SNDDmaEntry`: 20 bytes, all eight retail-used fields and padding priced
- `SysTaskSlot`: 16 bytes, four consecutive words
- `SNDGlobals`: 156 bytes, initialization byte at 60 and bank-table word at
  152, with intervening storage priced

This is not a name-only allowlist.  Acceptance requires the exact source-file
basename, tag, total size, member list, leaf types, array bounds, and offsets.
Any drift remains a canonical type-graph failure.  The pre-change audit tool
is backed up by Git commit `0fc6b97a`.  No reconstructed source file, compiler
flag, object, or linked byte was changed in this round.

Focused/project results:

- the eaclib p302 sweep changes exactly the nine owners above from `DIFF` to
  `OK`; no eaclib owner regresses
- the full p303 sweep scans 458 owners and reports 340 `OK`, 77 `DIFF`, 30
  known debug-compile failures, and 11 unresolved owner mappings
- comparison against p300 shows exactly those same nine `DIFF` to `OK`
  transitions and no other status change

Matching re-gate:

- `slimits`: 2/2 PASS
- `smath64`: 2/2 PASS
- `smasterv`: 1/1 PASS
- `sfxlevel`: 2/2 PASS
- `sdresolv`: 2/2 PASS
- `sdmemman`: 2/3 PASS; only the pre-existing six-diff `iSNDpsxmalloc`
  residual remains
- `sdma`: 6/6 PASS
- `systask`: 3/3 PASS
- `sbhdrcpy`: 1/1 PASS

Evidence:

- `slimits_type_graph_p301_20260828.tsv`
- `eaclib_type_graph_p302_20260828.tsv`
- `project_type_graph_p303_20260828.tsv`

Repository integrity regression:

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols
- zero calls to undefined symbols in both lanes and zero proven wrong call
  targets across 460 audited units
- 513 objects with zero TU-order inversions
- no unsafe direct vtable-row indexing in 983 files
- no post-compiler text moves or branch retargets
- phantom ownership recheck: 513/513 TUs present, 3,484/3,484 exact retail
  names, zero hidden phantoms, and zero unmatched ownership gaps
