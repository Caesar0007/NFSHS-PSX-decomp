# SYM untyped-owner and source-organization truth receipt

Date: 2026-08-30

Pre-change tool backup: Git commit `5d3b3d51`.

## Corrected proof boundary

The previous type-graph board treated a retail object with only a decoded
`FILE` boundary and zero canonical type records as an empty type graph.  That
overstated what SYM proves.  The independent opcode-2 audit already establishes
the correct interpretation: an untyped public/library symbol has no `0x94/0x96`
definition and therefore does not contain enough information to infer its lost
C declaration.

`run_sym_type_graph_sweep.py` now reports such owners as `SYM_UNTYPED` and does
not compile or compare a synthetic empty graph.  This converts the former 266
empty-graph `OK` rows and all 30 debug-compile failures into an honest evidence
category; it is an audit correction, not a source or matching regression.

## Owner evidence

Canonical PsyQ 4.3 `C:\Temp\nfs4-clean\psyq43\extracted\INDEX.tsv` was joined
with the retail SYM FILE boundaries.  It proves the following non-stem and
duplicate-stem mappings:

- `libcard/PATCH.c` -> `libcard.lib(PATCH.obj)`;
- `libcd/cdcont.c` -> `libcd.lib(SYS.obj)`;
- `libcd/drv.c` -> `libcd.lib(BIOS.obj)`;
- `libcd/stcdint.c` -> `libcd.lib(C_011.obj)`;
- `libetc/VSYNC.c` -> `libetc.lib(VSYNC.obj)`;
- `libgpu/SYS.c` -> `libgpu.lib(SYS.obj)`;
- `libmcrd/BIOS.c` -> `libmcrd.lib(BIOS.obj)`.

The same index proves four source-organization findings that a stem join must
not conceal:

- retail `libcard.lib(INIT.obj)` contains `InitCARD`, `StartCARD`, and
  `StopCARD`, but reconstruction splits it across `INIT.c` and `CARDINIT.c`;
- `stream.c` merges `C_002.obj`, `C_005.obj`, and `CDROM.obj`;
- `streamhelp.c` merges `C_003.obj`, `C_004.obj`, `C_007.obj`, `C_008.obj`,
  `C_009.obj`, and `C_010.obj`.

`setfont.c` and `MCXMAIN.c` remain explicit `OWNER_MAP` findings because the
retail SYM retains no matching FILE/type owner and the canonical 4.3 index does
not independently establish them.  No guessed owner was installed.

## Full-board result

`sym_type_graph_board_p418_20260830.tsv` covers all 458 reconstructed TUs:

- 151 `OK`: retained retail type graph is exactly reproduced;
- 301 `SYM_UNTYPED`: retail omitted canonical type payload, so source types
  cannot be proven from SYM alone;
- 2 `SOURCE_SPLIT` rows;
- 2 `SOURCE_MERGE` rows;
- 2 `OWNER_MAP` rows;
- zero `DIFF` and zero `COMPILE_FAIL` rows.

The focused syslib board is
`syslib_type_graph_untyped_fix_p418_20260830.tsv`: 150 `SYM_UNTYPED`, two
`SOURCE_SPLIT`, two `SOURCE_MERGE`, and one `OWNER_MAP` across 155 units.

## Regression and repository integrity

No reconstructed source or generated object was changed by this round.

- both relink lanes are green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero across 15,782 call relocations;
- call-target audit: 0/460 proven wrong-target sites;
- TU-order audit: 513 objects, zero inversions;
- vtable-indexing audit: PASS across 1,011 files;
- post-compiler text-move audit: PASS;
- phantom audit: 513/513 TUs compile, 3,484/3,484 exact oracle names, zero
  hidden phantoms and zero ownership gaps;
- phantom census: zero `__Fe` bases.
