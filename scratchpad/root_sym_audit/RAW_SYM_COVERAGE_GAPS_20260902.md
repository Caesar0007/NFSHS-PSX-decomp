# Raw SYM coverage gaps — 2026-09-02

## Finding

The earlier strict reports are declaration-consistency reports, not exhaustive
raw-SYM reports. The trusted `nfs4-f-v3.txt` contains 340,483 decoded records.
Several semantic record classes are not consumed or proven against source by
`audit_sym_source.py`.

## Raw opcode census

| Opcode | Meaning | Records | Current status |
|---|---|---:|---|
| `1` | linker/section boundary symbol | 127 | audited; 127/127 have exact non-allocating project declarations |
| `2` | public compact symbol | 4,503 | partially audited as address/name data; function coverage incomplete |
| `6` | static compact symbol | 372 | partially audited as address/name data; function coverage incomplete |
| `80` | increment SLD line | 19,891 | not audited |
| `82` | increment SLD line/address | 51,916 | not audited |
| `84` | large SLD line increment | 56 | not audited |
| `86` | set SLD line | 7,276 | not audited |
| `88` | start/set SLD file and line | 215 | not audited |
| `8a` | end SLD stream | 215 | not audited |
| `8c` | function start | 2,581 | 2,459 source-owned records accounted; 122 require ownership/mapping review |
| `8e` | function end | 2,581 | paired only for the selected declaration subset |
| `90` | lexical block start | 11,206 | not structurally audited |
| `92` | lexical block end | 11,206 | not structurally audited |
| `94` | `Def` debug declaration/type | 140,022 | locals/globals partially audited; standalone type graph not audited |
| `96` | `Def2` debug declaration/type | 88,316 | locals/globals partially audited; standalone type graph not audited |

SLD records total 79,569. Lexical-block records total 22,412.

## Uncovered debug-definition graph

The `94`/`96` corpus includes:

- 125,966 structure/union members (`MOS`/`MOU`)
- 40,875 typedef records (`TPDEF`)
- 14,561 aggregate end records (`EOS`)
- 13,041 structure tags (`STRTAG`)
- 11,454 enum members (`MOE`)
- 2,218 bit-fields/fields (`FIELD`)
- 1,348 enum tags (`ENTAG`)
- 172 union tags (`UNTAG`)
- 1,038 FILE ownership records
- 5 LABEL records

The existing audit parses `Def`/`Def2`, but principally consumes declaration
classes associated with selected functions and globals. It does not yet prove
that this standalone type/member/enum graph matches the reconstructed headers.

## Corrected project status

- Declaration subset consistency: proven for the 22 source directories under
  the existing rules.
- Exhaustive raw-record accounting: not proven.
- SLD validity: not proven.
- Synthetic/decompiler-name removal: not complete; 1,653 current source-only
  codegen-carrier entries remain to review.
- Full original-source restoration: active goal, not complete.

## P750 compact/linker cross-check

The exhaustive ledger now cross-checks opcodes `1`, `2`, and `6` against
`configs/symbol_addrs.txt`, `linkers/retail_data_symbols.ld`, the complete
`8c/8e` function set, and typed `EXT`/`STAT` declarations.  This found a
second real omission in the earlier proof:

- The executable function surface is 3,488 named VAs in the map/config, not
  merely the 2,581 debug-function spans.  It consists of 2,581 debug
  functions, 800 stripped functions represented only by compact SYM
  symbols, and 107 map-only vendor/internal functions with no SYM record.
- All 4,503 public compact symbols have a config symbol at the same VA, but
  266 use an alias spelling and still require exact-name classification.
- Of 372 static compact symbols, 187 have no config symbol at their VA.  153
  are recoverable through an exact typed `STAT`/`EXT` debug declaration; 34
  are compact-only statics with no `Def`/`Def2` declaration at all.
- Those 34 records include genuine function-local statics (`lastX.64`,
  `tick32.32`, `Copspeak_gTimeString.308`, `flareextra.248`), stripped EAC
  storage (`request`, `freequeue`, `SQVclue`, `bigfilename`,
  `systemtasksubs`), and the second static `locaterequest` function.  They
  were invisible to a declaration-only audit and are now an explicit source
  reconciliation queue.
- Of 127 linker/section records, 14 have an exact name+VA config entry. P756
  added the remaining 113 exact names as non-allocating `PROVIDE` declarations
  in `linkers/retail_data_symbols.ld`, including every main/front section
  `_obj`/`_org`/`_size` family. The combined config/linker surface is now
  127/127 exact and both relink lanes remain green.

Authoritative generated evidence:
`raw_sym_ledger_p750_20260902.md` and
`raw_sym_ledger_p750_20260902.json`.

## Required closure work

1. Parse every opcode into a typed record model and report consumed/unconsumed
   counts with stable record IDs.
2. Reconstruct SLD streams per source file/function and compare statement order,
   declaration regions, inline-header transitions, and exact lexical ownership.
3. Build the complete tag/typedef/member/enum graph and compare it against the
   owning reconstructed headers, including offsets, sizes, array dimensions,
   bit widths, and aggregate termination.
4. Map all compact public/static symbols as function, data, vtable, section, or
   explicit linker/compiler artifact.
5. Resolve the 122 currently unselected function-start blocks. The first
   ownership census proves all 122 are header-emitted functions (`AIHIGH.H`,
   `AISTATE.H`, `SPEECH.H`, `FEDIALOG.H`, `FEMENU*.H`, screen headers, and
   related files). The old directory audit selected only `.c`/`.cpp`
   basenames, so inline/out-of-line header bodies and implicit header special
   members were silently outside its function coverage.
6. Replace the generic codegen-carrier exemption with a strict evidence queue;
   no synthetic identifier is clean merely because it has a marker.
7. Re-run function matching, branch checks, vtable audit, and both relink lanes
   after every source correction.

## P757 `chunkvis.obj` source-home correction

The raw FILE pair at records `0x206049..0x2086D7` proves a genuine
`chunkvis.obj` owner with 401 interior records. All 401 are type-environment
records: 41 struct tags, one union tag, 204 members, four union members, 13
bit-fields, 42 aggregate terminators, and 96 typedefs. There are zero
functions, SLD spans, labels, and `EXT`/`STAT` storage definitions.

The reconstructed empty `recon/game/common/chunkvis.cpp` is therefore the
correct object-level source home. Its former comment was not correct: no
`Chunkvis` symbol exists at `0x8008B934`; that word is the return delay-slot
`nop` inside the preceding 2-instruction `Chunk_DeInit__Fv`, which remains
detailed PASS. The rebuilt `chunkvis.cpp.o` has empty `.text`, `.data`, and
`.bss`. Exact original include spelling/order remains underdetermined and is
kept in the standalone type-graph provenance queue rather than being invented.

Detailed evidence: `chunkvis_obj_source_home_p757_20260902.md`.

## P759 duplicate static-name restoration

The compact-only static `locaterequest @ 0x800FC4E4` now has its exact source
identifier in `stream.c`; `func_800FC4E4` has been removed from reconstructed
source. It validly coexists with the unrelated file-static `locaterequest @
0x800F0BF4` in `nasync.c`. A TU+VA-aware verifier route removes the former
oracle-filename constraint without altering emitted code. Both functions and
the stream caller are detailed PASS, the full stream TU is 32/32 PASS, and
both relink lanes are GREEN. This reduces the 34 compact-only source-home queue
to 33 records, with the remaining compact-storage rows still requiring the
same exact source-home reconciliation rather than name-only counting.

## P764 compact-only source closure

P759's 33-row statement is superseded by an evidence manifest and a corrected
ledger classification.  `compact_source_homes.json` now carries reviewed
source owner, source identifier, scope/type, and evidence for every one of the
34 compact-only rows (including the P759 function).  The P764 ledger reports:

- typed exact: 153;
- source restored: 34;
- compact-only backlog: 0.

The final substantive fixes are ordinary C `systemtasksubs[16]`, exact typed
and ordered coalesced `SQV*` commons, source-local `dummy` identifiers without
forced assembler names, `locatbig.obj`'s dead `bigfilename[64]`, and
`CopSpeak_Debug`'s local `Copspeak_gTimeString[16]`.  PASS and relink receipts
are in `compact_only_source_closure_p764_20260902.md`.  Other opcode families,
SLD statement/scope comparison, type-graph provenance, and the project-wide
synthetic-identifier queue remain active; zero compact-only backlog does not
close the larger restoration goal.

## P766 exact `moonPosInSky` source restoration

`hrzsku.cpp` now declares the retail file-static `SVECTOR sunPosInSky` and
`SVECTOR moonPosInSky` objects directly; the former eight split-field scalar
carriers are gone.  TU-wide `-G8` reproduces the original small-data accesses
and preserves 22/22 detailed PASS with zero branch divergence.  The symbol
configuration now carries the exact compact STATIC spelling `moonPosInSky`, so
the P766 ledger changes opcode-6 coverage from 147 exact / 38 alias-only to
148 exact / 37 alias-only.  This closes one semantic alias without treating
same-address linker boundaries or mechanical GCC/map spellings as source gaps.

## P767 exact static C++ symbol restoration

The forced `asm("TransformVector")` linkage name has been removed from
`screencarselect.cpp`.  Ordinary GCC-v2 mangling now emits retail's compact
STATIC name `TransformVector__FRA4_iRA4_A4_iT0`; the symbol configuration uses
that exact name as well.  A diagnostic-only oracle filename route preserves
access to the historical `TransformVector.s` receipt.  Detailed and whole-TU
gates remain PASS (57 instructions; 59/59 TU), branch divergence is zero, and
both relink lanes are GREEN.  The P767 opcode-6 counts are 149 exact / 36
alias-only / 187 absent by config VA.

## P774 game/PSX global-storage closure

The strict game/psx explicit source-only global/data-layout carrier count has
fallen to zero. Split-field/per-element models for the sky, weather, night,
and fog arrays have been replaced by their real SYM aggregate declarations;
ordinary source literals replace the address-named `"back"` and `"cdrom:"`
arrays while retaining exact retail `.sdata` order under proven TU-wide `-G8`
identities. Targeted gates and both relink lanes remain clean.

`StatsTimer[2]` is the one remaining measured global array carrier in this
directory: direct honest-array probes regress PASS functions, so its two-cell
codegen representation remains evidence-backed and semantically named rather
than hidden. The 396 game/psx function-local carrier entries and the wider
SLD/type-graph queues remain active. See
`game_psx_global_storage_cleanup_p774_20260902.md`.
