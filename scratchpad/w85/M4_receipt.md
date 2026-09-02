# W85 M4 receipt — recon/frontend/common/fememcard.cpp (base) + its USA regional rows

Agent M4, 2026-09-02. Gates:
* base     `python tools/verify_asm.py recon/frontend/common/fememcard.cpp <fn>` / `python tools/tugate.py recon/frontend/common/fememcard.cpp`
* regional `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/fememcard.cpp <fn> --lane-as=recon/frontend/common/fememcard.cpp`

Diagnostics used: `tools/rtl_dump.py` (+ `-dL`) and `tools/prio.py` (gcc-2.8 global.c
allocno priority `floor_log2(refs)*refs/live_length`), `tools/vdiff.py`, `tools/sbs.py`,
`tools/tugate.py`, `tools/symblk.py`, and gcc-2.8.1 sources (`C:/Temp/gcc-2.8.1-src/extracted/`:
`flow.c:1969` `REG_N_REFS += loop_depth`, `loop.c:1640` the LICM budget).

---

## 0. HEADLINE

| tree | before | after |
|---|---|---|
| base TU (18 fns) | **18/18 PASS**, 4 devices | **18/18 PASS**, 1 device (justified) |
| USA `SavePinkSlipsCars__Fss` | FAIL 88 @236/236 | **FAIL 47 @237/236** (frame + LICM-spill class SOLVED) |
| USA `LoadGame__FsbT1` | FAIL 3 @387/388 | FAIL 3 (unchanged; 2 more angles falsified) |
| USA `DeInit_Memcard` / `Init_Memcard` / `SaveGame` | REGION-PASS | **REGION-PASS** (held through the device removal) |
| USA candidate devices | 3 (`asm`, `asm`, `volatile`-cast) | **0** |

---

## 1. BASE — gate state ON ENTRY

```
python tools/tugate.py recon/frontend/common/fememcard.cpp
  recon/frontend/common/fememcard.cpp: 18/18 PASS
```

18 oracle-known fns, all PASS: BringThatBeatBack__Fv, ChecksumData__FP12tMemCardData,
Confirm__Fii, DeInit_Memcard__Fv, FormatConfirm__Fv, Init_MemcardFile__FR12MCRDFILE_defsb,
Init_Memcard__FbT0, LoadGame__FsbT1, LoadingProc__Fv, LoadingRedrawProc__Fv,
MakeWayForMemoryCard__Fv, OverwriteAlwaysYes__Fv, OverwriteConfirm__Fv, SaveGame__Fs,
SavePinkSlipsCarsWithErrorDialogs__Fsss, SavePinkSlipsCars__Fss, SavingProc__Fv,
VerifySuccessfulRead__FP12tMemCardData.

### Device census on entry

| # | site | device | verdict |
|---|---|---|---|
| D1 | `Init_Memcard`: `*(void (** volatile)(void))&mcrdopts.SavingDataProc = SavingProc;` | `volatile` cast on PLAIN stack state | **CLEARED** |
| D2 | `SaveGame`: `__asm__("" : : "r"(player));` before `purgememadr` | operand read fence | **CLEARED** (re-cracked source-only) |
| D3 | `SavePinkSlipsCars`: `__asm__("");` after `MCRD_getcard` | operand-free sched/CSE boundary | **KEPT** (iron rule; full ladder in §4) |
| D4 | file top: `extern volatile int ticks_vol asm("ticks");` | dead (zero uses) volatile decl | **CLEARED** (deleted) |
| K1 | `extern volatile int ticks_arr[] asm("ticks");` | volatile on the IRQ-written `ticks` counter; two busy-wait loops in Init/DeInit_Memcard poll it | **KEEP** — IRQ-shared state, guide-sanctioned. Without it gcc hoists the load and the wait loops become infinite (a real bug, already documented in-source) |
| K2 | the `extern … asm("name")` true-type redeclarations (`Stats_gTrackRecords`, the word-BOOL views, the 4-arg `SavePinkSlipsCars` decl) | asm **symbol labels** — they only spell a link name for a correctly-typed declaration | **KEEP** — not in the wave's CLEAR list: no asm text, no register pin, no post-compile move |

No `register T x asm("$N")` pins and no `&&label` devices exist in this TU (verified by grep).

---

## 2. D1 — Init_Memcard volatile cast: REMOVED, clean

`*(void (** volatile)(void))&mcrdopts.SavingDataProc = SavingProc;` → `mcrdopts.SavingDataProc = SavingProc;`

```
python tools/verify_asm.py recon/frontend/common/fememcard.cpp Init_Memcard__FbT0
  Init_Memcard__FbT0: PASS (87 insns)
```
Pure crutch — PASS holds with the plain store (the guide's "remove it, gate" test).

---

## 3. D2 — SaveGame read fence: REMOVED and re-cracked source-only

Removal alone: **FAIL 26, count-exact 292/292** — a pure 3-cycle rotation of the tail
allocnos: ours `{shapeFile=s5, player=s6, returnvalue=s7}` vs retail
`{player=s5, returnvalue=s6, shapeFile=s7}` (retail's map is confirmed by the SYM:
`REGPARM player $21 s5`, `REG returnvalue $22 s6`, `REG shapeFile $23 s7`).

### Diagnosis — the cluster is 0.3 % wide

`tools/prio.py` on the `-dg/-dl` dump (gcc-2.8 global.c priority `floor_log2(refs)*refs/live`):

| pseudo | role | no fence | with fence |
|---|---|---|---|
| p120 | shapeFile | refs 3, live 64 → **0.046875** (1st → s5) | 3/65 = 0.046154 (3rd → s7) |
| p123 | returnvalue | refs 4, live 171 → **0.046784** (3rd → s7) | 8/172 = 0.046512 (2nd → s6) |
| p80 | player | refs 5, live 214 → **0.046729** (2nd → s6) | 12/215 = 0.055814 (1st → s5) |

The fence worked by (a) giving `player` a 6th reference and (b) adding one insn to the
other two live ranges. The pair test is arithmetic: `p123 > p120 ⟺ 8·live120 > 3·live123`,
i.e. `512 > 513` — **false by one**.

### The shipped replacement: two degenerate scopes, ZERO emitted instructions

`flow.c:1969` — `REG_N_REFS (regno) += loop_depth` — so a `do{}while(0)` adds +1 per
reference inside it (catalog **32B-1 / 30A-2**), and its notes are not insns, so live
lengths and the instruction stream are untouched:

* **OUTER** scope over the epilogue block **including `return returnvalue;`** → returnvalue
  refs 4→5 (10/171 = 0.0585, now above shapeFile's 0.0469).
* **INNER** scope over the `if (nomessage_arr[0] == 0)` body (which holds the
  `returnmessage + player` reference) → player refs 5→7 (14/214 = 0.0654, back on top).

```
python tools/verify_asm.py recon/frontend/common/fememcard.cpp SaveGame__Fs
  SaveGame__Fs: PASS (292 insns)
```

### Measured ladder (each an independent compile + gate)

| variant | result |
|---|---|
| fence removed, nothing added | FAIL 26 @292/292 |
| `do{}while(0)` around `CURRENTPLAYER[0] = player;` | FAIL 84 @292 — **dead dial**: the statement is in the ENTRY block (catalog 28E-3); player refs stay 5, other allocnos perturbed |
| `do{}while(0)` around `cardNum = player * 4 + 1;` | FAIL 86 @**288** — costs 4 insns |
| `do{}while(0)` around `status = MCRD_getcard(player*4+1)->status;` | FAIL 54 @292 — `player*4` is LICM-hoisted OUT of the scope, so player refs stay 5 |
| `do{}while(0)` around `message = TextSys_Word(returnmessage + player);` alone | FAIL 25 @**295** — the wrapper is not free at that granularity (+3 insns) |
| INNER scope only | FAIL 12 @292 — player fixed to s5; the returnvalue/shapeFile pair still swapped, exactly as `512 < 513` predicts |
| **INNER + OUTER (shipped)** | **PASS 292/292** |

---

## 4. D3 — SavePinkSlipsCars `__asm__("")`: NOT recoverable source-only → RESTORED (iron rule)

Removal: **FAIL 92, ours 228 / oracle 226**, and the frame grows 5736 → **5744**.

### What the device actually does (proved, not guessed)

`-dL` (`tools/rtl_dump.py … -dL`) on both variants, inner loop of `SavePinkSlipsCars`:

```
no fence : Loop from 364 to 545: 56 real insns.   Insn 466: regno 164 (life 2), savings 2  moved
with fence: Loop from 364 to 547: 57 real insns.  Insn 466: regno 164 (life 2), savings 2 not desirable
```

Same movable, same `life`, same `savings` — only `insn_count` differs by ONE. `loop.c:1640`
moves iff `threshold * savings * life >= insn_count`; five movables are taken before it, so
`threshold = (loop_has_call ? 1 : 2) * (1 + n_non_fixed_regs) - 5*3 = 29 - 15 = 14`, and
`14 * 2 * 2 = 56`. **56 ≥ 56 moves; 56 ≥ 57 does not.** The fence's only contribution is
+1 RTL insn inside that loop (it emits no bytes), which flips that one marginal LICM verdict
on the `&frontEnd + player*4` address chain. Hoisting it costs a preheader spill
(`sw … 5696(sp)`) + reload, hence the +8 frame and the whole 92-diff cascade.

**The pure-C requirement is therefore "one RTL insn that emits nothing", which no C construct
supplies**: `do{}while(0)` and friends emit NOTEs, and loop.c's `insn_count` counts only
INSN/JUMP_INSN/CALL_INSN.

### Falsified replacements (each measured)

| angle | result |
|---|---|
| `do{}while(0)` LICM shield around the nocheat comparison (catalog 32B-1) | FAIL 105 @225 |
| operand order swap `memCardData.pinkSlipsNoCheat != frontEnd.gPinkSlipsNoCheat[player]` | FAIL 93 @227 |
| `frontEnd.gPinkSlipsNoCheat[(int)player]` | FAIL 92 @228 (inert) |
| `int noCheat = …;` split statement | FAIL 97 @227 |
| index-first cast `*(int *)((player << 2) + (int)&frontEnd + 1084)` | FAIL 48 @224 — hoist+spill GONE, frame back to 5736; residual = the `+1084` folds into the LO16 addend so the load displacement is 0 instead of 1084 |
| **struct-cast view** `((tfrontEnd *)((player << 2) + (int)&frontEnd))->gPinkSlipsNoCheat[0]` (and the `(int)&frontEnd +` / `player * 4` spellings) | **FAIL 46 @224** — best; displacement 1084 restored |
| struct-cast view + `do{}while(0)` around the comparison | FAIL 47 @223 |
| struct-cast view with the compare operands swapped | FAIL 50 @224 |

The best source-only form is still **2 instructions short**: with the address chain no longer
hoisted, gcc additionally lifts `player << 2` into the preheader (`sll s4,s7,2`) where retail
recomputes `sll v0,s4,2` at the use, and the {player, shapeFile} pair rotates `fp`↔`s7`.
No dial found for that second hoist within budget.

**Verdict: RESTORED VERBATIM**, with an in-source KEEP note recording the mechanism, the
numbers, and the pointer to this receipt. Base TU is back to 18/18 PASS.

🔑 **The removal is not wasted — it IS the regional body.** The no-fence base build produces
*exactly* the retail-USA shape (`sw v0,5696(sp)` in the preheader, `lw t0,5696(sp); lw v1,1084(t0)`
at the use, frame 5744). That observation drove §6.

---

## 5. BASE — final state

```
python tools/tugate.py recon/frontend/common/fememcard.cpp
  recon/frontend/common/fememcard.cpp: 18/18 PASS
```
Devices: **4 → 1**. The survivor (D3) is documented in-source with its mechanism and ladder.
No PASS was left broken; no post-compile moves; no `tools/**` edits.

---

## 6. REGIONAL — `regiondiff/recon/NFS4-R-USA/frontend/common/fememcard.cpp`

### Entry gate (2026-09-02, before any edit)

```
  DeInit_Memcard__Fv:     REGION-PASS (42 insns)
  Init_Memcard__FbT0:     REGION-PASS (89 insns)
  LoadGame__FsbT1:        FAIL 3  (ours 387 / oracle 388)
  SaveGame__Fs:           REGION-PASS (298 insns)      <- W84's "oracle-corpus defect" row is GREEN now
  SavePinkSlipsCars__Fss: FAIL 88 (ours 236 / oracle 236)
```

### Exit gate

```
  DeInit_Memcard__Fv:     REGION-PASS (42 insns)
  Init_Memcard__FbT0:     REGION-PASS (89 insns)
  LoadGame__FsbT1:        FAIL 3  (ours 387 / oracle 388)
  SaveGame__Fs:           REGION-PASS (298 insns)
  SavePinkSlipsCars__Fss: FAIL 47 (ours 237 / oracle 236)
```

### 6a. Devices cleared in the regional candidate (all three), PASS held

The candidate was a copy of the pre-W85 base TU, so it carried D1, D2 and D3. All three are
gone: D1 → plain store; D2 → the §3 two-scope replacement (SaveGame stayed **REGION-PASS**);
D3 → simply deleted (the regional oracle WANTS the hoist the fence suppresses). The candidate
now contains **no `__asm__` and no non-MMIO `volatile`**; only the sanctioned
`extern volatile int ticks_arr[] asm("ticks")` remains.

### 6b. `SavePinkSlipsCars__Fss` 88 → 47 — the LICM-hoist-and-SPILL class is solved

W84-R15 left this as "retail LICM-hoists `&frontEnd + player*4` out of the poll loop and
SPILLS it … no legal lever without an `__asm__("")` LICM fence". Three source-only edits, in
the order they were measured:

1. **Delete the inherited `__asm__("")`** → FAIL 90 @236. NOT sufficient on its own: the five
   added regional nullsub calls change `insn_count`, so loop.c declines the hoist here too.
2. **Pointer-ARRAY local + struct-cast view** (methodology §3.25-3d(b): *"a POINTER ARRAY local
   is memory by construction → forces per-iteration reloads from the frame like retail"*):
   ```c
   tfrontEnd *fePlayer[1];                 /* declared AFTER cardNum -> slot above cardNum's */
   …
   fePlayer[0] = (tfrontEnd *)((char *)&frontEnd + cardSlot);   /* preheader */
   …
   if (fePlayer[0]->gPinkSlipsNoCheat[0] != memCardData.pinkSlipsNoCheat)
   ```
   This reproduces retail's preheader store **and** the per-use reload with no device, and the
   frame goes 5744 → **5736 = retail**. The struct-cast keeps the base at offset 0 with 0x43C
   in the load displacement, so it is NOT the magic-offset anti-pattern R15 (correctly) rejected.
   Declaration POSITION is load-bearing: declared before `cardNum` the two frame slots swap
   (5688/5696) → FAIL 58; declared after `cardNum` → FAIL 50.
3. **`do{}while(0)` ref dial on the preheader statement** `do { cardSlot = player * 4; } while (0);`
   → FAIL 47. Allocno evidence (`tools/prio.py`): player `p80` refs 2→3 lifts it from
   0.0455 to 0.0682, past shapeFile `p89` (8/151 = 0.0530) — giving retail's **shapeFile = `$fp`**.

Also measured on the way (each an independent gate):

| angle | result |
|---|---|
| plain pointer local `tfrontEnd *fePlayer = …` (register, not memory) | FAIL 50 @238 |
| `int playerIndex = player;` sext carrier feeding `cardSlot` | FAIL 50 @238 (inert — gcc re-fuses sext+scale into `sra …,14`) |
| …+ passing `playerIndex` to the inner `SavePinkSlipsCars` call | FAIL 52 @238 |
| `cardSlot = playerIndex << 2` + `playerIndex * 4` in the address | FAIL 52 @238 |
| **passing `(short)(cardSlot >> 2)` as the inner call's player arg** | **FAIL 49 @237** (kept — it removes one of the two duplicate sign-extensions) |
| `do{}while(0)` spanning `cardSlot` **and** the `fePlayer[0]` store | FAIL 98 @234 |
| `do{}while(0)` around the inner `while (… == 0x15)` wait loop (to lift the 0x15 constant carrier over player) | FAIL 49 @237 |
| `do{}while(0)` around the FIRST `while (… == 0x15)` wait loop | FAIL 137 @235 |

**RESIDUAL 47, two named classes** (ours 237 / oracle 236):
* **one preheader insn**: retail sign-extends `player` in place (`sll v1,s7,16; sra s7,v1,16; sll s4,s7,2`)
  and reuses it; ours fuses sext+scale (`sll v0,fp,16; sra s4,v0,14`), so the second sign-extension
  is paid at the call site instead. This is a LICM verdict on the sext (one in-loop use, savings 1).
* **a 3-way rotation of the remaining handout**: allocno table says player `p80` = 0.0682 (→ `$s6`),
  the `0x15` constant carrier `p119` = 0.0577 (→ `$s7`), shapeFile `p89` = 0.0530 (→ `$fp`); retail
  wants `0x15`→`$s6`, player→`$s7`, shapeFile→`$fp`. The arithmetic target is explicit: either
  `p119` refs 3→4 (8/52 = 0.154) or `p80` live 44 → 53…56. Two dials aimed at `p119` were inert
  (rows above); the next agent has the exact numbers to aim at.

### 6c. `LoadGame__FsbT1` — still FAIL 3, two more angles falsified

Diff is exactly `li s2,810` realigned by one plus an extra oracle `li s1,1`: retail keeps TWO
copies of the `finished = true` tail where gcc cross-jumps ours into one (R15's class,
confirmed). New falsifications this wave:

| angle | result |
|---|---|
| read-failure arm ends with its own `finished = true;` (replacing `goto finish_card_event;`) | FAIL 15 @**393** — de-merges the WHOLE status block (+6), not just the 1-insn tail |
| same, with an explicit `break;` after it | FAIL 15 @393 (identical) |

Class confirmed: gcc's `cross_jump` merges *common suffixes*, so the two textually identical
status blocks are either fully shared (ours, −1 insn) or fully duplicated (+6). Retail's stream
has ONE copy of the block and TWO of the 1-insn tail, which suffix-merging cannot produce from
this source shape — the next angle has to change what the two blocks' suffixes ARE, not where
`finished` is assigned.

---

## 7. Files touched (nothing outside these)

```
recon/frontend/common/fememcard.cpp                              (base: D1/D2/D4 cleared, D3 kept+documented)
regiondiff/recon/NFS4-R-USA/frontend/common/fememcard.cpp        (regional: 3 devices cleared, SPSC 88->47)
scratchpad/w85/M4_receipt.md                                     (this file)
scratchpad/w85/m4/                                               (baselines + try.py driver, scratch only)
```

No git operations. No edits to `tools/**`, `regiondiff/tools/**`, MANIFEST/PROGRESS boards,
configs, asm, src, memory dir. `update_region_progress.py` NOT run (per the wave guide).
`recon/syslib/psx/libgpu/FONT.c` and `recon/syslib/psx/libmcrd/LIBMCRD.c` were never opened.
The `femenudefs__region_gate_*.cpp` temp file seen in `recon/frontend/common/` belongs to
another agent's gate run and was left untouched.

## 8. Catalog candidates (for the consolidator)

* **32B-2 (new) | `do{}while(0)` AS A GLOBAL-ALLOC PRIORITY DIAL FOR A SUB-1 % ALLOCNO CLUSTER.**
  When three tail allocnos sit within 0.3 % of each other, the winner is decided by
  `floor_log2(refs)*refs/live`; a scope whose span contains ONE reference of the loser buys it
  `+1 ref` at zero bytes, and `floor_log2` makes the 5→6 step worth +20 %. Nesting a second
  scope over the epilogue **including the `return` statement** is how you buy the second-place
  allocno its own step without touching the first. (SaveGame__Fs, fence → PASS 292/292.)
  Companion negative: the dial is DEAD in the entry block (28E-3 re-confirmed) and NOT free at
  single-statement granularity around a call (+3 insns measured).
* **32B-3 (new) | AN OPERAND-FREE `__asm__("")` INSIDE A LOOP IS A `loop.c` `insn_count` DIAL,
  AND THAT MAKES IT IRREPLACEABLE IN C.** `loop.c:1640` counts INSN/JUMP/CALL only, so the
  fence's +1 RTL insn (zero bytes) flips a marginal `threshold*savings*life >= insn_count`
  verdict that no NOTE-only construct can reach. DIAGNOSTIC: `-dL` on both variants — same
  movable, same `life`, same `savings`, `insn_count` differing by one, verdict flipping, is the
  signature. Before filing such a fence as removable, check whether its whole effect is the
  count. (SavePinkSlipsCars__Fss, KEPT.)
* **32B-4 (new) | THE POINTER-ARRAY LOCAL IS THE SOURCE-LEVEL SPELLING OF A RETAIL LICM
  HOIST-AND-SPILL.** When the oracle hoists an address into the preheader and *spills* it
  (`sw` there, `lw`+reload at the use, +1 frame slot), an explicit pointer local gets a
  REGISTER instead; `T *p[1]` is memory by construction and reproduces both halves. Its frame
  slot follows DECLARATION ORDER, so position it against a neighbouring local whose slot the
  oracle fixes. Pair it with the struct-cast view `((T *)((idx<<k) + (int)&G))->field` to keep
  the member offset in the load displacement instead of folding it into the LO16 addend.
  (USA SavePinkSlipsCars__Fss, 88 → 47.)
