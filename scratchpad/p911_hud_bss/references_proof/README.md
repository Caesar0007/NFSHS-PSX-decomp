# P911 private evidence — reference checks pass, landing blocked

**This private image is NOT approved for landing.** The parent's full layout
preservation audit found that placing HUD's1226 bytes at the native address
overlaps existing misplaced `.data` and `.rodata_rest`, increasing coverage
multiplicity from2 to3. The bounded checks below do not waive that problem.
No manual spill-repacking was introduced and no production change was made.
Automatic inherited catch-all shifts are documented in ../preservation.json.

## Exact bounded results

- All54 source HUD BSS relocations (26 HI16,28 LO16) resolve to native
  8013E390 plus their exact addends and reproduce full linked instruction words.
- All six LOCAL/default-visible arrays occupy native offsets and sizes.
- Input/output are NOBITS1226, flags3, alignment1. No NOBITS payload was read
  or hashed; native types/header layout are documented in the frozen inventory.
- All698 input objects are literally unchanged from the inventory baseline.
- All11 unreferenced GLOBAL ABS aliases disappear from the reconstructed
  private image: four native STAT spellings and seven D-address labels.
  No outside/current reconstruction reference requires these exports.

Private ELF:
`743d86fdaf9fbfe6c37d82d859293c721095e14ffcb13d266415ed0389974230`.
Private map:
`69c84c50650c228cf68b86f52569d4f72b0c9c339e1a6c6f90bcb44d7705737a`.
Every linked instruction read uses its explicit input-map/output section.

## Actual src/oracle PROVIDE test

The existing `expected/src/game/psx/hud.c.o` contains54 real relocations
covering all11 aliases. An isolated relocatable GNU link using the proposed
conditional PROVIDEs succeeded without warnings. Every alias resolves to
GLOBAL ABS at its native address, and no selected alias remains undefined.
The link uses native GP8013C54C and writes only `oracle_partial.o` here.

This proves conditional aliases remain available to the actual oracle object
when referenced; it does not claim a fully linked oracle program or excuse
the separate layout-overlap blocker. No synthetic oracle stub or altered
instruction object was used.

`results.json` deliberately records `reference_subset_passed:true` together
with `approved_for_landing:false`. It retains all54 source records,54 oracle
records, six LOCAL identities, linker command/result and full input hashes.
All watched inputs rehash unchanged. Only the authorized private partial-link
artifact and this new evidence namespace were written; no source/compiler
build, normal-output write or production/tool edit was performed.

Further work needs broader native-owner layout coordination. This bounded
investigation is complete and frozen.
