# P898: AIPhysic_GetDesiredVector native scope restoration

Freshly revalidated on 2026-09-12 at `b36aebd025c217956a40ed448d173111ff7f9e7c`.
Proposal only. No production sources or normal build outputs were changed.

## Proposed source correction

In `recon/game/common/aiphysic.cpp`, remove the redundant unnamed wrapper
following `AIPhysic_CalculateRoadPosition`, and move the existing `int checkSide;`
declaration into its existing off-road conditional immediately before the separate
`checkSide = 1;` assignment. No expression, control-flow, assignment, local name,
type, macro, qualifier, or compiler flag changes.

The complete nine-file private include closure still matches the original frozen
inputs. `frozen_inputs.json` records those hashes and include edges;
`current_input_receipt.json` records the fresh production/candidate checks.

Run `python scratchpad/p898_aiphysic_scope_resume_20260912/propose.py` from the
repository root to validate the inputs and receipts and print the exact one-file
`apply_patch` proposal. The script does not apply the patch.

## Authoritative evidence

Native function: `AIPhysic_GetDesiredVector__FP8Car_tObj`,
`8006AC3C..8006B224` (1512 bytes / 378 instructions).
SYM records `11cb9e..11cdca` in
`C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt`.

| Native block records | Native half-open span | Depth | Fresh candidate |
|---|---|---:|---|
| 11cc1e..11cdc1 | 8006AC3C..8006B204 | 0 | exact |
| 11cd74..11cdb8 | 8006AF18..8006B1B8 | 1 | exact |
| 11cd7d..11cdaf | 8006AF80..8006B170 | 2 | exact |
| 11cd86..11cda6 | 8006B104..8006B164 | 3 | exact |

`checkSide`, native record `11cd8f`, is `REG INT $10` (register s0) in the
depth-3 block. The baseline emitted only the root block and placed `checkSide`
at function scope. The candidate restores all four native block ranges/depths,
every block's declaration ownership, and all 14 parameter/local types and homes.
Frame 88 and mask `0x801f0000,-4` remain exact.

## Fresh verification

- `before.json` and `candidate.json`: 42/42 detailed PASS and 42 clean branch
  comparisons; exact-debug text equals normal text on both sides.
- The entire normal object is literally byte-identical before/after, SHA-256
  `db3a72d114907bc2fdfb83f19d6b217b479c2acf2a02c5b34b1bc3a6fe6cfd44`.
  This dated scratch pathname differs from the earlier P898 scratch pathname;
  comparisons are made within each same-path baseline/candidate pair.
- `candidate_scope.json`: all 41 neighboring functions retain their full
  debug/local/lexical instruction contracts and source-line partitions.
- `candidate_raw.json`: all 378 raw words equal `rom/nfs4-f.exe`; 340 words
  compare directly, 38 reference words are resolved in verifier memory only.
  Original object hashes remain unchanged. Target raw SHA-256:
  `e16f98c5d37155a416fd13f6f21e8949209c8c71329352e79286b583f271d1ac`.
- Native SLD pair differences remain 77 merges / 184 splits, with zero new
  bad pairs. This is genuine lexical-scope recovery, **not** complete source-line
  restoration. Original physical line numbers and token/macro spellings remain
  unsealed; no formatting changes were attempted.

## Preserved exploration history

All original results remain under `scratchpad/p898_aiphysic_scope` and were not
rerun or overwritten. Only the retained candidate was freshly compiled here.

1. Baseline: one emitted root block; `checkSide` at function scope.
2. `decl_only`: narrowing `checkSide` creates five blocks, including duplicate
   `8006AF80..8006B170` parents; the correct leaf span is at the wrong depth 4.
3. `paired`: moving the wrapper opening to the `fCPoint` copy remains five
   blocks with the same duplicate. Code-neutral, not a restoration improvement.
4. Retained `candidate`: removing the unnecessary wrapper, together with the
   narrow declaration, gives exactly the four native ranges/depths above.

All variants retained 42/42 code matches. The selection is based on native
ownership/topology, not a score-only or invented-name cleanup.

Production source SHA-256:
`d64dc195b42d474e9b4237d93ff1e43561b89cf3d0ecf273b478ee59089e9651`.
Retained candidate SHA-256:
`30354ff9db164a0bc0ff3529e9305fcfc53d9d5fc8405799aa288c1d24525654`.

## Actual production landing validation

Root subsequently landed the exact logical patch. New `landed.json`,
`landed_scope.json`, `landed_raw.json`, and `landed_verified.json` validate the
actual `recon/game/common/aiphysic.cpp` path with isolated outputs. The original
fresh before/candidate receipts remain unchanged.

Actual source SHA-256 is
`494c693f0da1533e01f60db77f1a74a285d387cd8c43a6eaa4c910071e5f7345`.
Landing changed seven CRLF endings to LF (94763 to 94756 bytes); after comparing
line endings, source content is exactly the retained candidate. Validation made
no formatting changes. All eight actual header hashes remain unchanged.

Actual normal object SHA-256 is
`f0e2531e355fee1f87a628bd7ad44e5f14c4bb17362df7fa6a787c071b25f2dd`.
`verify_landed.py` proves the entire object matches the scratch candidate except
the one exact C++ STT_FILE pathname (including its doubled backslashes). All
other ordered symbols, headers, section payloads/storage, schemas and ordered
relocations are unchanged. The generic `landed_scope.json` literal-object gate
is therefore false by design; `landed_verified.json` is the combined actual-path
acceptance receipt, not a relaxation of any code or source-scope check.

The actual path independently retains 42/42 PASS and clean branches, all four
native scopes, all 14 homes, all 41 neighbor contracts and 378 exact raw words.
SLD remains 77/184 with zero new pairs. No production files or normal build
outputs were changed by this independent validation.
