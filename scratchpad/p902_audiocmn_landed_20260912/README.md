# P902 actual-source validation

After root applied the exact proposal, this namespace freshly compiled the
actual `recon/game/common/audiocmn.cpp` against actual production headers.
All outputs stayed isolated here; no normal output or production file was
written by this agent. Source hash:
`ea914b6e9f5a712cf7f176385268e890fb9651f38396a062f4c5a3a4316cd629`.

- **48/48 PASS**, **513 branches** clean.
- Actual normal object SHA256:
  `71ddb86db9e91f16ed317d1fc7f327931b6deed22543f03c5aa7a9f86f12b993`.
- Compared against both frozen original and candidate objects: every code,
  data/storage section, ELF semantic header, program header, section order,
  symbol record and relocation is identical **except exactly the checked
  STT_FILE source-path replacement**. No blanket FILE/symbol exclusion.
- Whole `-g` text exact. All 48 compiler instruction/label/scope graphs,
  local declarations and source partitions agree with the accepted candidate;
  the 47 unaffected functions also preserve the original baseline, proven
  through the frozen before/candidate receipt. Real source-label PCs are
  checked wherever compiler labels appear in declarations.
- All **105** target instruction words and **23** resolved reference words
  match raw ROM. Both diagnostic literals and `SFXHDR` match at native VAs.
- Native `slot` and `check` retain their exact root scope and types/homes.
  SLD remains **0 merges / 9 splits**, improved from original 0/58.

`s` is still an unproved source-only alias. The extra empty lexical block
`800767AC..800768C4` remains; native has one block, reconstruction two.
Neither this validation nor PASS asserts complete original-source recovery.
No new syntax experiments or production changes were made after landing.

Receipts: `landed.json`, `landed_verification.json`,
`landed_raw_target_receipt.json`, `debug_labels_receipt.json`.
`verify_landed.py` records all actual preprocessing input hashes and rejects
any staged scratch include. Debug labels were asserted unique; compiler
assembly was never rewritten.

```
python scratchpad/p902_audiocmn_landed_20260912/raw_target.py landed
python scratchpad/p902_audiocmn_landed_20260912/verify_landed.py
```
