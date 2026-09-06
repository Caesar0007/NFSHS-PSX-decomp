# P874: FEMenuDefs callback source restoration (2026-09-06)

Scope: `recon/frontend/common/femenudefs.cpp` only. Prior P869-P873 scalar
declaration repairs remain intact. No header, tool, regional source, asm,
volatile, fence, or invented-identifier changes were introduced.

## Retained source improvements

| Function | Retail VA | Native source lines | Final gate |
| --- | --- | --- | --- |
| MenuExtended_GoToUpgrades | 8002c960 | 441-444 | PASS16, exact-g |
| MenuExtended_GoToShowroom | 8002d278 | 750-753 | PASS16, exact-g |
| MenuExtended_GoToDealerShowroom | 8002d2b8 | 757-760 | PASS16, exact-g |
| MenuExtended_TransitionFromPostGameToMainMenu | 8002c494 | 295-297 | PASS7, exact-g |

All four native function records name only command (REGPARM a0, PTR
tMenuCommand, size8); there are no caller locals. Removed four unrecorded
menuDefsBase declarations/exemptions and their separate assignment
statements. The three screen callbacks now consist of the original type,
nextMenu and SetState statements with ordinary scalar globals. The main-menu
callback now assigns nextMenu before type, matching native SLD296/297.

For all55 retained instructions, the debug twin's source-line tag minus
the native retail SLD tag is constant within each function (269,509,521,133
at the final check). This includes prologues, delay slots and epilogues;
it establishes the complete line partition, not just matching opcodes.
No artificial line directives were used.

## Reverted dialog probe

AskTheUserToSaveTheGame's native record retains YesNoDialog AUTO-176
(size168), answer REG s0, and an inline tDialogMessageString this in s0;
it has no caller dlgThis local. Replacing dlgThis with direct object
references while retaining SetString still gives FAIL6 at30/30:
the two word stores and one halfword store use sp-relative offsets instead
of the retail s0 receiver. The entire probe was restored. The existing
inline-receiver lifetime/source spelling remains an explicit recovery item,
not a compiler-floor claim.

## Final validation

- FEMenuDefs:66/66 PASS before and after, zero branch-offset/count divergences.
- Entire non-debug object SHA256 before = after:
  `E5F8A1F116F2E9AEECFBF0D2D96C5E4E6A6164CAEA5EF588AEC3690449580FD0`.
  This also preserves data bytes, symbol metadata and relocation identities.
- Native oracle raw-byte checks:85/85 words (55 retained +30 dialog),
  zero mismatches against `rom/nfs4-f.exe`.
- Source diff whitespace check passes.
- No commits or pushes performed by this bounded agent round.
