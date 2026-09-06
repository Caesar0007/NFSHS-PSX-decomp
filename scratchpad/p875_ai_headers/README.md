# P875 AI public-header repair (2026-09-06)

The 201-row AI subset of the P874 queue is handled across 13 public headers.

- 197 native EXT free-function prototypes now use source names and emit the exact native GCC-v2 symbols.
- 15 signatures were additionally corrected: 7 Car_tObj pointer returns, 6 enum parameter types, 1 const comparator signature and 1 variadic Debug signature.
- 4 native STAT/source-static helpers were removed from the public prototypes; their private definitions remain.
- 49 compiler-blocking non-member bridge duplicates were removed only after the existing canonical class members/constructors emitted their 49 native symbols. No class layout or body changed.

All 13 complete corrected headers compile through the real CPP/CC1PLPSX/assembler pipeline.
Before correction, 9 complete headers compiled and 4 failed on the duplicate bridges;
isolating those 49 collisions in diagnostic snapshots allowed all 201 original free
prototypes to be checked: every one emitted an absent double-mangled reference.

Fresh paired objects expose all 197 public functions globally and all 4 private helpers
locally. The 13 paired translation units remain **274/274 PASS**. No paired CPP,
include directive, types/externs header, production tool, or oracle was changed.

## Remaining review

27 nonblocking ABI-spelled destructor/static declarations remain in `aihigh.h`
and `aistate.h`. They are preserved for a separate linkage/ABI review, not claimed
fixed or fully source-restored. No real project include consumer of these 13 public
headers was found; `src` symbol occurrences are oracle INCLUDE_ASM scaffolding.

## Reproduction and evidence

`receipts.json` stores every native record, before/after prototype, actual symbol
visibility, canonical class declaration, compiler result, remaining-review row and
final header hash. The `.before.h` snapshots and before/after/canonical diagnostic
sources are retained in this folder. Run a probe with:

```
python scratchpad/p875_ai_headers/check_probe.py scratchpad/p875_ai_headers/ai.after.cpp
```

The helper invokes the actual compiler and assembler without rewriting emitted
instructions or objects. Only existing unrelated CurrentPlayer char-to-enum
warnings remain. No commits or pushes were performed.
