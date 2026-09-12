# P911: native music scopes and accurate HUD storage comments

Verified local checkpoint, not committed or pushed. The authorized P898-P903
checkpoint is already published as `7aef1e7c`; this newer scope is separate.

- `AudioMus_DriverStartUp`: restores all seven native SYM scopes and all six
  parameter/local names, types and homes. SLD 12 merges / 18 splits becomes
  0 / 0. Only declaration placement, nested tests and implicit void exit change.
- HUD: corrects two obsolete scalar-split comment blocks and 24 mistaken BSS
  descriptions. Primary SYM, MAP and CPE support the new descriptions. All
  24,795 code tokens remain identical; original initializer spelling is not claimed.
- Actual-path verification: **85 PASS functions, 739 preserved branches**.
  Both normal objects, all 698 link inputs, the complete ELF and map remain
  literally unchanged. Music's 22 neighboring contracts and HUD's 62 complete
  lexical/SLD graphs are preserved. DriverStartUp's 81 linked words match raw ROM.
- Both scoped relink lanes, native-owner guards, vtable and source-policy checks
  pass. No new source names, asm, volatile, pins or compiler-output rewrites.

## Rejected placement proposal

HUD's remaining six-array, 1,226-byte BSS block has a verified native source
contract, 54 exact references and 121 passing owner controls. Placing it at its
native address nevertheless increases inherited overlap multiplicity from two
to three. **No BSS owner, fallback or generator change from that proposal landed.**
See [ranked prerequisites](../p911_hud_bss/PREREQUISITES.md) and the explicitly
failed `../p911_hud_bss/preservation.json`. Collide ownership is the smallest
next candidate; GenericPMX and Camera have additional declaration/initializer
work. Correcting those three alone does not clear all overlapping spill.

The existing 35 data owners, seven zero owners, 720 raw duplicates and 1,006
wrong GP targets remain unchanged. The project is not fully SYM/SLD-exact or
runtime-link-exact. The objdiff report was not regenerated in this byte-neutral
round; exact normal code inputs preserve its prior result.

## Receipts

- `driver_actual.json` and `actual_driver/candidate_inspection.json`
- `../p911_hud_comment_cleanup/verification_actual.json`
- `../p911_hud_comment_cleanup/peer_comment_review.json`
- `integration.json`, `integration_checks.json`, `relink.json`
- `final_receipts.json`, `publication_manifest.json`

Backups are local under `backups/`; generated objects/images and unrelated user
edits are excluded from the explicit publication manifest. No Git mutation was
performed. The main reconstruction goal remains active.
