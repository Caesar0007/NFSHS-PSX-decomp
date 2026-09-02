# R04 detail — rows 3 and 4 (appendix to R04_receipt.md)

## Row 3 — `syslib/psx/libcd/drv` `CD_get_intr` @ NFS4-R-USA — SEALED BY THE SEED

Candidate `regiondiff/recon/NFS4-R-USA/syslib/psx/libcd/drv.c` = verbatim copy of
`recon/syslib/psx/libcd/drv.c`. The unedited seed gates green, so this row's regional
delta lives entirely in the link (address materialization), not in the source:

```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/syslib/psx/libcd/drv.c CD_get_intr --lane-as=recon/syslib/psx/libcd/drv.c
  CD_get_intr: REGION-PASS (343 insns) [NFS4-R-USA]
```

(The MANIFEST `words` column says 266 for this row while the gate aligns 343 instructions
on both sides — the manifest word count is not the instruction count here.)

## Row 4 — `frontend/psx/psxfront` `DoLanguageScreen__Fv` @ NFS4-R-UK-ES-IT — FAIL 50 (193/193)

Candidate `regiondiff/recon/NFS4-R-UK-ES-IT/frontend/psx/psxfront.cpp` (seed = verbatim
copy of `recon/frontend/psx/psxfront.cpp`).

Seed measurement: `FAIL 202 diffs (ours 15 / oracle 193)` — the base TU's
`DoLanguageScreen` is a 15-insn stub ("if the saved language is the 0xFF sentinel, force
English").

**Regional delta, one line: the multi-language PAL SKU ships the REAL language-picker
screen** — it loads `lang.psh`, locates 9 shapes and runs a VSync'd 3-language pick loop
(ENG / ITA / ESP) until Start or Select, then stores the chosen language code.

### Callee identification (NO base-symbol lookup of a regional VA)

Each `jal` target was identified by matching the regional slice's callee bytes against
`NFS4-B-USA.EXE` using an opcode+register skeleton search (immediates dropped), then
naming the hit from the base symbol table — content identity, not address identity:

| region VA | base VA | name |
|---|---|---|
| 800E5094 | 800E44BC | sprintf |
| 800F299C | 800F1C3C | loadshapeadr |
| 800E77DC | 800E6C04 | systemtask |
| 800EBAB8 | 800EB170 | locateshapez |
| 800F146C | 800F070C | settrans |
| 800F1498 | 800F0738 | movfxya |
| 800F2CA4 | 800F231C | VSync |
| 800E6118 | 800E5540 | purgememadr |
| 80023D50 | 80023C88 | FEInput_GetKeyFromPlayer |
| 800A5130 | 800A45B8 | NFS4_LoadingIcon |
| 8004DCF8 | (CHANGED — no skeleton hit) | Quick_DD |

The first three form the exact `sprintf(fullName, STR_FRMT[0], Paths_Paths[0x20],
"<file>.psh"); loadshapeadr(fullName, 0); systemtask(0);` idiom that `DoTitleScreen` uses
two functions earlier in the same TU.

NOTE FOR THE SIBLING UK-SW ROW (board row 58, another agent's candidate
`regiondiff/recon/NFS4-R-UK-SW/frontend/psx/psxfront.cpp`): that file names these callees
`creatememclass` / `setmemclass` / `GetPSXPadValue`. The skeleton match says they are
`sprintf` / `systemtask` / `FEInput_GetKeyFromPlayer`. Worth reconciling at consolidation.

Rodata read straight out of `NFS4-R-UK-ES-IT.EXE` at the slice's own pointer-table and
template VAs: shape names `back, yENG, yITA, yESP, bENG, bITA, bESP, lite, dark`;
language codes `{ 0, 4, 3 }` (ENG, ITA, ESP — the `== 3` test in the loop is the ESP
baseline); shape file `lang.psh`.

### Frame (all plain immediates, so the gate compares them exactly)

`sp-184`; `shapeNames[9] @ sp+16`, `shapes[9] @ sp+56`, `languages[3] @ sp+96`,
`fullName[48] @ sp+104`, saved `s0-s6`/`ra` from `sp+152`. Reproduced by declaring the
four arrays in that order (each lands 8-byte aligned).

### Levers found (202 -> 50; instruction count exact 193/193 from step 3 on)

1. **202 -> 127** — full body reconstruction from the oracle slice +
   `regiondiff/m2c/NFS4-R-UK-ES-IT/DoLanguageScreen__Fv.c`.
2. **127 -> 109** — the `x` init subtraction ORDER. The oracle is
   `246 - shapes[7]->width - (shapes[8]->width >> 1)`; writing the `>>1` term first makes
   gcc emit the two `subu`s the other way round. Useful tell in this function: `w >> 1` on
   a `short` field emits `lhu; sll 16; sra 17`, while a plain `w` use emits `lh` — the
   load width says which term is which.
3. **109 -> 102** — the per-row `x` advance. `x = x + 10 + shapes[7]->width` (with or
   without parentheses) folds to `x + (width + 10)` and needs a `nop` (194 insns). An
   explicit function-scope temp `nextX = x + 10; x = nextX + shapes[7]->width;` keeps the
   oracle's `(x + 10) + width`, and the `addiu` then fills the `lh` load-delay slot.
   Measured alternatives: `x = x + 10; x = x + w;` -> 108, `x += 10; x += w;` -> 108,
   `w + (x + 10)` -> 109 (194 insns).
4. **102 -> 52** — the inner per-language loop must be a REAL loop, not a `goto` label
   loop. Loop notes are what make flow.c weight the refs inside by loop depth
   (`REG_N_REFS (regno) += loop_depth`), and that weighting is what flips BOTH callee-saved
   pair swaps at once: `selected` vs the shapeNames-walker/`shapeOffset` on `s2/s3`, and
   `flash` vs the shapes base on `s4/s5`. `while (i < 3) {...}`,
   `for(;;){ if (i>=3) break; ... }` and `while(1){ if (i>=3) break; ... }` are equivalent
   here and all keep the oracle's top-test + `j` back-edge.
   **BUT a real loop lets loop.c hoist the `li 3` of `languages[i] == 3` into a fresh
   callee-saved reg** (`li s7,3`, frame 192, +3 insns): `move_movables` moves any invariant
   satisfying `threshold * savings * lifetime >= insn_count`, which a 1-insn `li` inside a
   ~35-insn loop always does.
   **THE SHIELD (new reusable lever): wrap the comparison in its own `do { ... } while (0)`.**
   That emits a nested pair of loop notes, so loop.c hoists the constant out of the
   `do-while(0)` only — leaving it INSIDE the real loop, exactly as the oracle has it:
   ```c
   { int y;
     do { y = 0xb9; if (languages[i] == 3) { y = 0xb8; } } while (0);
     movfxya(shape, x + centerOffset, y); }
   ```
   Wrapping the whole `movfxya(...)` call instead does NOT shield it (still 196 insns) —
   the invariant must sit inside the `do-while(0)` for the inner hoist to absorb it.
   Net: `do{}while(0)` buys a real loop's ref weighting without paying its invariant hoist.
5. **52 -> 50** — `i = 0;` moved down to sit immediately before the locate loop.

### Falsified angles (each measured; a gate run is ~1s here)

* Declaration ORDER of the 7 scalars — 6 permutations, all exactly 102 diffs (inert).
* `selected` initialised in its declaration / before the arrays / at function scope before
  the `if` — no effect on the `s2/s3` pair; gcc sinks the init into the taken branch.
* `flash = 0` hoisted to the top DOES fix the `s4/s5` pair by itself (102 -> 92, and 84
  once `settrans(flash)`, `movfxya(shapes[0],flash,flash)`, `key = flash` restore the `s5`
  operands) — but it moves `move s5,zero` off its oracle position. Superseded by lever 4,
  which fixes the same pair with the init left where the oracle has it.
* Explicit pointer-walk locate loop (`*shapePtr++ = locateshapez(f, *namePtr++)`):
  108 (goto inner) / 83 (while inner) — the index form is better both ways.
* Outer pick loop as a `goto` label loop: 116 / 107. The outer loop must stay a real `while`.
* `(languages[i] - 3) == 0` instead of `== 3`: does not dodge the hoist (196 either way).
* `const char *shapeNames[9]`: inert. `languages[]` filled by three stores instead of an
  initializer: 74 diffs / 195 insns (worse).
* Dropping the two `selected` clamps (diagnostic only, semantics changed): 186 insns, 83
  diffs — so the `s2/s3` swap is NOT a `floor_log2(REG_N_REFS)` cliff effect.

### Residual 50 diffs — three clusters, all caller-saved scratch tie-breaks

* ~26 — the `shapeNames` initializer BLOCK COPY picks a different scratch trio: ours
  `dest=v1`, `src=v0` (self-temp `addiu v0,v0,%lo`), `limit=a0`; oracle `dest=a2`,
  `src=v1` (separate temp `addiu v1,v0,%lo`), `limit=v0`. Same instructions in the same
  order, three different caller-saved names (local-alloc tie-break, §3.15 v0-vs-a2 family).
* ~12 — the `selOffset` scratch: ours `a3`, oracle `v0` (centerOffset lands in `a0` vs
  `v1`), downstream of the same tie-break.
* ~8 — two move-order/position pairs (`addu a0,zero,zero; addu s1,a0,zero` vs ours
  reversed; one `lui` of the languages template one slot earlier).

Everything else matches: the whole control-flow structure, every callee-saved assignment
(`s0`-`s6`), every stack displacement, every non-reloc immediate, and the instruction count.

Gate command:
```
VA_MAX=400 python regiondiff/tools/verify_region.py UK-ES-IT regiondiff/recon/NFS4-R-UK-ES-IT/frontend/psx/psxfront.cpp DoLanguageScreen__Fv --lane-as=recon/frontend/psx/psxfront.cpp
  DoLanguageScreen__Fv: FAIL 50 diffs (ours 193 / oracle 193) [NFS4-R-UK-ES-IT]
```
