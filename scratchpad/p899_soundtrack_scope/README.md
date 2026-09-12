# P899 SoundTrack native scope recovery

Isolated proposal only, based on the actual P898 combined source. Production
source and normal build outputs are untouched. The parent's separate Reset
work is not included. All prior P898 and intermediate P899 receipts remain.

## Result

- SoundTrack native named-local owner mismatches:25->0. All25 existing names,
  types, physical homes and declaration order are preserved; their actual
  scope start/end VAs and nesting depths now match native SYM exactly.
- Every emitted block matches the corresponding native block in order,
  address span, depth and declaration ownership:19/19. Native has21 blocks;
  ONLY the two zero-width empty records1bf164/1bf16d at8007CE40 are absent.
  Their original inline identity remains unknown and was not invented.
- Native SLD bad pairs improve115 merges/132 splits ->22 merges/120 splits:
 93 erroneous merges and12 splits removed, ZERO new bad pairs.
- Whole TU remains6/6 PASS, all159 branch checks exact, full normal object
  literally byte-identical before/after. SoundTrack358/358 raw ROM words
  match after resolving26 relocation words. The type-false branch at
 8007D098 remains10400097 ->8007D2F8, bypassing the later type reload.
- All five neighboring functions preserve their complete normal/debug code,
  local declarations, actual scopes and SLD partitions. PreLoad remains2/5
  merged/split pairs with all five recovered se/i/x/z/d owners exact.

## Evidence-backed source changes

1. The communication-mode and master-ambient checks become early returns,
   preserving evaluation order and all side effects. The remaining
   AudioTrk_g guard is unbraced around the gGameAudioList condition. Native
   blocks1bf081/08a/093/09c/0a5 begin atCDC4/CE1C/CE2C/CE2C/CE40. This removes
   four excess nesting levels without moving any native local lifetime.
2. The upper-word range check is separated from a nested combined
   nextDelay/channel condition, in the original short-circuit order. Native
   blocks1bf248/251 beginCF98; randtick1bf263 ownsCFBC..D008, depth12.
3. The later animated-type/anim-nonnull checks become one combined condition.
   The complete repeated type/anim-null continue check remains inside the
   distance gate but OUTSIDE that animation body. Native block1bf2ef ends
   atD2D8; fadeIn/fadeOut1bf301/315 occupyD0A8..D2D8 depth10, and
   nextcp/next/time1bf33c/35b/36d occupyD128..D294 depth12.

The repeated post-call type read is retained: calls receive &se->cp and may
affect its containing object. It is not replaced by a cached predicate or
anim==0 alone. cur/max reads and modulo/tck conversion remain inside the
nonnull animation arm. Native scopes—not variable-name substitution—drive
these changes. No identifier, helper, asm, volatile, flag, pin or output
rewrite was added. The verified P898 widened subtraction remains unchanged.

## Bounded progression

| Stage | Native owner mismatches | Native SLD merges/splits | Gate |
|---|---:|---:|---|
| Current P898 baseline |25 |115/132 |6/6; identical object |
| top_guards |6 |67/132 |6/6; identical object |
| delay_nested |5 |22/132 |6/6; identical object |
| anim_scope: move tail only |5 |22/132 |6/6; identical object |
| anim_combined |0 |22/120 |6/6; identical object |
| candidate: indentation only |0 |22/120 |6/6; identical object |

There were no code-regressing trials in this bounded round. anim_scope is
retained as an intermediate: moving the tail corrects the block end but the
combined predicate is also required to remove two excess D0A0 scopes.
Final indentation cleanup changed no source line counts or tokens; its
entire compiler debug assembly is literally identical to anim_combined.

## Scope of proof and remaining work

This is not a full source/SLD seal. The two CE40 zero-width blocks and their
original inline/helper identity remain unrecovered. The22/120 remaining SLD
pairs are explicitly listed in remaining_SLD_pairs.json; no generic carrier
or statement exceptions hide them. P898's original widening-cast spelling
also remains unproved. Existing Reset se provenance is outside this task.

Candidate source SHA256:
`d7009408e9ba6bf86d4113a119e271b2c0edb9f97b500ae94a726341a1ff1eb2`.
Baseline production SHA256:
`eee9c46e75fbcc679600c014015786feceff694dc3c09525af2b9d54b380873c`.
Both isolated normal objects SHA256:
`3661de77cca092475fa8d0aaaa64029838dcf298bb907e1dbc58a29fcb5e08e4`.

## Artifacts

- proposed.patch: exact candidate hunk, including indentation of the restored
  nesting; no other function body changes.
- check_proposal.py / proposal.json: read-only baseline/candidate/input and
  receipt hashes, suitable for parent review before combining disjoint work.
- candidate_verification.json: all six local/scope/SLD records, complete
  native SoundTrack record and all25 owner comparisons.
- final_receipt.json: exact19-block projection, remaining two records,
  PreLoad protection, raw358 proof and critical branch destination.
- candidate_raw_target_receipt.json, debug_labels_receipt.json: raw refs and
  unchanged-assembly/GAS-L lexical-label diagnostics. No labels are rewritten.

Parent must independently gate the combined ACTUAL production source after
landing. Local scratch verifiers depend on the existing project parsers and
compiler/ROM inputs; these receipts are not standalone distribution claims.
