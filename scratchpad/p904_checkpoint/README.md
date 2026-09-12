# P904: initialized drawing state and native callback storage

Verified 2026-09-12 on main after published checkpoint `7aef1e7c`.
This is a new, locally verified checkpoint. The P898-P903 publication approval
was consumed for that earlier commit and is not reused here.

## Result

- `primate.c` owns the exact five-word initialized run at
  `8013DD04..8013DD18`: otbuf, primbuf, linkmodeflag, drawpending, semitrans.
  Initial values are **0, 0, 0, 0, 1**, independently established by CPE/MAP/raw
  data. These replace the private zero-filled copies and their raw duplicates.
- The existing callback `mutexbuf` source reservation is placed at
  `801477E0..80147860`: 128-byte NOBITS storage, alignment 4. No callback
  source change or replacement padding is introduced.
- **11 actual linked GP targets repaired**; total wrong GP targets
  **1,428 -> 1,417**. All 2,381 GP relocations resolve without overflow or
  encoding disagreement. Three expected targets remain unknown.
- Callback's **25 linked instruction words** now exactly match retail;
  two incorrect LO16 words are repaired. All 26 outside drawing-reference
  words remain byte-exact. All three primate function bodies are unchanged.
- **248/248 EAC functions remain PASS**, with all 1,139 branch checks
  preserved. All 74 TUs were recompiled; 73 whole objects are unchanged.
  Of the 702 old linked inputs, 700 are unchanged; only primate and the raw
  r22 split differ. The new 20-byte raw leaf is retained only by the src lane.
- All 950 previously correct GP rows, 3,779 previously correct native public
  bindings and 76 exact-name native LOCAL symbol instances are preserved.
  Compiler UID names were not guessed or merged to manufacture coverage.
- Both relink lanes, unsafe-vtable indexing and source-only policy checks pass.
  The objdiff report is byte-identical to the preceding report. No change to
  build.py, gen_ld.py, the compiler, maspsx or instruction-rewrite settings.

## Boundaries and remaining work

The ten tentative primate zero-storage cells still become LOCAL .sbss under
the existing assembler pipeline; 14 producer GP accesses remain wrong.
Outside movf/fastmovf consumers still use the native raw copies. Their prior
relative declaration order is preserved. `otbl2` and `primbuf2` remain explicit
unproved carriers; their original names and possible aggregate membership
are not recovered. The compact records also do not establish exact original
char-pointer/int or callback short-array type spellings.

The complete linked image is **not** native-layout exact. Allocated output
section overlap pairs are **133 -> 135**. The new callback reservation overlaps
two already misplaced PROGBITS ranges, `.data_rest` and
`.data.r13_replay_legacy`, by 128 bytes each, not catch-all BSS. Both ranges
already covered that native address before this repair. The inherited
`.data`/`.sdata` overlap remains. These are actual unresolved physical layout
conflicts, not metric exemptions. Catch-all SBSS shrinks 20 bytes and BSS
shrinks 128; no invented filler hides the removed wrong storage.

Private, rejected full-SBSS paths are retained under `../p904_primate_owner`:

| Probe | Code result | Storage result / disposition |
|---|---|---|
| `section(".sbss")` | 3/3 PASS | Compiler emits PROGBITS, contrary to native zero reservation; rejected. |
| `section(".bss")` | initlinkmode 42 diff lines, 73 vs 59 instructions | Correct NOBITS but wrong address-generation shape; rejected. |
| `nocommon` attribute | 3/3 PASS | All 60 bytes become initialized .sdata; rejected. |
| Existing assembler `--use-comm-section` | 3/3 PASS | GLOBAL COMMON retained, but native allocation/order/link contract is unproved; production option unchanged. |

No new generic asm, volatile, carrier names or postcompile rewrite is landed.
Section names/numbering in generated linker metadata are not original C names.

## Evidence and reproducibility

- `verification.json` / `checks.json`: actual 74-TU rebuild, preserved gates,
  branch results, input objects, link diagnostics and policy checks.
- `final_receipts.json`: final actual hashes, header-comment consumer rebuild,
  exact-name LOCAL preservation, outstanding scope and publication state.
- `raw_seam.py` / `raw_seam.json`: source-oracle split preserves every byte,
  label and relocation destination; build and expected raw objects agree.
- `owner_controls.py` / `owner_controls.json`: seven malformed initialized
  owner variants rejected in memory; no object is rewritten.
- `../p904_callback_owner/README.md`, `actual_verification.json`,
  `actual_gp_audit.json`, `negative_controls.json`: actual callback/global/GP
  proof and 23 zero-owner controls (two accepted, 21 rejected).
- `../p904_primate_native/landed_disposition.md`, `native_facts.json`,
  `landed_split.json`, `overlap_audit.json`: primary records, raw references,
  source owner and exhaustive overlap qualification.
- `../p904_primate_native/final_source_review.json` predates the comment-only
  correction in primate.h. `final_receipts.json` supersedes that header hash;
  both actual include consumers recompile to identical objects.

Protected-tool and source/linker backups are under `backups/`. No source
orphan/overlap debt is erased from the backlog. User edits, including
`scratchpad/w85/o2.txt`, are preserved. The main source/SYM/SLD goal remains
active and incomplete.

`verify.py` is the one-shot baseline-to-candidate rebuild: its first assertion
intentionally rejects an already-modified normal baseline. Do not overwrite
or rerun its frozen stage. `finalize.py` and the read-only receipt validators
can recheck the accepted current state without reconstructing that baseline.
