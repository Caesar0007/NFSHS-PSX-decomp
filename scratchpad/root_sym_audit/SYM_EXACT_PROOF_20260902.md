# NFS4 PSX SYM-exact restoration proof — 2026-09-02

> **SUPERSEDED COVERAGE CLAIM (2026-09-02):** this document proves only the
> declaration subset implemented by `audit_sym_source.py`. A subsequent raw
> opcode census found semantic record classes that the audit does not yet
> consume: SLD transitions, lexical blocks, standalone type/member/enum
> definitions, compact function symbols, and some function/object ownership
> records. Do not use this document as proof that the complete raw SYM is
> source-accounted. See `RAW_SYM_COVERAGE_GAPS_20260902.md`.

## Claim and boundary

Every reliable retail SYM declaration record owned by the reconstructed source
tree has been reconciled with its C/C++ owner. The strict audit has no generic
review dispositions: no missing or extra locals, function types, storage
classes, global definitions, global types, or global storage classes remain.
Information not uniquely named by retail debug data is retained only with an
explicit evidence category (oracle/codegen carrier, measured layout carrier,
host-only fallback, linker-folded common, blob-backed object, or canonical SDK
ownership proof).

This proves only the declaration-subset consistency objective. It does not
prove exhaustive SYM/SLD source restoration, and it does not claim that the
separate binary-matching board is complete: `MATCH_PROGRESS.txt` currently has
3489/3493 functions at 100%, with four source/codegen matches still open.

## P764 raw compact-symbol closure

The later exhaustive raw-record ledger now closes the address-only data/static
gap that was outside this proof's original audit surface.  All 34 compact-only
records have an evidence-reviewed C/C++ source home in
`compact_source_homes.json`; the P764 ledger classifies 34 as
`source-restored` and leaves 0 as `compact-only`.

This is a source-ownership result, not a claim that every raw SYM spelling is
already emitted literally by the reconstructed toolchain.  Same-address
configuration aliases, the complete standalone type/member/enum graph, and
SLD line/block correspondence remain active semantic-validation queues.  See
`compact_only_source_closure_p764_20260902.md` and
`raw_sym_ledger_p764_20260902.md` for the exact boundary.

P766 additionally restores `hrzsku.obj`'s `sunPosInSky` and `moonPosInSky`
from eight split-field scalar carriers to two real `SVECTOR` objects.  A
documented TU-wide `-G8` identity keeps all 22 oracle-backed functions PASS;
the P766 raw ledger therefore records `moonPosInSky` as exact-name+VA rather
than a same-VA configuration alias.

P767 removes the forced short assembler label from frontend's file-static
`TransformVector`; ordinary C++ now emits the retail GCC-v2 mangled name while
the helper and its complete 59-function TU remain PASS.

P774 removes all unexplained game/psx global/data-layout carriers. The sky,
weather, night, and fog storage now uses real SYM aggregate declarations, and
ordinary `"back"`/`"cdrom:"` expressions reproduce the retail anonymous
small-data literals and exact surrounding offsets under proven object-wide
`-G8` identities. This is a directory-level global-storage result only: one
measured `StatsTimer[2]` compatibility carrier and 396 function-local codegen
carriers remain explicitly reviewed/open, while project-wide SLD/type-graph
restoration is still incomplete.

## Exhaustive audit scope

The strict audit was run independently on all 22 directories containing
reconstructed C/C++ source:

- `recon/eaclib/psx` and its `eacpsxz`, `sndpsxz`, and `spchpsxz` archives
- `recon/frontend/common` and `recon/frontend/psx`
- `recon/game/common` and `recon/game/psx`
- all 14 `recon/syslib/psx` source directories

Aggregate evidence:

- 2,459 SYM function records selected by source/object ownership
- 2,457 mapped source definitions, plus two correctly implicit aggregate
  special members (`tAllScreens` constructor/destructor)
- 0 missing SYM names
- 0 extra source-local names
- 0 function type or storage findings
- 0 functions needing mapping review
- 1,087 object-owned data records inspected
- 831 compact address-only records mapped by exact name and VA
- 1,119 mapped source global definitions
- 115/115 special SYM vtable records mapped
- 0 missing/extra global definitions in every directory
- 0 global type or storage findings

The per-directory receipts are
`scratchpad/root_sym_audit/recon_*_strict_p745_20260902.md`.

## Previously deferred/unlocked functions

- `InGame_GetPSXPadValue__Fii`: PASS, 233/233 instructions; its source-only
  `index` declaration is retained as an explicitly documented codegen carrier.
- `MenuExtended_EnterUserName__FR12tMenuCommand`: PASS, 25/25 instructions.
- `MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand`: PASS, 68/68
  instructions.
- The two frontend `m` locals are restored through the actual inline
  `tScreenUserName::SetCallingMenu(tOptionsMenu *m)` body. The audit now
  prefers the TU-local type header over the duplicate monolithic fallback.

## Tooling integrity

`audit_sym_source.py` now uses SLD source paths and FILE/archive ownership to
disambiguate same-basename objects, recognizes same-file suffix attribute
macros, and resolves inline locals from the header actually included by the
TU. Each behavior is explained next to the implementation.

The exact pre-change tool is preserved at
`scratchpad/root_sym_audit/audit_sym_source.py.pre_p744_backup`; its Git blob
hash is `17cd0685d024a6017c4a20b72f712a656945c5c6`, identical to the pre-change
HEAD blob.

## Independent regression proof

- All previously matched functions in the 25 touched TUs remain PASS.
- `psxcontroller.cpp`: 4/4 PASS; branch-distance audit 0 divergent.
- `femenudefs.cpp`: 66/66 PASS; branch-distance audit 0 divergent.
- Vtable indexing audit: PASS across 1,017 files.
- Both relink lanes: GREEN; 0 real duplicates, 0 hidden phantoms, and 0
  relocation-referenced unresolved symbols.
- `git diff --check`: clean.

## Non-SYM binary-matching backlog

The only four non-100% board entries are:

- `FntFlush` — 98.60%
- `_st_dma` — 99.01%
- `MemCardGetDirentry` — 92.39%
- `MemCardFormat` — 97.14%

These are code-generation matching tasks, not unresolved SYM declaration
records.
