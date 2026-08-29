# Shared AI hierarchy owner-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `09c68004`.

## Source graph restoration

The ten AI hierarchy objects share an exact 108-definition semantic
intersection: the proven 71-definition `color_types.h` graph plus 37 common AI
definitions.  `aih_hierarchy_types.h` now restores that intersection once,
including the seven anonymous definitions common to the smaller owners.  Each
object header adds only the definitions retained by its own retail SYM graph:

- `aih_basiccop_types.h`: 28 named definitions and three Speech bank
  aggregates;
- `aih_hum_types.h`: `AIHigh_Human`;
- `aih_opp_types.h`: `AIState_Chase` and `AIHigh_Opponent`;
- `aih_traf_types.h`: `AIHigh_Cop`, `AIHigh_Traffic`, and `AIState_Idle`.

This replaces the monolithic `nfs4_types.h` include boundary for the four
owners.  The reconstruction therefore emits each owner's retained type graph
without importing hundreds of unrelated application definitions.

Several referenced globals and constructed classes have canonical layouts or
method surfaces but no completed tag in the consuming owner's linked debug
graph.  The canonical audit pair-locks only those exact foreign definitions by
owner, name, size, members, offsets, bounds, and leaf tags.  Macro-bound private
views are used only where the retail owner does not retain the foreign source
tag; canonical names are kept wherever call mangling depends on them.  Any
layout or semantic drift remains a visible focused-board DIFF.

## Focused SYM proof

The stable focused reports are:

- `aih_basiccop_type_graph_p366_20260829.tsv`: 136/136 named, 10/10
  anonymous, zero extra semantics, `OK`;
- `aih_hum_type_graph_p367_20260829.tsv`: 109/109 named, 7/7 anonymous,
  zero extra semantics, `OK`;
- `aih_opp_type_graph_p368_20260829.tsv`: 110/110 named, 7/7 anonymous,
  zero extra semantics, `OK`;
- `aih_traf_type_graph_p369_20260829.tsv`: 111/111 named, 7/7 anonymous,
  zero extra semantics, `OK`.

Retail duplicate tag and typedef multiplicities remain recorded as linked
debug evidence; they do not justify illegal duplicate C++ definitions.

Both normal and explicit `NFS4_SOURCE_ONLY=1` gates report:

- `aih_basiccop.cpp`: 9/9 PASS;
- `aih_hum.cpp`: 3/3 PASS;
- `aih_opp.cpp`: 6/6 PASS;
- `aih_traf.cpp`: 6/6 PASS.

Full board `sym_type_graph_board_p370_20260829.tsv` reports 395 `OK`, 22
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p365, exactly these four owners moved from `DIFF` to `OK`; no
owner regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 989 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
