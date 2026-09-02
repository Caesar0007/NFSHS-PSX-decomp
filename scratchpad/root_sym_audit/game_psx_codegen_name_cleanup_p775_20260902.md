# Game/PSX codegen-carrier name cleanup — P775 (2026-09-02)

## Result

The strict `recon/game/psx` declaration audit remains fully clean while 41
source-only compiler carriers across ten translation units no longer use
decompiler-placeholder spellings such as `iVarN`, `pDVarN`, `sVarN`, or
`name_00`. The identifiers now state the source operation or value they carry,
without claiming that SYM declared them as retail locals.

The strict count remains 396 because this round renames necessary compiler
shaping carriers; it does not pretend that those carriers are genuine SYM
declarations. Every renamed carrier remains explicitly marked and auditable.

## Renamed carrier groups

- `device.cpp`: communication mode.
- `draw.cpp`: view indices/pointers, view count, and the mid-ground OTZ
  numerator.
- `cario.cpp`: licence-plate slot/shape and sound-effect vector components.
- `fe3dmenu.cpp`: trigonometric result and showroom-state flag.
- `weather.cpp`: first/second camera-matrix destinations.
- `font.cpp`: character-table base and loaded font shape.
- `hud.cpp`: car count, CD-player visibility/pad state, human-car pointers,
  and the position table.
- `hrzsku.cpp`: far coordinate and the two ring offsets.
- `drawc.cpp`: flare type, draw-mode/OT-entry pointers, and the six triangle
  midpoint vertex/UV pointers (`midVt01`, `midVt12`, `midVt20` and matching
  `midUv*`).
- `draww.cpp`: animation result, object-skip flag, and clipped result.

The broad identifier scan now finds no matching placeholder pattern in active
game/PSX declarations or expressions. Remaining hits are historical experiment
comments that explicitly identify discarded Ghidra/m2c spellings; they are
evidence, not live source identifiers. Semantic numbered names such as `pal2`,
`pal4`, and `pal8` are intentional palette values, not decompiler artifacts.

## SYM/SLD and matching evidence

- Strict audit (`game_psx_strict_p775_20260902.md`): 395/395 functions mapped;
  zero missing/extra locals, type findings, storage findings, missing/extra
  globals, global type findings, or source-only global/data-layout carriers.
- Whole-TU detailed gate: 228/228 functions PASS across the ten touched TUs
  (`10+25+11+3+25+15+62+22+20+35`).
- Branch-distance census: 228 functions checked, zero offset/count
  divergences.
- Both relink lanes are GREEN, with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols.
- Vtable indexing audit: PASS across 1,017 files.
- Source-only policy audit: no post-compiler text moves or branch retargets.
- `git diff --check`: clean apart from existing line-ending warnings.

`chunkvis.obj` remains separately proven metadata-only: its FILE interval has
401 type records and no function, SLD, label, storage, code, or data record, so
there is no missing source/data declaration to invent for this object.

This round does not claim whole-project source restoration. The remaining 396
game/PSX carriers are semantic and explicit, but each is still future evidence
work: restore/remove it only when SYM/SLD plus detailed oracle behavior justify
the change.
