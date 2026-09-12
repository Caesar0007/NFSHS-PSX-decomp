# P910 AudioMus_BuildPattern: verified native loop and scope recovery

Isolated proposal only. No production source/header/tool/flag or normal output
was changed. The landed SwitchSong and Playlist recoveries are preserved.

The retained candidate uses the existing native `i` in a for-init declaration,
combines the total-song and32-song capacity bounds into the for condition, and
uses implicit void exit. No identifiers, helpers, macros, qualifiers, asm,
volatile, pins or compiler-output rewrites are introduced.

## Native evidence

- SYM19faf0..19fbb1: function8007AF60..8007B030,52 words, frame40,
  mask80030000. Parameter pattern is PTR CHAR in s1 (`19fb45`); i is INT in
  s0 (`19fb7e`). M2C's inferred byte type for its counter is not adopted.
- Four native scopes, all ending8007B01C: depths0/1 start8007AF60;
  depths2/3 start8007AF7C. Only the depth3 scope owns i. The old source hoisted
  i into a single root block; the final candidate reproduces all four exactly.
- Native SLD861 groups the initial total-song and capacity tests. The ordinary
  combined for condition preserves their left-to-right read order and bound
  behavior. Native SLD868 groups the loop tail with the epilogue.
- Raw/M2C agree on the five-argument locatebigentry call, wildcard call, byte
  playlist store and following available-song increment. The capacity guard
  terminates before either call when32 entries have been produced.

## Frozen stages

| Stage | TU gates / branches | SLD merges/splits | Native scopes |
|---|---|---|---|
| before |23 PASS /206|0/72|one root; i hoisted|
| natural for, separate cap return |23 PASS /206|0/63|four exact|
| remove final return only |23 PASS /206|0/63|four exact; neutral|
| combined wrapped-header condition |23 PASS /206|66/41|four exact; rejected|
| bounded_implicit — retain |23 PASS /206|0/0|four exact|

Physical expression grouping is explicit evidence here: the retained ordinary
compound for header occupies one source line, matching native861. The wrapped
two-line header altered debug attribution of the copied loop condition despite
identical machine code. The final paired form also removes explicit final exit.
No unrelated statements were collapsed onto one line, and no debug labels or
compiler output were rewritten. Exact original whitespace/token spelling is not
claimed merely because the native equality partition now matches.

All stages preserve complete normal-object code/data/symbol/relocation metadata
apart from the exact checked scratch STT_FILE path. Final proof also verifies:

- All23 function gates and206 branch checks.
- All22 neighboring complete local/lexical/SLD/compiler-label graphs, including
  SwitchSong0/0, Playlist0/0, PlaySong0/0 and Threshold0/0; Server remains39/29.
- All52 raw instruction words, resolving five GP references to native
  AudioMus_g8013C720 and calls to locatebigentry800E61B8/wildcard800E89BC.
- Native parameter/local types and homes; identical preprocessor header stream.

## Exact proposal

- Actual production input SHA256:
  `82ded1369443f4b42542a84bba4ab9c2eebdb5decc5b995aa69368c982f9f98b`.
- Final `inputs/bounded_implicit.cpp` SHA256:
  `5c06264c49606cc571e7ba2a968f4bd82491cd0f84d5fc3ce3f402842cc76080`.
- Apply-ready `proposed.patch` targets the absolute production path.
- Native52-word SHA256:
  `171c6adc3f455b0ccdf39ebe5ab4a22077c8f782e890464a3e873b771b5642d6`.

Primary receipts: `final_receipt.json`, `bounded_implicit_inspection.json`, and
every preserved intermediate source/object/debug receipt. Parent must recheck
actual landed paths before publication. This does not claim complete project
source restoration or final linked-image correctness.
