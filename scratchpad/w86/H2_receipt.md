# W86-H2 receipt — the remaining regional near-misses (5 rows)

Agent H2, 2026-09-02. Gate (authoritative, every number below is a real run):

```
python regiondiff/tools/verify_region.py <REGION> <candidate> <fns> --lane-as=recon/<unit>.cpp
```

Full untruncated diffs read with the pre-existing read-only helper
`scratchpad/w84/rvdiff.py`. Variant sweeps driven by `scratchpad/w86/H2_try.py`
(private harness: applies edits to a pristine backup copy, gates, restores and
ASSERTS byte-identical restore). Backups: `scratchpad/w86/H2_bak/`.

Prohibitions honoured: no git ops; no `tools/*.py` or `regiondiff/tools/*.py`
edits; no base-tree (`recon/**`, `src/**`, `asm/**`, `configs/**`) edits; no
memory-dir edits; no boards/MANIFEST; no `register…asm("$N")` pins; no
`__asm__` and no `volatile` introduced anywhere; no existing candidate
overwritten (both files edited in place).

## Status board

| # | function | region | before | after |
|---|---|---|---|---|
| 1 | `SavePinkSlipsCars__Fss` | USA | FAIL 47 (237/236) | **FAIL 34 (238/236)** ✅ −13 |
| 2 | `LoadGame__FsbT1` | USA | FAIL 3 (387/388) | FAIL 3 — see §2 |
| 3 | `DrawCongratsMessage__23tScreenTournamentTrophy` | JPN | FAIL 4 (200/200) | FAIL 4 — see §3 |
| 4 | `FEInput_GetNoDebounceKey__Fii` | JPN | FAIL 4 (122/122) | FAIL 4 — mechanism closed, see §4 |
| 5 | `DrawForeground__14tScreenMemcard` | USA | FAIL 2 (67/67) | FAIL 2 — mechanism closed, see §5 |

Files WRITTEN: `regiondiff/recon/NFS4-R-USA/frontend/common/fememcard.cpp`
(row 1 only). `screenmemcard.cpp`, `feinput.cpp`, `screencongrats.cpp` are
byte-identical to their seeds (every experiment reverted; restore asserted).

---

## 🏆 HEADLINE — the 33A-1 inflator IS the loop.c `insn_count` unit W85-M4 declared impossible

W85-M4 §4 concluded: *"The pure-C requirement is therefore 'one RTL insn that
emits nothing', which no C construct supplies"* — because `do{}while(0)` and
friends emit only NOTEs and `loop.c:1640`'s `insn_count` counts INSN/JUMP/CALL.

**FALSE as of 33A-1.** The idempotent-op-with-a-VARIABLE-operand inflator
supplies exactly that unit, and it works in a C++ TU:

```c
x = x ^ y;      /* y any live variable; the pair is an exact identity */
x = x ^ y;
```

* `fold()` cannot remove it at tree level (variable operand), and cse's
  `simplify_binary_operation` has no XOR associativity, so **both insns are
  real RTL through cse1 → loop → cse2 → flow** (counted by `loop.c`'s
  `insn_count` AND by `flow.c:1969`'s `REG_N_REFS`).
* `combine` then cancels them — `combine.c:3303` "associative operation …
  (a & b) & a" path computes `simplify_binary_operation(XOR, y, y) = 0` and
  rewrites to `x` — so **ZERO bytes are emitted.**

Measured on `SavePinkSlipsCars__Fss` (USA), N = 2/4/6/8 XOR statements inserted
in the outer poll loop: **ours stayed 237 instructions at every N** while the
diff count moved 47 → 43 → 61 → 61 → 61. Byte-free, and a live dial.

⚠️ **The same inflator does NOT buy a surviving `REG_N_SETS`** (row 5, §5):
`combine` decrements `REG_N_SETS` when it cancels the pair (`combine.c:2421`),
and sched1 runs after combine — so an inflator aimed at `birthing_insn_p`
is free but inert. Refs/insn_count yes, sets no. New negative law.

---

## 1. `SavePinkSlipsCars__Fss` (USA) — 47 → 34

Candidate `regiondiff/recon/NFS4-R-USA/frontend/common/fememcard.cpp`.

```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/fememcard.cpp \
  SavePinkSlipsCars__Fss,LoadGame__FsbT1,SaveGame__Fs,Init_Memcard__FbT0,DeInit_Memcard__Fv,\
FormatConfirm__Fv,OverwriteConfirm__Fv,Confirm__Fii,Init_MemcardFile__FR12MCRDFILE_defsb \
  --lane-as=recon/frontend/common/fememcard.cpp
    SavePinkSlipsCars__Fss:              FAIL 34  (was 47)
    SaveGame__Fs / Init_Memcard__FbT0 / DeInit_Memcard__Fv:  REGION-PASS  (held)
    LoadGame__FsbT1:                     FAIL 3   (unchanged)
    FormatConfirm/OverwriteConfirm/Confirm/Init_MemcardFile: FAIL 4 (unchanged, other agents' B1 rows)
```

### 1a. The decisive edit — pass `player`, not `(short)(cardSlot >> 2)`

W85-M4's residual class "a 3-way rotation of the remaining handout" (player
`$s6`/const-0x15 `$s7` ours vs `$s7`/`$s6` retail) is **not a priority problem
at all — it is a conflict-set problem**, i.e. catalog **33B-1** again.

The oracle proves it directly: retail's `player` copy in `$s7` is made in the
PROLOGUE (`addu s7,s0,zero`, before `s0` is even sign-extended) and is still
live 110 instructions later at the inner call — `addu a2,s7,zero`. Ours died
right after the preheader, because W85-M4 spelled the inner call's player
argument `(short)(cardSlot >> 2)` (a reconstruction artifact that saved one
sign-extension). Passing `player` restores retail's live range, and the whole
prologue rotation disappears:

| variant | result |
|---|---|
| shipped W85-M4 state | FAIL 47 @237 |
| **pass `player` at the inner call** | **FAIL 38 @238** (prologue rotation GONE) |
| **+ the 33A-1 inflator ×2 after the outer `MCRD_handlecardevents`** | **FAIL 34 @238** ← LANDED |

### 1b. Inflator ladder (all count-exact at 237/238 — byte-free)

| variant | result |
|---|---|
| `memCardResult ^= cardSlot;` ×2 after the outer call (no `player` change) | FAIL **43** @237 |
| ×4 / ×6 / ×8, same site | FAIL 61 / 61 / 61 @237 |
| ×2 before the `switch` instead | FAIL 42 @238 (on the `player` base) |
| ×2 after the call **and** ×2 before the switch | FAIL 56 @238 |
| ×2 in the INNER loop (`event ^= cardSlot`) | FAIL 71 @237 |
| ×2 outer + ×2 inner | FAIL 67 @237 |
| ×2 on `cardSlot ^ memCardResult` instead (after the call) | FAIL 66 @**238** — not free (extends memCardResult) |
| ×2 on `memCardResult ^ cardNum` (short operand) | FAIL 38 @**238** — not free (sign-extension survives) |
| ×2 on `cardSlot ^ (int)player` in the preheader | FAIL 52 @238 |
| ×2 inside `case 0xf` after `ChecksumData` | FAIL 52 @238 |

**Rule learned:** the inflator is free ONLY when both operands are `int`-typed
live locals (a `short` operand leaves a real sign-extension behind) and the
inflated variable is still READ afterwards (a dead one is deleted by cse's
`delete_trivially_dead_insns` before `flow` ever counts it).

### 1c. Falsified this wave (each an independent compile + gate)

| angle | result |
|---|---|
| `int playerIdx = player;` + `cardSlot = playerIdx*4` + `(short)playerIdx` at the call + ×2 | FAIL 48 @238 |
| …same without the `do{}while(0)` | FAIL 48 @238 |
| …same passing `playerIdx` implicitly | FAIL 48 @238 |
| …same without the inflator | FAIL 52 @238 |
| `short playerIdx` variant | FAIL 49 @**239** |
| `cardSlot = cardNum + -1;` (algebraically exact) | FAIL **204** @238 — destroys the preheader |
| drop the `do{}while(0)` on the cardSlot statement | FAIL 46 @238 |
| extra `do{}while(0)` around a `cardSlot ^ 0` carrier | FAIL 34 @238 (inert — folds) |

### 1d. Residual 34 — four NAMED classes (ours 238 / oracle 236)

1. **SEXT-ONCE-SHARED.** Retail sign-extends `player` ONCE into its own
   register and reuses it: `sll v1,s7,16; sra s7,v1,16; sll s4,s7,2` … later
   `addu a2,s7,zero`. Ours extends TWICE — fused for the scale
   (`sll v0,s7,16; sra s4,v0,14`) and again for the argument
   (`sll a2,s7,16; sra a2,a2,16`). Same total count (4 vs 4), 4 diffs.
   Every `playerIdx` carrier spelling tried (1c) re-fuses or costs more; the
   next angle must make the *sign-extended* value the named pseudo without
   letting combine re-fuse it into the `sll …,14`.
2. **INNER-JUMP-TABLE-BASE LICM LEVEL.** Ours hoists `lui/addiu s6,<jtbl>` all
   the way to the OUTER loop's preheader; retail hoists it only to the inner
   loop's preheader (inside `case 0xf`). Count-neutral, ~4 diffs. This is a
   second-level `move_movables` verdict (`insn_count` is HALVED for an
   already-moved movable — 33A-2), so it needs ≈2× the inflator units the
   first-level verdict needs; ×4 reaches it but rotates other allocnos (61).
3. **OUTER SWITCH DISPATCH ORDER.** Retail materializes the table base BEFORE
   the index shift and keeps the switch operand alive in `v1`
   (`addiu v1,s0,-2 … lui v0; addiu v0; sll v1,v1,2; addu v1,v1,v0`); ours
   mutates `s0` and shifts first. The ×2 inflator already fixed the
   `addiu v1,s0,-2 / sltiu v0,v1,22` half of this.
4. **A DUPLICATED `j T; li s2,2` BLOCK (+2 insns) — pre-existing, in BOTH the
   old 237 state and the new 238 state.** Retail shares that
   `result = LoadFailed` tail between the inner `case 2/3/7/…` arm and the
   outer `case 2/0x10` arm; ours emits it twice. It is the whole count delta:
   the old 237 merely masked it with the (wrong) fused sign-extension of
   class 1, which is one instruction SHORTER than retail. i.e. **237 was
   accidental, not structural** — 238 is not a regression in kind. Fixing
   class 4 is the route to count-exact 236 and is the same cross-jump/CFG
   family as the w65-a1 role swap.

Also still present and unchanged from W85-M4: retail keeps the `PinkSlipsError_CardFull`
`li s2,6` in the status branch's DELAY SLOT (ours emits it before the `jal`) —
that was the effect of the `__asm__("")` the regional candidate correctly does
not carry.

---

## 2. `LoadGame__FsbT1` (USA) — FAIL 3, unchanged; the merge MECHANISM is now pinned

Ours is one instruction SHORT (387/388). The whole residual is a single
`li s1,1` (`finished = true`): retail keeps TWO copies of the card-status tail,
ours cross-jumps them into one.

### The oracle's real shape (read off `oracles/NFS4-R-USA/LoadGame__FsbT1.s`)

Retail has BOTH classification blocks in full — the read-failure arm at
`.L800352F4` and the `case 2/3/7/a/b/10/17` arm at `.L80035330` — with the
three little result blocks SHARED (block A's `beq`s jump into block B's
`.L8003535C` / `.L80035370`), and the tail
`.L80035380: li s1,1; j .L80035184` reached by a jump from A and by
fall-through from B. **Our build reproduces every one of those instructions**
(lines 225-258 of the aligned diff are byte-for-byte identical) except that our
tail's `li s1,1` was DELETED and the jump redirected to the SUCCESS arm's
identical tail (`jal SetPads` ... `j; li s1,1`).

### WHY ours merges and retail's does not — `jump.c` `find_cross_jump`

`jump_optimize`'s cross-jumping needs `minimum` (2) matching insns before the
two jumps. Both tails offer exactly ONE (`li s1,1`), and the second insn
back differs (ours: a `jal` CALL_INSN in the success arm vs an `li` in the
classification tail) — so the pair should NOT merge. It merges because of
**`jump.c:2563`**:

```c
      /* If we will get to this code by jumping, those jumps will be
         tensioned to go directly to the new label (before I2),
         so this cross-jumping won't cost extra.  So reduce the minimum.  */
      if (GET_CODE (i1) == CODE_LABEL)
        { --minimum; break; }
```

**A CODE_LABEL immediately preceding the matched insn in STREAM 1 is worth a
free `--minimum`.** Our `finish_card_event:` label sits directly in front of
`finished = true;`, so walking back from the tail's jump gives
`li s1,1` (2 to 1) then the label (1 to 0) → merge fires, stream 1 (the tail)
loses its `li s1,1`. The success arm's jump, processed FIRST in the forward
scan, has no label there, so IT never merges — which is why the surviving copy
is the success arm's and the classification tail's is the one deleted.

⇒ **the dial is "keep a CODE_LABEL off the instruction immediately before the
tail's `finished = true`", not "where `finished` is assigned"** (W85-M4's open
question). Every label-free spelling must still let block A reach the tail.

### Falsified this wave (each an independent gate)

| angle | result |
|---|---|
| read-failure arm rewritten as per-path `goto finish_card_event;` for the -2 and -1 exits, own `finished = true; break;` on the 0x32a exit | FAIL 3 @387 — **inert** (gcc rebuilds the identical CFG) |
| the same restructuring applied to the `case 2/3/7/...` arm instead | FAIL 12 @**384** — de-shares three more insns |
| both arms restructured | FAIL 12 @384 |

(plus W85-M4's two: plain `finished = true;` in the read-failure arm, with and
without `break;`, FAIL 15 @393.)

### Named next angle

Reach the tail from block A WITHOUT a label adjacent to the tail's
`finished = true` — e.g. a spelling in which block A's exit FALLS THROUGH into
the tail and block B's exit is the jumping one (swap which arm hosts
`finish_card_event:`), or one in which the tail's first insn is not the
`li s1,1`. Note a 33A-1 inflator cannot be used here: `combine` deletes the
pair long before `jump2` runs, so it is invisible to `find_cross_jump`.

---

## 3. `DrawCongratsMessage__23tScreenTournamentTrophy` (JPN) — FAIL 4, unchanged

Candidate byte-identical to its seed (`cmp` clean).

W85-M7 pinned this to `sched1`'s `rank_for_schedule` choosing the 2-insn
constant chain (`li 97; sh 26(sp)`) over the 3-insn load chain
(`lhu 24(sp); addiu -5; sh 24(sp)`) in the translucent-plate tail, which
decides whether `97` lands in `$v0` or `$v1`, and falsified 21 source variants.
Four more, all gated this wave:

| angle | result |
|---|---|
| `int nx; nx = r.x; nx = nx - 5; r.x = (short)nx;` (2-set carrier, aimed at `birthing_insn_p`) | FAIL **18** @200 |
| `int hh` carrier for `r.h` + a 33A-1 XOR-pair inflator on it | FAIL **36** @200 (inflator byte-free here too — count-exact) |
| `int py = 0x61; py |= r.h; r.y = (short)py;` (2-set constant carrier) | FAIL 6 @**202** |
| `int rx = r.x;` read hoisted above the height call | FAIL **20** @200 |

**Tooling blocker for the assigned PERMUTER route:** `tools/permute.py setup`
gates a candidate against `asm/nonmatchings/<seg>/<sym>.s` — the BASE oracle.
There is no regional lane (the regional oracle lives in
`regiondiff/oracles/<REGION>/`, and `verify_region.py` is the only thing that
reads it), so a permuter run on this row would optimise toward the WRONG
target. Wiring a regional scorer means editing `tools/*.py`, which this wave
prohibits. **This row needs a tooling decision from the orchestrator before any
permuter attempt**; multi-basin re-seeding by hand is still open (M7's 21 and
my 4 variants are all single-basin).

---

## 4. `FEInput_GetNoDebounceKey__Fii` (JPN) — FAIL 4, count-exact; mechanism CLOSED

Candidate byte-identical to its seed (`cmp` clean).

W85-M7 established the chain: `jump2`'s cross-jumping puts a CODE_LABEL in
front of the HIGH funnel's zero block, which kills `own_thread_p` and makes
`reorg` fill the `beqz` from the TARGET thread (`li v0,1`) instead of the
fall-through (`move v0,zero`). I read M7's own `-dJ` dump
(`scratchpad/w85/M7_rtl/feinput.i.jump2`) and can now name the whole thing:

* jump2 creates **three** labels in this function (422, 423, **424**). 424 sits
  before `(insn 232 (set (reg/i:SI 2 v0) (const_int 0)))` — the HIGH funnel's
  zero block — and it is the SURVIVOR of cross-jumping: `jump_insn 206` (the
  LOW funnel's zero block), `jump_insn 261` (the `default` arm's zero block)
  and even `jump_insn 32` (the early `nopad` return) were all redirected to it
  and had their own `v0 = 0` deleted. `jump_insn 337` (the `#` beq) points at
  424 too, which is what PINS the label: reorg's copy-back restores every
  deleted `v0 = 0` (so the final size is unchanged) but cannot remove a label
  the `#` branch still uses.
* The direction is **structurally forced, not a tie-break.** `do_cross_jump`
  always deletes the insns before `insn` (the jump reached FIRST in
  `jump_optimize`'s forward scan) and gives the label to the partner's stream.
  Our LOW funnel's zero block is necessarily the first of the identical group,
  because case `0x10000000`'s body must FALL THROUGH into the low funnel and
  case `0x40000000`'s into the high one (the oracle lays the case bodies out in
  source order — verified against every `analogs[]` offset). And, exactly as in
  row 2, our `return_zero:` label supplies the `jump.c:2563` `--minimum` bonus
  that lets a ONE-insn match merge at all.

### Falsified this wave (on top of M7's list)

| angle | result |
|---|---|
| `default:` arm's `return 0;` becomes `goto return_zero;` | FAIL 4 @122 — **inert** |
| HIGH funnel's `return 0;` becomes `goto return_zero;` | FAIL 7 @**119** |
| BOTH become `goto return_zero;` | FAIL 5 @**119** |

### Named next angle

The merge fires only because `return_zero:` is adjacent to the LOW block's
`v0 = 0`. Any spelling that keeps the `#` arm's label OFF that instruction —
without paying M7's +2-insn trailing block — kills it: the walk then hits the
LOW funnel's conditional `bnez` (a JUMP_INSN whose pattern cannot match the
HIGH funnel's `beqz`), `minimum` stays 1, and no cross-jump happens, leaving
the HIGH block label-free and own-thread. The three "move the label elsewhere"
spellings are all falsified (M7: HIGH 7@119, DEFAULT 11@119; mine above), so
the remaining freedom is in what the `#` arm branches to.

---

## 5. `DrawForeground__14tScreenMemcard` (USA) — FAIL 2, count-exact; mechanism CLOSED
### ...and a NEW NEGATIVE LAW about the 33A-1 inflator

Candidate byte-identical to its seed (`cmp` clean).

W85-M6 pinned the residual to `sched.c`'s `adjust_priority` to
`birthing_insn_p`: the entry-block copy `addu a1,v0,zero` (dest `fadeRaw`,
`REG_N_SETS == 1`, live) is bumped to LAUNCH_PRIORITY and the backward list
scheduler therefore places it at the LATER slot, after `addiu a0,v0,-128`;
retail has it first. M6 shipped the minimal-device form and recorded that
"every spelling of a second set costs at least the 2 diffs it buys".

### PROVEN this wave: un-bumping DOES fix the order

Reproducing M6's copy-first RTL (a `doubled` temp plus the `doubled = 0;` cse
blocker) and adding an explicit second set of `fadeRaw`
(`fadeRaw = (short)fadeRaw;` folded into the guard) gives:

```
  FAIL 6 diffs (ours 67 / oracle 67)
      - addiu a0,a1,-128     + addiu a0,v0,-128
      - sra a1,v0,16         + sra v0,v0,16
      - slti v0,a1,100       + slti v0,v0,100
```

**The two order diffs are GONE** — `REG_N_SETS(fadeRaw) == 2` removes the bump,
the two insns tie at priority 2 and `rank_for_schedule`'s `INSN_LUID` tie-break
keeps retail's (copy-first) source order. The residual 6 is the PRICE: the
sign-extend now writes `fadeRaw`'s callee-live register `$a1` where retail uses
a throw-away `$v0`, and cse re-anchors the `addiu`'s operand. So the mechanism
is settled and the requirement is exact: **a second set of `fadeRaw` that
survives to `flow` and emits nothing.**

### NEW NEGATIVE LAW — the 33A-1 inflator CANNOT supply a `REG_N_SETS`

`fadeRaw = fadeRaw ^ (int)this;` twice, on the copy-first base:
**FAIL 2, count-exact 67/67 — free, and completely inert.** The order diffs are
unchanged. Reason: `combine` cancels the pair *and decrements the counter*
(`combine.c:2421` `REG_N_SETS (regno)--`), and `sched1` runs AFTER `combine`.

⇒ **The inflator buys `REG_N_REFS` and `loop.c` `insn_count` (both computed
before combine) but NEVER a `REG_N_SETS` seen by sched1.** Anything aimed at
`birthing_insn_p` needs a set that combine does not cancel — i.e. one that
hijacks an instruction the oracle already has.

### Full ladder measured this wave

| variant | result |
|---|---|
| shipped seed | FAIL 2 @67 |
| `fadeRaw = (short)fadeRaw;` before the guard (seed order) | FAIL 6 @67 |
| M6's copy-first `doubled` plus `doubled = 0;` blocker | FAIL 2 @67 (RTL = retail's) |
| ...plus `fadeRaw = (short)fadeRaw;` | FAIL 6 @67 — **order fixed**, sext register costs 4 |
| ...copy-first without the blocker | FAIL 5 @66 |
| `fadeRaw = (int)(ushort)fld; doubled = fadeRaw*2; fadeRaw = doubled;` (M6's rejected-by-inspection live 2nd set) | FAIL 7 @66 — measured, confirms the rejection |
| ...that plus the sext set | FAIL 23 @66 |
| `short fadeRaw` | FAIL 2 @67 (inert) |
| copy-first with addiu-first statement order | FAIL 2 @67 |
| separate 1-set `bias` carrier for the -0x80 (to bump the addiu too), copy-first and addiu-first | FAIL 2 @67 both (cse deletes the `fade = bias` copy) |
| clamp arms writing `fadeArg` so `fade` has ONE set | FAIL 16 @67 (destroys the `addu s1,a0,zero` copy) |
| **copy-first plus XOR-pair inflator on `fadeRaw`** | **FAIL 2 @67 — free but INERT (the law above)** |

### Named next angle

Find an instruction the oracle ALREADY emits whose destination can legitimately
be `fadeRaw` (giving it a second, combine-proof set) — the guard's own
sign-extend is the only candidate in this block and it costs 4 because retail
puts that value in `$v0`. Otherwise the row is a `no_schedule_insns`-lane
question, exactly as M6 concluded.

---

## Files touched

```
regiondiff/recon/NFS4-R-USA/frontend/common/fememcard.cpp   (row 1: 47 -> 34)
scratchpad/w86/H2_receipt.md                                 (this file)
scratchpad/w86/H2_try.py, H2_v_*.json, H2_bak/               (private scratch)
```

Nothing else was written. `tools/**`, `regiondiff/tools/**`, `recon/**`,
`src/**`, `asm/**`, `configs/**`, MANIFEST/PROGRESS boards and the memory dir
were not opened for writing. `update_region_progress.py` NOT run (wave rule).
No git operations. The other three candidates were verified byte-identical to
their seeds with `cmp` after every sweep.

## Catalog candidates (for the consolidator)

1. **33A-1 EXTENDS TO `loop.c` `insn_count` — and that RETIRES W85-M4's
   "irreplaceable fence" verdict.** The idempotent-op-with-a-variable-operand
   inflator is real RTL from expand through `cse1 -> loop -> cse2 -> flow`, so
   it feeds BOTH `flow.c:1969`'s `REG_N_REFS` and `loop.c:1640`'s
   `threshold*savings*life >= insn_count` budget, and `combine`'s associativity
   path (`combine.c:3303`) cancels it for zero bytes. Preconditions measured:
   both operands `int`-typed live locals (a `short` operand leaves a real
   sign-extension), and the inflated variable must be READ afterwards (a dead
   one is deleted by cse's `delete_trivially_dead_insns` before flow counts it).
   XOR is the safest operator — it is an identity for ANY second operand and
   cse has no XOR associativity, so it cannot be folded early.
   [SavePinkSlipsCars__Fss USA: dial 47 to 43 count-exact; 38 to 34 with the
   fidelity fix. Confirmed byte-free at N = 2,4,6,8 and in two other TUs.]
2. **...BUT NOT `REG_N_SETS` (new negative).** `combine` decrements
   `REG_N_SETS` when it cancels the pair and `sched1` runs after `combine`, so
   an inflator aimed at `birthing_insn_p` is free and inert.
   [DrawForeground__14tScreenMemcard USA.]
3. **`jump.c:2563` — A LABEL IN STREAM 1 IS A FREE `--minimum` FOR
   CROSS-JUMPING.** A one-insn common tail normally cannot be cross-jumped
   (`minimum` = 2), but a CODE_LABEL immediately preceding it grants the
   missing unit and the merge fires — deleting the LABELLED copy, not the other
   one, and moving the label to the survivor. This single rule explains BOTH
   surviving 1-insn-tail rows: LoadGame's lost `finished = true`
   (`finish_card_event:`) and GetNoDebounceKey's misplaced delay-slot fill
   (`return_zero:` -> jump2 label 424 -> `own_thread_p` fails). When a diff is
   "retail duplicates a tail we share", look for YOUR `goto` label sitting on
   the first instruction of that tail before looking at anything else.
4. **`do_cross_jump` direction is the FORWARD SCAN, not a heuristic.** The jump
   reached first by `jump_optimize`'s forward walk is the one whose insns are
   deleted; the partner survives and receives the label. Combined with (3),
   which of two identical blocks loses is fully determined by source layout —
   and a shared tail that must FALL THROUGH from one arm fixes that layout.
5. **33B-1 (variable reuse) again, from the other side.** SavePinkSlipsCars'
   `$s6`/`$s7` rotation was not an allocno-priority problem: retail keeps
   `player` live 110 instructions to the inner call (`addu a2,s7,zero`), and
   simply passing `player` there instead of a value recovered from `cardSlot`
   buys the conflict set outright. A recon spelling that "saves an instruction"
   by recomputing a value is a live-range LIE and shows up as a rotation.
