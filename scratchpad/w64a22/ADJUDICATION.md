# W64-A22 — CONTRADICTION ADJUDICATION (by experiment, on our toolchain)

Repo `C:\Temp\nfs4-decomp`. Every verdict below is a **measurement**, not a reading.
Harnesses + raw dumps: `scratchpad/w64a22/` (`declab*.py`, `parmlab.py`, `netzero.py`);
compile outputs under `%TEMP%\w64a22_declab\<lane>_<probe>_<variant>\`.
gcc sources cited from the pristine tree `C:/Temp/gccsrc/gcc-2.8.1/` (+ the
NFS4-instrumented copy `C:/Temp/gcc-2.8.1-src/extracted/`, line numbers taken from
**extracted/** where both exist — the instrumented copy has shifted lines).

**Five compiler binaries were swept for every probe** (the verdicts are
lane-independent unless stated):

| tag | binary | flags |
|---|---|---|
| `cpp` | `C:/Temp/psq43/COMPILER/CC1PLPSX.EXE` (2.8.0, our C++ lane) | `-O2 -G4 -fno-exceptions -fno-rtti` |
| `c280` | `C:/Temp/psq43/COMPILER/CC1PSX.EXE` (2.8.0, eaclib lane) | `-O2 -G4` |
| `c272` | `C:/Temp/nfs3-clean/psyq400/COMPILER/CC1PSX.EXE` (2.7.2.SN32, syslib lane) | `-O2 -G0 -mgas` |
| `c281` | `C:/Temp/windows-gcc-psx/gcc-2.8.1-psx/cc1.exe` (**tenchu's lane**) | `-O2 -G4` |
| `c272b` | `C:/Temp/windows-gcc-psx/gcc-2.7.2-970404-psx/cc1.exe` (**LoM's lane**) | `-O2 -G4` |

---

## 1. 13A SCOPE — does declaration order move SCALAR REGISTER pseudo numbers?

### The dispute
* **catalog 13A**: *"BOTH allocator layers tie-break by NUMBER (qty = block birth order,
  allocno = pseudo = declaration order) so the decl dial reaches the ALLOCATOR too."*
* **W41 + tenchu cookbook §3.9**: *"pseudo numbers follow FIRST-USE order, NOT declaration
  order (proved by re-dump after decl swap: byte-identical) … gcc-2.8.1 defers scalar
  pseudo allocation to first-use, so declaration order cannot renumber allocnos"*;
  W63-A18 C1 resolved it against 13A and asked for the clause to be deleted.
* **W61-A20** had measured a decl-axis effect on `Night_SetEnviroment`.

### VERDICT — **both sides are half right, and W63-A18's C1 resolution is WRONG on the mechanism.**

> **THE DECL-ORDER LAW (measured, 5 binaries).**
> **(1)** A register-eligible scalar's PSEUDO NUMBER is minted **at its DECLARATION**, in
> **declaration order** — *not* at first use. tenchu's stated mechanism ("gcc-2.8.1 defers
> scalar pseudo allocation to first-use") is **FALSE**.
> **(2)** The **local-alloc** layer (a pseudo live inside ONE basic block) is **numbered by
> BIRTH order**, so the decl dial is **inert there — even at an exact priority tie**.
> **(3)** The **global-alloc** layer (a pseudo live across >1 basic block) is numbered by
> ascending PSEUDO number, so at an **exact `allocno_compare` tie the decl dial DOES decide
> the handout** — measured as a full register rotation on all five binaries.
> **(4)** Because ties are rare, a decl permutation is *usually* code-inert — which is what
> W41 and tenchu actually observed and then over-generalised into a mechanism claim.

So 13A's clause **"so the decl dial reaches the ALLOCATOR too" is CORRECT but needs the
scope qualifier**: *global allocnos only, and only at an exact priority tie.* The
recommendation in W63-A18 C1 to strike it should NOT be actioned; it should be
**narrowed** instead (proposed replacement text in §5).

### The mechanism, with citations
| step | citation | what it says |
|---|---|---|
| the pseudo is minted at the DECLARATION | `stmt.c:3592-3618` (`expand_decl`, "Automatic variable that can go in a register", `DECL_RTL (decl) = gen_reg_rtx (reg_mode);` @ **3611**) | a scalar with `DECL_MODE != BLKmode && !TREE_THIS_VOLATILE && !TREE_ADDRESSABLE && (DECL_REGISTER \|\| !obey_regdecls)` gets a **pseudo, right there**. `obey_regdecls == !optimize`, so at -O2 every non-addressable scalar qualifies. |
| …called at the declaration, C lane | `c-decl.c:3748-3760` (`start_decl`): *"For a local variable, define the RTL now"* → `expand_decl (tem)` | declaration order == pseudo order |
| …called at the declaration, C++ lane | `cp/decl.c:6878-6890` (`cp_finish_decl`): *"Do this here, because we did not expand this decl's rtl in start_decl"* (the `start_decl` copy at `cp/decl.c:6190-6205` is inside `#if 0`) | same result, one step later in the same declaration |
| allocno numbering | `global.c:385-398` — `for (i = FIRST_PSEUDO_REGISTER; i < max_regno; i++) … reg_allocno[i] = max_allocno++;` | allocno number == **ascending pseudo number** |
| the global tie-break | `global.c:594-616` `allocno_compare`, tail: *"If regs are equally good, sort by allocno, so that the results of qsort leave nothing to chance"* → `return v1 - v2;` | **the decl dial's entry point** |
| qty numbering | `local-alloc.c:280-285` `alloc_qty` → `register int qty = next_qty++;`, called from the block scan at `local-alloc.c:2102` | qty number == **birth order in the block** |
| the local tie-break | `local-alloc.c:1739-1752` `qty_compare_1`, tail: *"If qtys are equally good, sort by qty number"* → `return q1 - q2;` | a **QTY** number, not a pseudo number ⇒ decl-blind |
| spilled pseudos → frame | `reload1.c:778-779` — one ascending `for (i = LAST_VIRTUAL_REGISTER+1; i < max_regno; i++) alter_reg (i, -1);` | 13A's SPILL-SLOT half stands unchanged |

### The measurements

**1a — pseudo numbering (`declab.py` / `run_declab.py`).** Five scalars, **first-use order
held fixed** at `a,b,c,d,e`, distinct ref counts so each is identifiable in `.lreg`.
Permuting only the declarations permutes the pseudo numbers exactly:

```
decl a,b,c,d,e :  a=p81 b=p82 c=p83 d=p84 e=p85     (cpp lane; c272/c280 identical modulo base)
decl e,d,c,b,a :  a=p85 b=p84 c=p83 d=p82 e=p81
decl c,a,d,b,e :  a=p82 b=p84 c=p81 d=p83 e=p85
```
→ **pseudo number = declaration order.** Emitted `.s` was **byte-identical** in all
permutations (only the `.file` path differs) because the priorities were distinct.

**1b/1c — no tie ⇒ inert.** Equal refs but staggered live lengths (`declab2.py`,
`declab3.py`): every permutation SAME-CODE; each variable keeps its own register
(`a→s3, b→s2, c→s1` regardless of which pseudo number it wore).

**1d — EXACT TIE, global allocnos (`declab4.py`, `W64A22_FLAT=1`).** Births staggered by 1
insn and deaths staggered by 1 insn ⇒ every local reports `refs=3 / live=10`, an exact tie:

```
lane cpp / c272 / c280 / c281 / c272b   (IDENTICAL on all five)
  decl a,b,c,d :  SAME-CODE      a=$2 b=$3 c=$6 d=$7
  decl d,c,b,a :  CODE-DIFFERS   a=$7 b=$6 c=$3 d=$2
  decl b,c,d,a :  CODE-DIFFERS   a=$7 b=$2 c=$3 d=$6
greg priority order is 82 83 84 85 in EVERY permutation (the tie-break by allocno number),
so the registers rotate exactly with which variable owns which pseudo number.
```
→ **the decl dial reaches the global allocator, at a tie, on every lane.**

**1e — EXACT TIE, local-alloc qtys (`declab5.py`).** Same construction in a SINGLE basic
block (all pseudos `in block 0`), sweeping the two axes independently:

```
  decl=rev use=id   SAME-CODE      a=$5 b=$6 c=$3 d=$2     <- decl dial INERT
  decl=rot use=id   SAME-CODE      a=$5 b=$6 c=$3 d=$2
  decl=id  use=rev  CODE-DIFFERS   a=$2 b=$3 c=$6 d=$5     <- first-use dial DECIDES
  decl=id  use=rot  CODE-DIFFERS   a=$2 b=$5 c=$6 d=$3
```
(identical on all five binaries; the lives here are 18,18,14,14 — a genuine pairwise tie,
and the decl permutation still cannot touch it).

**1f — memory locals (`declab6.py`) — a NEW sub-law, and a correction to tenchu.**
tenchu says *"contrast address-taken/stack locals, whose declaration order DOES fix slot
order"*. Only half true:

```
BLKmode aggregates (int a[2]…):  decl=id  a=sp+16 b=sp+24 c=sp+32 d=sp+40
                                 decl=rev a=sp+40 b=sp+32 c=sp+24 d=sp+16   <- DECL order
address-taken SCALARS:           decl=id/rev/rot ALL a=sp+16 b=sp+20 c=sp+24 d=sp+28
                                 …but reversing the ORDER THE ADDRESS IS TAKEN gives
                                   a=sp+28 b=sp+24 c=sp+20 d=sp+16          <- ADDRESS-TAKE order
```
> **MEMORY-LOCAL SLOT LAW:** an **aggregate/BLKmode** local gets its frame slot from
> `expand_decl` at the declaration ⇒ **declaration order**. An **address-taken SCALAR** is
> born a pseudo at the declaration and only demoted when `mark_addressable` fires
> (`c-typeck.c:3411` / `cp/typeck.c:4770,4805` → `put_var_into_stack`, `function.c:1342`)
> ⇒ its slot follows **the order its address is first taken**, not the declaration.
> Three separate frame-order mechanisms therefore exist: BLKmode-at-decl,
> address-taken-at-first-`&`, and spilled-pseudo-at-`reload1.c:778` (ascending pseudo =
> decl order). Diagnose which one a `.frame`/`sp+N` residual belongs to before dialing.

### Practical rule for the belts
1. A scalar decl permutation is worth a probe **only** when the fighting values are
   **global allocnos** (`.lreg` line has **no** `in block N`) **and** their
   `floor_log2(refs)*refs*SIZE/live` products are **equal** (read them off `-dl`; the
   `greg priority order` line shows the post-qsort order). Otherwise it is a proven no-op —
   W63-A18's "any belt sweeping scalar decl permutations is burning budget" stands for
   every OTHER case.
2. If the values are block-local qtys, the equivalent dial is the **first-use / birth**
   order (measured decisive above), which is a real statement-order edit, not a decl edit.
3. W61-A20's `Night_SetEnviroment` decl-axis effect is therefore **not anomalous** — it is
   the case-(3) tie. (Its 15B re-price note already says the fn has zero global allocnos in
   the *current* basin, so re-check which regime it is in before reusing the receipt.)

---

## 2. W46 PROLOGUE PARAM-COPY SINK — when does the local-copy cure work?

### The dispute
* **W46** parked the class: *"assign_parms emits before any statement — no source position
  or fence reaches it; only sched dependence-chain depth can."*
* **W47-a1** partially retired it: a **fence** on the param pins the copy (FILE_callbackop → PASS).
* **tenchu §3.13 (`FUN_80057b80`)** claims a **fence-free** cure: local copies of the
  formals, *"coalesces to the same bare `move s1,a1` / `move s0,a0` while retaining
  local-assignment order"*.
* **W64-A2 (this wave)** already FALSIFIED that on `BuildCustomObjectFacets` (4 forms; the
  copies were copy-propagated, only the coloring rotated) — `scratchpad/w64a2/RECEIPTS.md`.

### VERDICT — tenchu's FENCE-FREE cure is **FALSIFIED on all five binaries, including their own 2.8.1**. The effect they describe is real but requires a device that **defeats copy propagation**, and it is **2.8.0-only**.

`parmlab.py`, minimal repro: two pointer formals both live across three calls, so
`assign_parms` emits `move s?,a0` and `move s?,a1`. Reported as
`#<insn index> $dst<-$src` in emission order:

```
                          cpp        c280       c272       c281       c272b
a_direct                 #3 16<-4 ; #9 18<-5    (identical on all five lanes)
b_locals_xy   (x=x0;y=y0) SAME as a_direct  — byte-identical .s
c_locals_yx   (y=y0;x=x0) SAME as a_direct  — byte-identical .s   <-- tenchu's dial: INERT
d_decl_yx     (+decls rev) SAME as a_direct
e_init_xy / f_init_yx      SAME as a_direct  (decl-with-init spelling: also inert)
k_multiset_xy / l_multiset_yx  differ from base, but IDENTICAL TO EACH OTHER on all 5
g_useflip     (body first-use flipped)  #3 16<-4 ; #5 18<-5   -> POSITION moves, mapping does not
h_fence_y   ("" : : "r"(y))             #3 18<-4 ; #5 17<-5   -> MAPPING moves (all 5 lanes)
i_fence_x   ("" : : "r"(x))             #3 16<-4 ; #5 18<-5   -> position only
j_fence_yx  (both, y listed first)      same as i  -> OPERAND ORDER INSIDE ONE FENCE IS NOT A DIAL
m_laund_xy  (identity launder, x first) #3 17<-4 ; #7 18<-5
n_laund_yx  (identity launder, y first) #3 18<-5 ; #7 17<-4   <-- ASSIGNMENT ORDER RETAINED
                                        …but only on cpp and c280.
                                        c272 / c281 / c272b: m and n byte-IDENTICAL.
```

> **THE PARAM-COPY BOUNDARY LAW.**
> **(a)** Bare local copies of formals (`T *x = x0;`, any assignment order, with or without
> initialisers, with or without a second SET) are **copy-propagated before local-alloc** and
> leave **no RTL trace** — the local-assignment order is *not* retained. This holds on
> gcc-2.7.2, 2.8.0 and **2.8.1**, i.e. tenchu's own compiler. It is the same governing limit
> already in 13B/15B: *"cse eats synthetic copies pre-local-alloc ⇒ copy-based dials exist
> ONLY where the emitted code already carries a real reg-reg copy."*
> **(b)** With an **identity launder** on each local (`asm("" : "=r"(x) : "0"(x))`, 13B), the
> assignment order **IS** retained in the emission order of the parm copies — this is
> tenchu's "save-order dial", and it is **2.8.0-only** (inert on 2.7.2 and 2.8.1 here).
> ⇒ our C++ (`CC1PLPSX`) and eaclib (`CC1PSX 2.8.0`) lanes can buy the parm-copy ORDER;
> the syslib 2.7.2 lane cannot.
> **(c)** The only dial that changes which formal LOSES a register is an **asymmetric ref
> dial**: a read-only fence on the *second* formal (`h_fence_y`) rotated `x: s0→s2`,
> `y: s2→s1` on **all five** binaries. Fencing the *first* formal, or fencing both in one
> asm, is inert as a colouring dial (only the position moves) — because both formals then
> gain the same +1 ref and the relative priority is unchanged.
> **(d)** First-use order in the body moves the copy's **POSITION** (insn #9 → #5, i.e. into
> a `jal` delay slot) but never its **register**.
>
> ⇒ W46's park is **correct as to position-by-source-position** and **wrong as a floor**: the
> class has two working dials (b) and (c), and A2's falsification of tenchu was right about
> the bare form.

---

## 3. NET-ZERO INC/DEC PAIR — catalog says "fix", tenchu says "diagnostic"

### The dispute
* **catalog §A row**: *"NET-ZERO POINTER INC/DEC PAIR — insert a semantically-void
  `p++; p--;` … keep verbatim once found, don't clean up."* Witness
  `BworldSm_UpdateSimQuad` (`recon/game/common/bworldSm.cpp:377-379`).
* **tenchu §3.9**: the identical device is *"a DIAGNOSTIC, not a fix … USE it to
  characterise the residual, then REJECT the nudge"*, and in every case they chased, a real
  identity existed behind it.

### VERDICT — **tenchu wins on this witness, and by the strongest possible margin: the pair is INERT at HEAD. Deleting it is free.**

Run on a **copy** of the sealed TU
(`scratchpad/w64a22/lab/game/common/bworldSm.cpp`, byte-identical to `recon/`, gates
identically at 34/34), harness `scratchpad/w64a22/netzero.py`. The sealed TU was **never
edited**:

```
00_base             PASS (34 insns)          <- with the pair
01_pair_removed     PASS (34 insns)          <- WITHOUT the pair, re-gated 2x
02_pair_reversed    PASS (34 insns)
03_pair_on_pTVar2   PASS (34 insns)
04/05/06 read-only fence on pTVar2 x1/x2/x3  PASS (34 insns)   (all inert)
08_fence_both       PASS (34 insns)
07_fence_slicePos   FAIL 16 diffs            <- barrier COST
10_fence_simSlice   FAIL 16 diffs
11_void_fence       FAIL 16 diffs
09_launder_pTVar2   FAIL 2 diffs
```

* The pair is **not load-bearing**: removing it keeps the byte match (34/34, gated twice).
* No substitute is needed — the honest cure is **deletion**, exactly tenchu's directive
  ("a match that only holds because of scaffolding nobody would write is not a match" —
  AGENT_GUIDE).
* This is a textbook **04Z basin-relativity** case: the permuter-derived nudge was load-
  bearing in the W-something basin it was found in; a later structural landing in the same
  function (the *"MATCH: re-read via slicePos"* selective-caching device on line 384, which
  is a REAL identity and stays) made it dead code. **The in-source comment claims it "forces
  pTVar2 into oracle's a1" — that claim is now false at HEAD.**
* Note also that three *documented* zero-insn instruments (`07`, `10`, `11`) REGRESS this
  function by 16 — a reminder that a fence's barrier is a cost (13B/06B), and that "inert"
  and "harmless" are not the same thing.

**ORCHESTRATOR ACTION (I did not touch the sealed TU):** delete
`recon/game/common/bworldSm.cpp:377-379` (the `slicePos->simSlice++; / --;` pair and its
`@codegen-device` comment) and re-gate; expected `PASS (34 insns)`, measured twice here.
Then re-classify the catalog §A row from **fix** to **DIAGNOSTIC** (§5).

---

## 4. LoM's ALLOCATOR FORMULA — closing paragraph

W63-A18 C2 flagged `lom-decomp/docs/decompilation/gcc-272-matching-techniques.md` §1.2
(`priority = reference_count / spill_cost`, and *"REG_ALLOC_ORDER for MIPS is s0, s1, s2 …"*)
as contradicting our validated model. **Both LoM claims are wrong; 15B's correction is
confirmed verbatim at source level, and this closes the axis.**

* **The formula.** `global.c:594-616` (`allocno_compare`), pristine 2.8.1 source:
  ```c
  register int pri1
    = (((double) (floor_log2 (allocno_n_refs[v1]) * allocno_n_refs[v1])
        / allocno_live_length[v1])
       * 10000 * allocno_size[v1]);
  ```
  and the local-alloc twin `QTY_CMP_PRI` at `local-alloc.c:1726-1728`:
  ```c
  #define QTY_CMP_PRI(q)  \
    ((int) (((double) (floor_log2 (qty_n_refs[q]) * qty_n_refs[q] * qty_size[q]) \
            / (qty_death[q] - qty_birth[q])) * 10000))
  ```
  ⇒ **`floor_log2(refs) * refs * SIZE / live`**: SIZE **multiplies**, there is **no minus
  term**, and no negative priorities exist. 15B's correction of the W45-A formula
  (`floor_log2(refs)*refs − SIZE`, catalog row "🔴 CORRECTION … the −size term makes any
  2-ref 4-byte pseudo NEGATIVE, so the live-length dial INVERTS") is **right**, and the
  2-ref live-length inversion it induced **does not exist** — the `HrzSetPsxMatrix` w50
  verdict stays retired. LoM's linear `refs / spill_cost` misses the `floor_log2` STEP,
  which is the razor our whole ref-step family is built on. 12A's separate finding that
  **gcc-2.7.2 has NO size term** is a *version* difference, not a contradiction of this.
* **REG_ALLOC_ORDER.** `config/mips/mips.h` does **not** define `REG_ALLOC_ORDER` (grep:
  zero hits). `global.c:992-998` therefore takes the `#else` arm — `int regno = i;` — a
  **plain ascending numeric scan** over `0..FIRST_PSEUDO_REGISTER`, exactly as 13A/W45 say.
  LoM's "s0, s1, s2 …" is their *empirical* observation (a long-lived call-crossing value
  ends up in a low s-register because the scan reaches `$16` first once the caller-saved
  regs are excluded by the call-crossing conflict) dressed up as a target macro.
  What *does* precede the scan is the **hard-reg PREFERENCE** (`global.c:1030-1045`,
  `find_reg`) — 13A's SET_PREFERENCE law — and `prune_preferences` (`global.c:865-876`).
* **Standing instruction:** use LoM's craft rules (their `%lo(SYM±N)` fold cures, N1/N2 in
  the W63 harvest are good), **never their formula or their REG_ALLOC_ORDER claim.**

---

## 5. PROPOSED CATALOG EDITS (memory dir is READ-ONLY for me — orchestrator to apply)

1. **13A, replace** *"BOTH allocator layers tie-break by NUMBER (qty = block birth order,
   allocno = pseudo = declaration order) so the decl dial reaches the ALLOCATOR too."*
   **with:**
   > **THE DECL-ORDER SCOPE LAW (W64-A22, 5 binaries, gcc-cited).** A register-eligible
   > scalar's pseudo is minted **at its declaration** (`stmt.c:3611` `gen_reg_rtx`, called
   > from `c-decl.c:3748` / `cp/decl.c:6881`) ⇒ **pseudo number = DECLARATION order**
   > (tenchu/W41's "deferred to first use" mechanism is FALSIFIED). But the two allocator
   > layers number differently: **local-alloc qty = BIRTH order** (`local-alloc.c:285`
   > `next_qty++` in the block scan; tie-break `qty_compare_1` → `q1 - q2`, a QTY number)
   > ⇒ **the decl dial is INERT for block-local pseudos even at an exact tie**;
   > **global allocno = ascending PSEUDO number** (`global.c:385-398`; tie-break
   > `allocno_compare` → `v1 - v2`) ⇒ **the decl dial DOES decide the handout for
   > multi-block pseudos AT AN EXACT `floor_log2(refs)*refs*SIZE/live` TIE** (measured: a
   > 4-way register rotation on cc1plus-2.8.0 / cc1-2.8.0 / 2.7.2 / 2.7.2-970404 / 2.8.1).
   > PRE-GATE before spending a decl sweep: the `.lreg` line must have **no** `in block N`
   > **and** the priorities must be equal. Everything else is a proven no-op.
2. **13A, add the memory-local refinement** (§1f above): BLKmode-at-decl vs
   address-taken-at-first-`&` vs spilled-at-`reload1.c:778` are **three** distinct frame
   ordering mechanisms; tenchu's "address-taken locals' decl order fixes slot order" is
   true only for aggregates.
3. **W46 park → replace with THE PARAM-COPY BOUNDARY LAW** (§2 above), including the
   negative: *the operand order inside one multi-operand fence is not a dial.*
4. **§A NET-ZERO POINTER INC/DEC PAIR row → re-classify as DIAGNOSTIC** with the receipt
   *"the sole in-tree witness (BworldSm_UpdateSimQuad) re-measured INERT at W64 HEAD —
   the pair is deletable at zero gate cost; never land one."*
5. **W63-A18 C1's resolution should be marked SUPERSEDED** by §1 (its practical advice
   survives, its mechanism does not); **C2 CLOSED** by §4; **C3 CLOSED** in tenchu's favour
   by §3; **C4 CLOSED** in A2's/our favour by §2 (tenchu's fence-free form does not work on
   any of the five binaries, their own included).
6. **12H scope correction** (found while doing Mission B): `-fno-exceptions -fno-rtti` are
   **INERT on the real CC1PLPSX.EXE** — `.s` and `.lreg` byte-identical with and without,
   over 6 C++ TUs (psxfront, bworldSm, aistate, fedialog, hud, camera). The 8/10-vs-0/10
   fidelity law applies to the **instrumented FSF cc1plus** of the qtytrace lane. (Also
   explains why `build.py`'s `compile_cpp` never passes them and still byte-matches retail.)

---

## 6. MISSION B — TOOL SURGERY (all three landed; `.bak` in `scratchpad/w64a22/bak/`)

| tool | defect | fix | proof |
|---|---|---|---|
| `tools/alpha.py` | `from probe import Probe, ROOT` imported a **scratch-only** module (`scratchpad/w61a18/probe.py`) not on `sys.path` from `tools/` ⇒ `ModuleNotFoundError` for every caller (13F says "PROMOTED", the W64 BRIEF says "BROKEN") | `Probe` inlined verbatim (match-count asserts + restore-in-`finally` kept); `ROOT` derived locally; `ALPHA_SRC`/`ALPHA_FN` env overrides added, default target unchanged | `python tools/alpha.py` → `base: alpha-renamed structural diffs = 19 (ours 82 / oracle 82)` on FontUpsideDownBlit; override run on a PASSing control (`BworldSm_UpdateSimQuad`) → `0 (34/34)`; a stale variant anchor raises the assert instead of silently no-op'ing; `psxfront.cpp` byte-clean after every run |
| `tools/fast.py` | `picture()` omitted `-fno-exceptions -fno-rtti`, so w63-a16 and w64-a2 each forked it (`scratchpad/w64a2/pic.py`) | flags folded in; optional `showpri=True` adds the 15B priority column (default output unchanged) | `gate()` untouched; default `picture()` output byte-identical to the pre-edit baseline on psxfront; `showpri` verified on bworldSm. **Measured**: the flags are inert on CC1PLPSX (see §5.6) |
| `tools/qty272.py` | usage advertised `[--rtl]` — **no such argument** (argparse hard-errors) — and the pre-promotion `scratchpad/w60a1/` path | docstring corrected to the real flag set (`--list/--all/--keep`) + pointer to `tools/rtl_dump.py`; **no code change** | `python tools/qty272.py recon/syslib/psx/libcd/drv.c --list` and a `CD_sync` run both re-proven post-edit |

`ast.parse` clean on all three. Only these three files were staged.
⚠️ **Hazard hit:** my staged tool changes were swallowed by a peer's sweeping commit
(`2ab433f4`, "w64a18: LINK CAMPAIGN region 3") between `git add` and `git commit` — the
content is in HEAD and correct, but attributed to that commit. This is the documented
`git add -A` peer-sweep hazard, second occurrence on record.
