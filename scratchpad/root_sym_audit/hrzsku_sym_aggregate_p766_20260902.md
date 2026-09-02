# `hrzsku.obj` SYM aggregate restoration (P766, 2026-09-02)

## Retail evidence and source correction

Retail SYM owns two file-static 8-byte objects in `hrzsku.obj`:

- `sunPosInSky @ 0x8013DDF0`, type `SVECTOR`;
- `moonPosInSky @ 0x8013DDF8`, type `SVECTOR`.

The previous reconstruction split each object into four `short` globals to
make every field eligible for gp-relative addressing under `-G4`.  P766 removes
those eight invented source identifiers and restores the ordinary declarations:

```cpp
static SVECTOR sunPosInSky;
static SVECTOR moonPosInSky;
```

The rebuilt object symbol table emits local `sunPosInSky` at BSS offset `0x08`
and local `moonPosInSky` at offset `0x10`, each with the expected 8-byte extent.

## Compiler-identity proof

The source correction was tested first under the prior `-G4` lane:

- TU gate: 20/22 PASS;
- `Hrz_BuildSky__Fv`: 1 diff;
- `Hrz_InitSky__Fv`: 40 diffs.

The same honest aggregate source under TU-wide `-G8` gives:

- `python tools/tugate.py recon/game/psx/hrzsku.cpp`: 22/22 PASS;
- `python tools/brdist.py recon/game/psx/hrzsku.cpp`: 22 functions checked,
  zero branch-offset/count divergences.

This is a TU compiler-input identity, not a per-function splice or post-compile
rewrite.  The exact pre-change `tools/build.py` is retained as
`build.py.pre_hrzsku_g8_p765_backup` (SHA-256
`844059D755D3BFA283C573978E0812FE106F5C5B8BB34F734383CDA2CD143E92`).

## SYM and link regression proof

- strict `recon/game/psx` audit: 395/395 functions mapped; zero missing/extra
  locals, global definitions, type findings, or storage findings;
- both relink lanes GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved names;
- `configs/symbol_addrs.txt` now uses retail-exact `moonPosInSky` rather than
  the obsolete `moonPosInSky_vx` split-field alias;
- P766 raw compact coverage: opcode 6 exact-name+VA 148, VA-alias-only 37,
  absent-VA 187; the compact-only backlog remains zero.

This round does not close the larger SLD/type-graph/synthetic-identifier goal.
