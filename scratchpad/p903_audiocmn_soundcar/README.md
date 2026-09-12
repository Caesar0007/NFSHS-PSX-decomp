# P903 SoundCar: native owners and direct gas-ramp source

2026-09-12. Accepted source-only changes are in candidate_source.cpp and the
root's combined production AudioCmn source. No header/flag/tool change, new
name/helper/macro, volatile qualifier or compiler-output rewrite is used.

## Retained result

- Four unproved locals removed: **currentGas, previousGas, gasDelta, rampedGas**.
- Their two empty-asm uses removed; the other three pre-existing asm sites are
  retained unchanged and remain source-recovery debt.
- The early audio-off return removes two unsupported wrapper scopes and
  restores native gas at depth1. All18 non-static local owners are now exact,
  versus17 before; independent peer review also confirms static cobbleCount.
- Direct PlayersRampedGasLevel indexing and ordinary branch-local rising
  stores plus MIN for the falling step preserve the entire gas-ramp behavior.
  No guessed local names or compensating qualifiers replace the deleted ones.
- The wet-noise if/else removes two reconstruction labels without changing
  the emitted branches.
- **530/530 raw words**,70 reference words, native static byte and all12
  switch-table targets exact. Whole normal object unchanged;48/48PASS and
  513 branch checks preserved, including all47 neighboring source contracts.
- Native SLD **37/319 ->37/261**, no new bad pairs; emitted scopes12->5.
  The remaining3 extra scopes,6 unproved locals,3 asm sites and SLD residuals
  prevent a full source/SYM/SLD exactness claim.

Root proof: candidate_inspection.json; independent proof: peer_review.json,
peer_REVIEW.md, peer_candidate_raw_receipt.json, peer_static_table.md.
The actual combined source is verified separately after integrating Traffic.

## Source reasoning

The old ramp cached a byte gas value, previous array value, array pointer and
separate difference, using two fences to preserve a copy and pointer lifetime.
Replacing the scalar trio together makes the falling step a normal minimum:
the signed difference divided by8, bounded above by-1. The rising step must
use branch-local stores rather than a shared selected increment; that avoids
one extra branch/instruction. Replacing the remaining pointer and fence with
direct array accesses then remains byte-identical. Individual historical
failures did not prove any of these named objects or fences was necessary.

The early audio gate leaves all live behavior unchanged and corrects native
gas owner1930f0 at80079044..800790D4, depth1. It does not claim the remaining
unnamed extra scopes were original. Static cobbleCount remains in the native
root, CHAR/type2, with zero initial byte at8013C6B0.

## Frozen probe ledger

Counts are target words / unified diff lines, not fuzzy percentages. Only
the retained equal-object stages are used for final source/SLD claims.

| Stage | Code | Result |
|---|---|---|
| before |530/PASS |17/18 ordinary owners,12scopes,SLD37/319 |
| native_freq_assignment |526/8 |dead product eliminated; rejected |
| early_audio_gate |530/PASS |18/18 owners,10scopes |
| native_distance_div |530/92 |saved-register swap; rejected |
| native_freq_clamp |534/6 |extra signed-division prefix; diagnostic |
| native_freq_shift_clamp |530/PASS |unproven dead-clamp mechanism; NOT retained |
| gas_widened |530/8 |still loses native division copy; rejected |
| direct_gas_ramp |531/5 |three scalar aliases/fence gone, rising select wrong |
| ramp_store_branches |530/PASS |branch-local rising stores fix code;6scopes,37/286 |
| direct_ramp_array |530/PASS |pointer/fence gone;5scopes,37/261 |
| ramp_and_distance |530/92 |distance-divide retry after structural landing; rejected |
| distance_in_place |530/14 |intermediate product home/branch changes; rejected |
| direct_products / product_shift_width |530/4 |anonymous road product in t1, not v0 |
| structured_wet_noise |530/4 |product mismatch remains; paired probe |
| direct_amplitude / amplitude_wide_compare |533/29 |clamp/receiver handoff changes; rejected |
| native_tunnel_read |530/4 |product temporary mismatch; rejected |
| only_product_reference |531/3 |late tunnel load/NOP; rejected |
| ramp_and_wet / candidate |530/PASS |retained ramp+scope+wet structure only |

All failed source forms are private and frozen. No function was regressed in
production, and no failed experiment is classified as an immutable floor.

## Why the passing dead clamp was not landed

Raw80078E84..80078E90 contains a load/NOP/multiply/mflo whose result is dead
before either outgoing call. Plain `freq *= doppler` deletes it. A hypothetical
MIN of the shifted product reproduces it via late dead-conditional cleanup.
This proves a concrete ordinary-C compiler mechanism, not the original shift,
comparison or limit127. The source corpus supplies related pitch-clamp idioms
but not this original expression. The proposed clamp would replace one
unexplained codegen carrier with another, so it remains a diagnostic only.
See compiler_dead_product.md; the existing product fence is not declared native.

## Data/reference qualifications

- cobbleCount.66 is .sdata+0x88, native STAT CHAR record192FE4, initial byte0;
  its GP references and46 mapped owned small-data symbols corroborate the base.
- PlayersRampedGasLevel occupies8 NOBITS bytes at native8013DD80.
- The12-entry road-surface table is raw-exact at8005573C. Its current compiled
  .rodata offset104 needs fragment base800556D4, whereas the async loader's
  literals require800556D0. This existing **four-byte whole-rodata packing
  discrepancy** remains explicit. A per-fragment raw proof is not a claim that
  the entire TU's rodata or final linked image is native-exact.
- Relocations are evaluated only in verifier memory; no object/image/debug
  instruction or marker is rewritten. GAS-L retains existing anchors only.

The main original-source/SYM/SLD/layout goal remains open.
