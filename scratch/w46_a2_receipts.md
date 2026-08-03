# WAVE-46 a2 RECEIPTS — memcard.c / `MCRD_handlecardevents`

**RESULT: SEALED. 2 diffs -> PASS (211/211). memcard TU = 20/20 PASS (the whole
`memcard.obj` oracle set).** Branch `w46-a2`, commit `6f2e8e6e`.

Re-gated baseline at `6a43ac79` (worklist numbers confirmed for once):
19 PASS + `MCRD_handlecardevents` FAIL 2, count-exact 211/211.

---

## 1. THE DEFECT, CORRECTLY DIAGNOSED

w45 parked this as *"ONE sched2 READY-LIST TIE from PASS ... the two independent
stores' emission order"*. **That diagnosis was wrong, and the correction is the
transferable part of this receipt.**

The `res==1` arm ends in two stores:

```
sw a1,0x34(a0)      gMemCardInfo.bReady        = cmd        (base + const offset)
sw v1,0x40(v0)      gMemCardInfo.existencecheckticks[card-1] = timerhz
```

They **MAY-ALIAS** (same symbol, one of them at a variable index), so
`sched_analyze` chains them: *emission order == RTL order == SOURCE order,
unconditionally.* There is no ready-list tie to win and no permuter job here.
Proof, measured this wave (8 spanning-wrapper spellings x 2 source orders):
every tick-first spelling emits `sw v1` first; every bReady-first spelling emits
`sw a1` first. The w45 "two spellings sit 1 tie-break away on opposite sides"
observation was really **one defect seen from two sides** — one spelling had the
ORDER right and the POSITION wrong, the other the POSITION right and the ORDER
wrong.

The actual position defect was **self-inflicted by the w45 ref dial**:

* `gcc-2.8 sched.c:2085` — *"If there is a {LOOP,EHREGION}_{BEG,END} note in the
  middle of a basic block ... no instructions are scheduled across it"* — the
  first real insn after a loop note gets `add_dependence` on **every** insn
  before it. A full barrier.
* w45's `do { tick; } while (0)` sat **between** the bReady store and the tick
  store's address chain, so the barrier pinned the whole index chain + the
  timerhz load *after* `sw a1`. Retail has them *before* it.

## 2. THE SEAL — three cooperating pieces

```c
status = 2;
{ int idx = card + -1;
  fMemCardInfo_def *g = (fMemCardInfo_def *)((char *)&gMemCardInfo + idx * 4);
  int t = timerhz;
gMemCardInfo.bReady = cmd;
  do { do {
  g->existencecheckticks[0] = t;
  } while (0); } while (0);
pCI->status = -1;
}
```

1. **bReady-first source order** — mandatory, per §1 (not a choice).
2. **Depth-2 `do{}while(0)` kept** — the QTY ref dial still has to fire. The two
   block-local quantities fight for the low register under
   `local-alloc.c QTY_CMP_PRI = floor_log2(refs)*refs*size/(death-birth)`:
   * base qty is the **COMBINED** `{high, lo_sum}` pair — `local-alloc.c:1444`
     `combine_regs` ties them because the `high` pseudo REG_DEADs in the `lo_sum`
     insn, and `local-alloc.c:1973` **sums** the refs: 2 + 3 = **5 refs**.
   * timerhz value = **2 refs**.
   * `flr2(5)*5 = 10` vs `flr2(2)*2 = 2` -> base wins, takes `$v1`, timerhz is
     pushed to `$a0`. Retail is `$a0` base / `$v1` timerhz.
   * Doubling timerhz's refs crosses the `floor_log2` step at 4 (`flr2` 1->2,
     `2*4 = 8`) and inverts the pair. **Depth 0/1 = 14 diffs; depth 2, 3 and 4
     all seal.**
3. **Hoist the store's ADDRESS and VALUE out of the wrapper** so the note's only
   possible barrier insn is the tick store itself (which is last in retail
   anyway).
   * `int t = timerhz;` — without it: 212 insns, 19 diffs.
   * `g` hoists the `addu`. **`g` must NOT carry the field offset**: the natural
     `int *slot = &gMemCardInfo.existencecheckticks[idx];` lets `fold`
     reassociate `base + 0x40 + idx*4` and re-base BOTH stores off `base+0x40`
     (`addiu a0,a0,64` + `sw a1,-12(a0)` + `sw v1,0(v0)`; **4 diffs, count still
     exact 211**). The struct-cast view keeps the pointer at `base + idx*4`
     (= retail's `$v0`) and leaves `0x34`/`0x40` in the two store displacements.
     `g->existencecheckticks[0]` **IS** `gMemCardInfo.existencecheckticks[card-1]`
     byte for byte. (Catalog w13 *struct-cast base+offset displacement* idiom.)

Basin robustness: decl order of `idx`/`g`/`t` is free (all 3 orders seal);
inlining `idx` into `g`'s expression seals; depth 2, 3, 4 all seal.

## 3. THE FULL SWEEP THIS WAVE (~50 gate-verified spellings, on top of w45's ~180)

| family | result |
|---|---|
| spanning wrapper d1..d4 x {tick-first, bReady-first} | tick-first d3/d4 = 2 (mirror); bReady-first d2+ = 42 (base->$v1, cmd->$a0) |
| `bReady = 1` instead of `= cmd` (all depths) | **identical** to `= cmd` — cse rewrites the constant to cmd's reg and the REF still counts |
| **no wrapper at all** | **14 diffs, and the SCHEDULE IS ALREADY RETAIL'S** — pure 2-register rotation (base `$v1`<->timerhz `$a0`). This is the basin the seal was built from. |
| `int t = timerhz` local (3 positions), `int idx` local, `status`/`pCI` statement positions (4 orders) | all 14 — the qty priority is robust to plain spellings |
| `*(arr + card - 1)` / `(&arr[card])[-1]` pointer spellings | 15 diffs, **210 insns** (loses an insn) |
| `int *slot = &arr[idx]` + wrap-the-store d1/d2/d3 | 15 / **7** / 13, all **210** — the fold absorbs +0x40 AND drops an insn |
| `int *arr = ...; int *slot = arr + (card-1);` (two statements) | 15/15/7/13, all 210 — the two-statement split does NOT block this fold |
| `int idx` separate + `int *slot = &arr[idx]` + d2/d3 | **4 diffs, count exact** — registers + schedule perfect, only `addiu a0,a0,64` / `-12(a0)` / `0(v0)` wrong |
| **struct-cast view `g` + `t` + d2/d3/d4** | **0 — SEAL** |
| struct-cast view without the `t` hoist | 19 diffs, **212** insns |
| array-index store kept inside the wrapper (idx+t hoisted) | 16 diffs — barrier still pins `sll`/`addu` after `sw a1` |

## 4. ANSWER TO THE BRIEFING'S ANGLE (d) — the find_reg-PREFERENCE data point

Briefing asked me to flag to a10 the "1-wrapper arm-0 form where the rank table
says cmd wins but base gets `$a0`". **It is no longer a live anomaly for this
function** (the fn is sealed with the two-wrapper form whose ranks are fully
explained), but the data point stands and is worth a10's trace if the
preference machinery is being modelled:

* w45 receipt: with ONE wrapper on the res==0 arm, `p92` (base) = 8 refs / 22
  live -> `1.091` and `p144` (cmd) = 8 / 20 -> `1.200`; **cmd outranks base yet
  base receives `$a0`**. That inversion can only come from `find_reg`'s
  preference/conflict machinery (`prune_preferences` / `regs_someone_prefers`),
  not from `allocno_compare`.
* Reproduce: `python tools/rtl_dump_c.py recon/frontend/psx/memcard.c -dg -dl`
  with the `case 0:` arm at a single `do{}while(0)`.

I did not consume a10's file: `C:/Temp/nfs4-wt46-a10/scratch/w46_a10_receipts.md`
did not exist at any of my poll points (start, mid, end of run).

## 5. TOOLS (committed in `scratch/`)

* `a2_probe.py` — anchored variant harness for the `case 1:` arm. Replaces the
  region between `      case 1:` and `        break;\r\n      case 2:`, gates one
  fn or the whole TU (`full_tu=True`), and **always restores in a `finally`**.
  CRLF-safe (`encoding='utf-8', newline=''` everywhere). ~1 s per probe.
* `a2_dis.py` — apply one variant, `tools/ourdis.py` it, restore. The
  instruction-level view that made the "schedule is already right, only the
  registers rotate" call possible.
* `a2_land.py` — the landing script for the final form (kept as the receipt of
  the exact text that was committed).

## 6. HAZARDS THAT FIRED (all caught)

* The `case 1:` region anchor had to include the in-source receipt comment —
  `        status = 2;` and `        pCI->status = -1;` each occur **twice** in
  the TU (both switch arms), so a naive `str.replace` would have spliced the
  wrong arm. Anchored on `      case 1:` + the `break;`/`case 2:` pair instead
  (assert-unique by construction: `text.index(TAIL, i)`).
* memcard.c is pure CRLF (1452 lines, 0 NUL). Every read/write went through
  `newline=''`; byte-counted CRLF/LF/NUL before and after every landed edit.
