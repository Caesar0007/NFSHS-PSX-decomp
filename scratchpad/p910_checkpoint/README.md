# P910: native HUD data/zero storage and BuildPattern source recovery

Verified actual landing, 2026-09-12. P904-P910 remain local and unpushed;
the last published commit is7aef1e7c. The full source/SYM/SLD goal is active.

## Results

- HUD.data668 is native at80120924: nine GLOBAL and two LOCAL arrays,
  source/ROM/CPE exact, including six alignment bytes.
- HUD.sbss76 is native at8013DE00:14 original LOCAL identities, genuine
  NOBITS with input/output alignment8. No initialized payload is fabricated.
- **118 GP binding errors fixed:1124 ->1006**; every1254 previously correct
  GP reference stays correct. All172 HUD data/zero reference encodings pass.
- Eight unused raw GLOBAL exports are correctly replaced by native STAT/LOCAL
  source identities. No alias or fabricated variable is introduced.
- BuildPattern restores its four native scopes and compound for condition:
  **SLD0/72 ->0/0**. Original pattern/i types and homes are preserved.
- **85/85 functions and739 branches pass**. SwitchSong62, Playlist34 and
  BuildPattern52 actual linked words match retail. Normal code objects and
  the objdiff report remain unchanged.

## Preservation and qualifications

Raw r15's3288 bytes/30 symbols/six pointer relocations and the604-byte tail's
73 symbols remain in their exact oracle pieces. Native neighbors stay fixed.
The668-byte initialized duplicate and76-byte zero-storage duplicate are retired
without rewriting compiler outputs. Raw-blob duplicates fall729 ->720; the
eight corrected STAT exports were not duplicate source GLOBAL definitions.

All3864 ordinary native public full records and91 established file-qualified
native LOCAL contracts are preserved. Biglen's native address, width, binding
and bytes stay exact; its output-container change is explicit. The eight wrong
GLOBAL→LOCAL transitions are recorded separately, not hidden as exemptions.

All2336 changed executable-input words are existing relocations, including140
R26 words. The review follows input executable flags inside .data_rest, too.
All3238 previously native-positioned STT_FUNC records/addresses remain exact.
Four already-unanchored code inputs move backward76 bytes (feapp, xform, C52,
C_002); they remain placement debt. A separate inert24-byte SN-LNK blob also
moves and has no references. Not all code geometry is unchanged.

No new overlap area/multiplicity appears, but existing overlaps and1006 wrong
GP targets remain. HUD's .bss1226 owner and historical misleading scalar-split
comments are future work. This is not a fully runnable/native-layout seal.

## Evidence

- `integration.json`: actual85 gates,739 branches, unchanged code objects,
  four exact raw objects, native62/34/52-word checks and private/actual ELF identity.
- `pattern_actual.json`, `actual_pattern/bounded_implicit_inspection.json`:
  actual source-path native local/scope/SLD proof; all22 neighbors preserved.
- `final_gp_audit.json`, `actual_prior_local_preservation.json`: actual binding
  audit and91 established LOCAL contracts.
- `../p910_hud_data/combined_peer/README.md`, `combined_review.json`,
  `relocation_encodings.json`: complete combined-image/reference/class-aware
  preservation, explicit spill movements and overlap qualifications.
- `../p910_hud_sbss/guard_controls`:268 zero-owner controls; old six contracts
  preserved. Beyond-EOF NOBITS-offset acceptance proves no fake payload read.
- `../p910_hud_data/peer`:66 negative initialized-data controls and native
  declaration/raw-split proof. No new validation predicate for this data row.
- The alignment4 private intermediate remains frozen; only the refreshed
  alignment8 image is accepted. Generator defaults preserve all old outputs.
- `final_transport.json`: raw header clarification is object-byte neutral.
- `relink.json`: both scoped lanes GREEN;720 known raw duplicates remain.
- `final_receipts.json`, `publication_manifest.json`: final hashes and explicit
  cumulative file selection; no staging or publication is performed.

ELF:69a16b3e8b61fd915369ab7ac44701a66bf484e0556ec7f5cf87ea7950a75570.
Map:03555ee72bfaa24e0a8cde24fbd5c50505e807c1f11abfd1ca4e0c130f865714.
Report:2f64da5ebcadf1b920d8668e8a02ffed87abf40a1621fd45bfa97b3805ab19c3.

No new source asm, volatile, invented identifier or postcompile rewrite.
Protected-file backups, failed probes and unrelated user edits are preserved.
