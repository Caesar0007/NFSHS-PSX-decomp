# P905: Primate shared zero storage restored

Verified 2026-09-12, building on the local P904 checkpoint. Neither P904 nor
P905 has been committed or pushed; the last published checkpoint is `7aef1e7c`.

## Verified result

All ten remaining Primate zero-storage cells now occupy their native shared
40-byte NOBITS run at `8013DE68..8013DE90`, with four-byte alignment and public
source binding. Combined with P904's initialized five-cell run, **all 15
drawing-state storage cells** now have native source-owned addresses.

- **All 81 linked producer instruction words are raw-exact**: initlinkmode
  59, waitdraw 11, settrans 11. This includes all **25 GP reference words**.
- All **26 outside reference words** remain raw-exact: 13 HI16/LO16 pairs in
  movf, fastmovf and vramfxya. They now share the producer's source definitions.
- Wrong GP targets **1,417 -> 1,403**, another 14 repaired after P904's 11.
  All 2,381 GP references resolve, with zero overflow/encoding mismatch and
  three unchanged unknown targets. Four pre-existing native/raw diagnostic
  disagreements are unchanged, not hidden or newly introduced.
- All 961 previously correct GP rows, 3,780 native public bindings and 76
  exact-name native LOCAL records remain correct. The independent extended
  audit additionally checks 86 FILE-scoped native-correct LOCAL records.
- **248/248 EAC functions remain PASS**, with all 1,139 branch checks
  preserved. All 74 TUs were recompiled; 73 whole objects remain identical.
  700 of 702 prior linked inputs are unchanged. Only primate and the exact raw
  tail split differ; the new raw leaf is excluded only from reconstruction.
- Normal and debug compilations agree on instruction bytes and public data
  records. No debug labels or instructions are rewritten. The objdiff report
  remains byte-identical to P904. Both relink lanes and policy/vtable checks pass.

## Mechanism and rejected alternative

The ordinary C declarations already emit public `.comm` directives. The
existing assembler lowering retained public binding for large COMMON but
made small COMMON local. A new **opt-in binding-only option** extends that
public binding to the proven small owner. Only primate enables it. True
`.lcomm` declarations and all legacy defaults remain unchanged.

This produces strong, source-owned section definitions, **not generic COMMON
coalescing**. Unique ownership and final placement are verified; enabling the
option tree-wide without equivalent owner/consumer proof is not justified.
There is no source asm, volatile, storage attribute, register dial, fabricated
linker variable, postcompiled instruction patch or relocation rewrite.

The existing `--use-comm-section` route was tested first. GNU ld pools the
ten cells into `.scommon` in link-context-dependent hash order; its common-sort
options order alignment, which is identical for all ten cells. The compiler's
declaration order was already native. The accepted binding correction retains
that order during normal SBSS assembly and permits ordinary native placement.

## Remaining qualifications

`otbl2` and `primbuf2` are still **unproved original names**. Neither their
possible aggregate membership nor exact original C type/declaration tokens
are recovered. Address order and shared storage are proved; literal original
source declaration order is not claimed.

The whole linked image remains incomplete. Output overlap pairs are
**135 -> 139** because the old tail section is split around the native NOBITS
owner. No new overlapping address range or increased overlap multiplicity
is introduced. Existing physical layout conflicts remain real debt.

The next concrete repair is supported by `../p905_orphan_replay`: **29,540
bytes of duplicated raw Replay/FEI data**. Replay has complete eight-section
typed source coverage plus three CPE alignment bytes. FEI has a 912-byte
source table with 108 proved native pointer relocations. These exclusions
are **not landed** yet: preserve surrounding raw owners and add exact
payload/relocation guards before retiring the two copies.

## Receipts

- `final_receipts.json`: final actual hashes, native/code/binding preservation,
  explicit overlap and source-identity qualifications, publication state.
- `verification.json`, `checks.json`: actual 74-TU rebuild and branch/gate checks.
  The first failed debug parser attempt rejected a nonallocated DWARF section;
  the corrected harness uses the existing explicit P895 DWARF contract only.
- `relink_final.json`: 22 validated initialized/zero-owner raw exclusions,
  zero REAL duplicates, hidden phantoms and referenced unresolved names.
  The old 848 raw-blob duplicates are still explicitly counted.
- `raw_seam.json`: all raw bytes, labels and relocation dispositions preserved
  in both build and expected; no NOBITS file payload is fabricated.
- `owner_controls.json`: 11 invalid SBSS owner variants rejected in memory;
  48 default-output cases agree with the backed-up assembler implementation.
- `tools/maspsx/test_common_binding.py`: five regression tests cover public,
  private, actual COMMON, declaration-order and default behavior.
- `peer_review_final.json`, `peer_review.md`, `peer_review_followup.json`:
  independent source/tool/native review. Original receipts remain frozen;
  the follow-up covers the reporting-only exclusion-count correction.
- `../p905_common_contract/actual_native_verification.json`,
  `actual_preservation.json`, `actual_preservation_extended.json`: independently
  checked full linked raw words, exact paired HI/LO resolution, previous
  correct binding preservation and physical overlap geometry.

Protected tools/source/linker backups are under `backups/`. Unrelated user
edits are preserved. The full original-source/SYM/SLD goal remains active.
