# P916 independent AnimationTime review

**Result: the private native_min candidate passes this independent review.**

Candidate source SHA-256:
`e20516fa8f05777077f4ef48438780d611c094170ba777e07b1b2a2ede1ea055`

Candidate object SHA-256:
`c5a982a3f43072667121ad780a63565b55e256f5926d9cfa97b15ee8b8ef0b9b`

`review.json` SHA-256:
`6969b76a7d4a8d7d6d0d863bcc34bd7886f3a377af7a77469d11b1535c5909ab`

The review ran no compiler or assembler. It read the frozen before/candidate
sources, ordinary objects, label-retaining debug objects, compiler assembly,
primary SYM copies and retail EXE. Only this namespace received generated files.
The guides and both mandatory references had been read fully in the uninterrupted
session before this review.

## What was independently proved

- Source changes are confined to the target function region. The extra names
  `result` and `tick` disappear; only native `track` and `maxTick` remain.
- All ordinary object payloads, storage, ordered relocations, metadata schemas,
  and symbols are unchanged except the one exact STT_FILE path. The complete
  string-table difference is also exactly that filename replacement, not a
  blanket string-table exception.
- Normal/debug `.text` is identical. Native records 3e3a12..3e3af8 and actual
  retained labels agree on all three scope spans/depths: root track REG5,
  empty middle scope, and maxTick REG5 in the else scope at 800C7678.
  The parameter remains animInst REGPARM4, PTR Trk_AnimateInst of size12.
- Per-instruction native SLD partitions improve from 0 merges/73 splits to
  0/0. The five statement groups agree exactly, including the delayed `mflo`
  attributed to maxTick's calculation at native line1715.
- All 34 neighboring functions preserve their complete scope/declaration
  contracts and line partitions. Consistent graph-ID mapping is additionally
  checked against the actual PC of **every retained compiler label**, not only
  C LABEL `.scl 6` records. Numeric IDs may change; their targets may not.
- All 33 target instructions match concrete retail words after mathematically
  resolving its six existing HI/LO records from primary SYM data. No blanket
  relocation masking is used in this target proof. Its four branch destinations
  also match exactly.

The three target owner expressions are GameSetup_gData+60 = 80113228,
simGlobal+4 = 8011E0B0, and animation_timer = 8011F718. Primary records
2874b5/27de72, 345234/338790, and 3e64b4 establish their bases, fields and extent.
The native Trk_AnimateInst record establishes objectIndex as UCHAR at3 and count/
interval as SHORT at8/10, agreeing with the actual lbu/lh instructions.

Root's hash-verified saved full-TU gates remain 35/35 PASS and 361 branches.
Those are preserved compilation receipts, not fresh compilations by this peer.

## Interpretation and boundaries

The ordinary source correctly computes the signed product `(count - 2) *
interval`, then returns the smaller of that value and the animation timer. Its
early gameTicks path agrees with objectIndex==0 or track==3/7. No new type,
storage, qualifier, helper, or invented name is required.

The expression has the MIN operand order found in the reconstructed matched
NFS2 `match/nfs2.h:8`. The sibling `match/ealib.h:4` has the equivalent opposite
order. Neither reconstructed header proves the original NFS4 macro identity or
exact original tokens. The candidate is valid ordinary source without making
that stronger provenance claim.

This proves native scope/local homes and line-group correspondence, not literal
original whitespace, line numbers, or original header topology. Neighbor
contracts are preserved relative to the frozen baseline; their pre-existing
source fidelity is not newly certified. Expected instruction calculations exist
only inside the review process for comparison: no compiler output is rewritten.
