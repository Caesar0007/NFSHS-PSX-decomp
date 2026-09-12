# P909: native HUD data and playlist source scopes

Verified actual landing, 2026-09-12. Local/uncommitted; last published commit
remains7aef1e7c. The full original-source/SYM/SLD goal remains active.

## Result

- Corrected HUD's complete240-byte source-owned small-data placement, with
  28 native public cells and five genuine LOCAL statics. No C body, initializer,
  type, compiler option or address alias was needed for this repair.
- **SwitchSong is now62/62 actual linked words raw-exact.** Its two former
  Hud_kTurnSongOffNext LO16 errors now reach native8013D940. The prior source/
  scope/SLD fix is preserved.
- **153 incorrect GP bindings fixed:1277 ->1124.** Every1101 previously
  correct GP reference is preserved, with no overflow or encoding mismatch.
- Playlist uses the native scoped for-loop and implicit void exit:
  **SLD0/11 ->0/0**, four exact native scopes, original i/parameter homes,
  and all34 actual linked words raw-exact.
- **85/85 function gates and739 branch comparisons pass.** The normal HUD
  and Music objects remain literally unchanged. All22 Music neighbors retain
  complete debug/local/SLD contracts.
- **555/555 actual guard controls pass** and all250 HUD reference encodings
  are verified. An initial553/555 failure is retained; an opt-in exact flags
  check corrects the two missing high-bit flag checks without relaxing any row.

## Preservation and qualifications

Raw r20's36/240/380-byte pieces preserve all656 bytes and133 symbol records.
Only the middle becomes oracle-only; native pre/post addresses stay fixed.
The extra appended240-byte source copy is retired, reducing raw duplicates
757 ->729. The following misplaced source suffix naturally shifts240 bytes;
known-correct bindings are not sacrificed. No new compatibility alias exists.

All3845 previously native public records and86 established file-qualified
native LOCAL records are preserved. All533 changed linked code words are
existing relocations (118 LO16,415 GP); opcode/register bits and code geometry
are unchanged. All697 retained original inputs are literally identical; the
only changed old input is the verified raw donor split. The normal linked
ELF is byte-identical to the independently checked private result.

The complete image remains unfinished:1124 wrong GP targets, three unknown
expectations,729 raw duplicates and pre-existing section overlaps remain.
HUD's .sbss76/.data668/.bss1226 ownership is separate work. The corrected
140-byte/-fconserve-space comment does not claim exact original initializer
spelling. Playlist's observable native statement partition and scope are
recovered, not all surrounding original macro/header/whitespace tokens.

## Receipts

- `integration.json`: actual85 gates/739 branches, unchanged source objects,
  raw split identity, actual62+34-word equality and final image hashes.
- `playlist_actual.json`, `actual_playlist/implicit_return_inspection.json`:
  actual source-path native scope/SLD/parameter/local proof.
- `final_gp_audit.json`: all2381 current GP reference checks.
- `actual_scoped_local_preservation.json`: all86 prior qualified LOCAL records.
- `actual_guard_controls/results.json`:555 actual controls; the initial failed
  suite remains in `../p909_hud_owner/guard_controls/results.json`.
- `../p909_hud_owner/actual/README.md`, `actual_references/results.json`:
  independent actual250-reference/33-storage/240-byte verification and transfer
  of complete private preservation through identical linked ELF bytes.
- `final_transport.json`: raw comment clarification is object-byte neutral.
- `relink.json`: both scoped lanes GREEN, not a complete runnable-image link.
- `final_receipts.json`, `publication_manifest.json`: current exact hashes and
  an explicit cumulative file list; neither performs staging/publication.

ELF:60e7dc44e406330e5c613d9237449878b7b5ef45f6a5f0c4fa1fdcf6d5246619.
Map:a5207be90ea8794b7422811a216da14ed587f31f68fc91c1a7d09dd8496703f3.
Objdiff report remains2f64da5ebcadf1b920d8668e8a02ffed87abf40a1621fd45bfa97b3805ab19c3.

Protected-file backups are in `backups/`; failed/private probes remain frozen.
No new source asm, volatile, invented identifier or postcompile rewrite was
introduced. Unrelated user edits and untracked files remain untouched.
