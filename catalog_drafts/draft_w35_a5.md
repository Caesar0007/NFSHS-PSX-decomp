# wave-35 agent a5 — catalog draft (eaclib file/stream cluster)

Rows are formatted for the existing per-section tables (`| symptom | fix | example / §ref |`).

## -> §A (REGISTER COLORING / COALESCING)

| symptom | fix | example / §ref |
|---|---|---|
| a documented "merged variable" experiment (fold a block-local compare/state temp into an existing named local so they share a register) gates WORSE than the unmerged form, and the verdict is filed as an allocno-priority gap needing +N priority | **MERGE EVERY ARM, NOT JUST THE FIRST.** A partial merge (`x = load; if (x != K) {...}` with the other arms still assigning the OLD variable) leaves the original anonymous temp alive, so the measurement is of a THIRD shape, not of the merge. Spell out an explicit assignment to the merged variable in *every* arm (incl. the `else` that the unmerged form left implicit); gcc tail-merges the duplicate stores, so the instruction stream is unchanged while the register roles snap to retail's. | `startnextrequest` (eacpsxz/stream.c) 16 -> **PASS 100/100**; the w34 note had recorded the partial merge as "20 diffs, needs `done` +519 priority" |
| a block-local pseudo steals a callee/caller-saved register that a longer-lived variable needs, and giving that value its own named local changes NOTHING | **THE NAMED LOCAL MUST BE ASSIGNED IN TWO BLOCKS TO STOP BEING BLOCK-LOCAL.** A local whose every reference sits in one basic block is still handled by local-alloc and behaves exactly like the anonymous temp (measured identical in all 3 declaration positions). Re-use the SAME variable for the pre-call and the post-call read of the same memory (e.g. the pointer that is also the `memcpy` destination argument): it becomes a global allocno and inherits the call's hard-reg COPY PREFERENCE, which is usually the register retail used. | `restartstream` (eacpsxz/stream.c) 42 -> 6 via `unsigned char *bb` used as memcpy's arg1 and re-read after the call; a dedicated post-call-only `bb` = 42 (no change) |
| ...same, but you cannot reuse one variable across the call | **WEAKER FORM — stage the value in an existing LONG-LIVED local** (one that is dead at that point). Measured on the same function: staging into `room` 42->22, into the fn-scope `p` 42->17 *but 1 insn short* (p's extra liveness costs the first loop's live-range-split copy), into `q` 34, into a same-block temp 42. Pick the staging variable by how far its live range already reaches, not by which one is "dead". | `restartstream`; catalog "dead-var staging" row (wave-10 a2) refined |
| ours computes a value directly into the result variable and then decrements it in place (`subu a1,v0,v1; addiu a1,a1,-1`), the oracle computes into a scratch and creates the result at the decrement (`subu v0,v0,v1; addiu a1,v0,-1`) | **SPLIT THE FINAL ADJUSTMENT OFF INTO ITS OWN VARIABLE** (`raw = A - B;` … `result = raw - 1;`) instead of letting one variable be assigned then adjusted — a single variable lets gcc coalesce both into one pseudo. | `restartstream` 6 -> 2 |
| an EXACT allocno_compare tie (`floor_log2(refs)*refs/live_length` equal to 4+ digits) that a tie-break hands to the wrong variable (ties go to the LOWER pseudo number) | **PERTURB LIVE LENGTH BY ONE INSN with an honest source change** — e.g. read a global into a guard-local at the top of the block instead of inline at its use. That lengthened `off`'s range 22->23 insns, dropping its priority 1.500 -> 1.435 below the tied competitor's 1.500 and flipping the whole [slot, off, i, …] order to retail's. | `reserveop` (eacpsxz/nfile.c) 46 -> 40, `unsigned int seq = gFileOpSeq;` as the guard's first statement |

## -> the IN-LOOP-DEF REF DIAL (w35 lever) — BOUNDARIES MEASURED

| finding | detail | example |
|---|---|---|
| the dial DOES refute "no 3rd in-loop reference exists" verdicts | declaring an invariant uninitialised and assigning it as the first statement INSIDE the loop leaves the instructions identical (loop.c hoists the movable back into the pre-header) but the def is then loop-depth-weighted, so `REG_N_REFS` rises by 1 and the `-dg` allocno order changes. It flipped `reserveop`'s order to retail's exact `[slot, off, i, seqMask, mgrbase, hicopy]`. | `reserveop`: seqMask 5 refs -> 6; the w34 "either a 3rd in-loop ref (none exists) or a 1.4x longer mgrbase range" dichotomy is FALSE |
| but it has TWO costs that can exceed the win | (a) **POSITION**: loop.c emits the hoisted movable at the END of the pre-header, so a constant that retail materialises in the middle of its constant block moves to the end (2 unconditional diffs). (b) **IT ONLY FIXES THE ORDER**: the hard-reg conflicts that local-alloc has already created (a block-local pseudo pre-assigned to the register you want) survive any allocno ORDER change, so global-alloc still cannot hand out retail's registers. `reserveop` with the dial = 46 vs 40 without. | `reserveop`; conflicts visible as the `;; NN conflicts: … 2 5 29` hard-reg entries in the `-dg` dump |
| the dial is unavailable in loop-free functions, and the PARAM-COPY dial does not substitute | a local copy of a POINTER param that is only ever DEREFERENCED is copy-propagated away entirely — the `-dl` numbers come back bit-identical. The vramfxya param-copy dial works only where the copy is used as a loop-carried VALUE. | `loadfileadratomic` (eacpsxz/nsync.c): `LoadArgs *aa = a;` + all 5 derefs rerouted = identical 22 diffs, `a` still 6 refs / 62 insns |

## PROCESS

- **BLOCKING-CASCADE RULE CONFIRMED AGAIN**: `startnextrequest`'s merged form and `restartstream`'s
  wrap-arm levers were both recorded as measured-and-worse in w33/w34. Both were re-measured this
  wave and both were wrong — one because the experiment was mis-spelled (partial merge), one because
  the earlier attempt used a block-local instead of a cross-block variable. Re-test shelved leads
  after ANY structural change, and re-derive the experiment rather than trusting its recorded number.
- A residual whose every line is a register RENAME with the instruction sequence, operand order and
  delay slots already agreeing is a local-alloc problem; read `;; NN conflicts:` in `cc1 -dg` to find
  which HARD reg is banned and which block-local pseudo took it, then aim the source lever at that
  pseudo, not at the global allocno order.
