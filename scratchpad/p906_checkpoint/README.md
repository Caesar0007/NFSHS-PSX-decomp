# P906: source fields, native store order and data ownership

Final verified state, 2026-09-12. Last published checkpoint remains `7aef1e7c`;
P904–P906 are local and not yet committed/pushed.

## Result

- **108 FEI pointers use native typed names**, including 107 GameSetup field/
  array paths. All 114 integer values, six nulls and 108 relocations are exact.
  The actual FEI object is literally unchanged; its native table is 912 bytes.
- **Four source stores restored to native order** in AudioCmn_Init and
  TrackSpec_Read. All four actual linked store words now match retail.
  TrackSpec's SLD split count improves 8 -> 7; Audio's remaining 100 splits
  are explicitly not claimed solved.
- **126 incorrect GP bindings repaired: 1,403 -> 1,277.** AudioCmn's complete
  248-byte initialized state now occupies its native source-owned address.
  Two genuine function statics remain LOCAL; ten literal-carrier names remain
  explicitly unproved. TrackSpec's 12-byte duplicate is also retired.
- **29,800 duplicate raw bytes retired**: Replay 28,628, FEI 912, Audio 248,
  TrackSpec 12. Every raw byte/label remains in the oracle lane. Raw-blob
  duplicate count falls **848 -> 780**; REAL duplicates/phantoms/unresolved
  references remain zero.
- **69 functions / 739 branches freshly verified**; FEI is data-only.
  EAC's 248 functions remain protected by unchanged whole objects. Primate's
  81 and callback's 25 actual retail words remain exact. All 354 Audio/Track
  reference targets and 61 storage addresses are independently checked.
- All 973 other previously good GP references, 3,780 native public bindings
  and 86 native local records are preserved. Of 702 old linked inputs,
  699 are unchanged. The objdiff report is literally unchanged.

## Important qualifications

The original isolated store proof substituted native target addresses in a
verifier buffer. That proved the source-symbol order, **not actual placement**.
Track's old pair was name-correct/raw-wrong; Audio's old pair also pointed at
misplaced storage. The final complete Audio owner move resolves that second
problem. Use `peer_final_preservation_corrected.json`, not the superseded
all-four-good wording in provisional receipts.

The full image remains incomplete: 1,277 wrong GP targets, three unknown
expectations and 133 output overlap pairs remain. Overlap pairs fell from
139 without increased overlap area/multiplicity. The native callback buffer
still overlaps `.data_rest`, now via raw `data_8010CCD4_o20.data.s.o`
at `8014773C..80148164`. This GameSetup copy is the next concrete candidate;
its complete source ownership must be proved before removing it.

FEI field names/types and all values are grounded in SYM/CPE/raw/compiler
evidence, but literal original macro/token spelling is not recovered. Replay's
data coverage is complete without declaring its entire source/local/SLD graph
exact. Audio's ten explicit literal carriers remain in the source backlog.

## Verification receipts

- `final_receipts.json`: final source/tool/object/link hashes and scoped results.
- `combined.json`: actual four-TU compilation, 69 detailed gates and 739
  branch comparisons. Its ELF hash is the intermediate pre-Audio-owner stage;
  final source/object hashes remain valid, final link hashes are above.
- `owned_gp_audit.json`, `owned_relink.json`: final 2,381 GP rows and both lanes.
- `peer_final_preservation_corrected.json`, `peer_owner_references_final.json`,
  `peer_final_review.md`: authoritative independent actual-link proof and erratum.
- `replay_stage.json`, `peer_replay_review.json`: exact eight-section Replay
  group, three CPE alignment bytes and complete preserved raw split.
- `replay_controls.json`: 16 bad owner/group cases rejected; two wrong-order
  native linker assertions detected even though GNU ld returned zero.
- `../p906_native_name_conflicts/landed_verified.json`: actual-source private
  compilation equals accepted candidates, including debug/local/scope/SLD proof.
- `../p906_native_name_conflicts/ownership/proposed_owners.json`: 58/3 symbol
  contracts, primary offsets/types and the two literal-extent corrections.
- `../p906_fei_owner/actual/final31/README.md`: 51 FEI controls, all 31 real
  owner rows valid, 30 default no-relocation guards preserved, exact helper
  AST and public-anchor-selector checks. The earlier 50/51 visibility failure
  remains frozen; the missing bounded visibility check was corrected.
- `../p906_fei_owner/actual_source_final/review.json`: 108 actual typed pointers,
  inherited header hashes, identical object and full native CPE/ROM table.

`backups/` holds pre-change protected tools, source, linker and image artifacts.
No new source assembly, volatile, invented names or postcompile instruction/
object/relocation rewriting was introduced. User edits are preserved. The
full original-source/SYM/SLD goal remains active.
