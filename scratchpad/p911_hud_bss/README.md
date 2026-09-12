# P911 HUD BSS1226 — verified source contract, placement not ready

**Do not land this isolated proposal yet.** The source/native contract and
reference checks succeed, but the no-increased-overlap gate fails. Production
source, headers, tools, objects and normal linked outputs were not edited.

## Recovered native section

Native STAT425325..4253db describe six file-local arrays, already correctly
defined by the current C++ source and its active packet-type declarations:

| Name | Native address | Type and extent |
|---|---|---|
| gTPage0 | 8013E390 | DR_MODE[2][4],96 bytes |
| gTPage1 | 8013E3F0 | DR_MODE[2][4],96 bytes |
| gHudF4 | 8013E450 | POLY_F4[14],336 bytes |
| gHudFT4 | 8013E5A0 | POLY_FT4[10],400 bytes |
| gHudG4 | 8013E730 | POLY_G4[8],288 bytes |
| BTC_CurrentPerpName | 8013E850 | char[10],10 bytes |

They exactly fill1226 bytes ending8013E85A. Source `.bss` is NOBITS, flags3,
alignment1, with six LOCAL/default-visible symbols and no section relocations.
The private owner preserves that alignment, all offsets, names and types;
there is no invented padding or source-body/flag edit. No CPE load covers this
range; no initialized-ROM or NOBITS file payload is invented.

The private zero-owner row passes121 controls:15 positive cases accepted,
106 malformed cases rejected. All eight candidate owners validate; all seven
older row contracts and the complete validator-function AST remain unchanged.

## Oracle fallbacks are not storage

The native range has no raw asm storage donor. Eleven existing unconditional
assignments in undefined_syms_auto.txt instead emit four native STAT names as
GLOBAL ABS exports plus seven synthetic D labels. The full698-input census
finds no foreign reconstructed references requiring them. The private proposal
changes only those existing assignments to PROVIDE at their unchanged values,
allowing oracle references while avoiding unused recon exports.

This conditional edit is **not generation-stable yet**: explicit `make split`
would recreate unconditional assignments. See GENERATION_CAVEAT.md. A bounded
fail-closed metadata contract or post-split correction must be selected before
an eventual landing. No generator was changed or run in this proposal.

## Full private-link result and exact failed gate

Private ELF:
`743d86fdaf9fbfe6c37d82d859293c721095e14ffcb13d266415ed0389974230`.
Map:
`69c84c50650c228cf68b86f52569d4f72b0c9c339e1a6c6f90bcb44d7705737a`.

All698 original input objects are literally unchanged. The audit covers466
executable input sections/249505 words, including code placed in data outputs.
All1029 changed words are exact existing relocations:889 LO16 and140 R26.
Both their old and new symbol/addend/encoded values are checked; no non-relocation
instruction bits or branch displacements change. All3238 previously native
function full records,3870 other native public records and104 native
FILE-qualified LOCAL records are preserved. Four native STAT names' GLOBAL ABS
to LOCAL corrections are explicit, not hidden public-binding exceptions.

Every2381 GP reference keeps its prior target and status:1372 known correct,
1006 still wrong and3 unknown; zero overflow, unresolved, encoding mismatch or
native/raw conflict. Four pre-existing unanchored code inputs and the inert
SN-LNK transport shift backward1228 with the shrinking generic BSS catch-all;
they remain placement debt. Total allocated size falls by2 alignment bytes.

The native HUD interval8013E390..8013E85A already has multiplicity2 from:

- `.data` at8010CCD4, size219944; overlapping input sections are camera.data1404,
  collide.data64 and genericpmx.data1304.
- `.rodata_rest` at8013E300, size2538;23 input spans overlap this interval.

The new proper `.hud_bss` increases multiplicity **2 to3 across all1226 bytes**.
`preservation.json` therefore records `passed:false`, `landing_ready:false` and
the complete contributor/range lists. The original assertion-failing checker
is preserved as preservation_asserted_overlap.py. The reporting checker does
not waive the failure; it emits the successful subchecks alongside that failure.

Next bounded path: restore the misplaced initialized owners/readonly spill
placement with native evidence, then rerun this unchanged six-array proposal.
Do not repack arbitrary bytes, move spills without proof, or merge section
metadata to conceal the overlap.

## Receipts

- references_inventory/inventory.json: native records, header/type closure,
  six-array layout and54 actual source references (26 HI16/28 LO16).
- guard_controls/results.json:121/121, hash
  `b03e0cd20af3ed5e8560d78f71224e99783451314627ede73bd924b19ddda275`.
- preservation.json: qualified full-link failure, hash
  `f3a63583709b2d97628b7c429c2288dd59c97c9aa90d6ad85635b8319fb82603`.
- before_gp_audit.json and probe_gp_audit.json: exact unchanged GP results.
- link_probe.json: command, private outputs and unchanged normal-input hashes.

All earlier P910/private receipts remain untouched. The current proposal is
diagnostic evidence, not a published or accepted native-layout improvement.
