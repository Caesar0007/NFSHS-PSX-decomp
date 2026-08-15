# W64-A8 RECEIPTS — INTR + eaclib-sound belt (2026-08-15)

Repo `C:\Temp\nfs4-decomp`, base HEAD `fbc974f7`. Gate = `tools/verify_asm.py` (`-`=ours, `+`=oracle).
Production lane = `tools/psyqproof.py`. `tools/*.py` NEVER edited; every probe ran through
`scratchpad/w64a8/probe2.py` (JSON variant runner, anchor `count==1` assert, `finally:` restore)
and `scratchpad/w64a8/cfast.py` (the C-LANE twin of `tools/fast.py`). Memory dir untouched.

## 0. PER-FN LEDGER (every number re-gated by me, twice on the landing)

| fn | TU | briefed | re-gated baseline | final | note |
|---|---|---|---|---|---|
| `iSNDfillspuwithpackets` | sdpacket.c | gate PASS / REAL=1 | **PASS 308**, psyqproof **REAL=1** | **PASS 308, REAL=0** | 🏆 **DUAL-LANE SEAL**, commit `d01c88ef` |
| `iSNDpsxmalloc` | sdmemman.c | 26 | **26** @127/127 | 26 | brief's angle FALSIFIED; instrument lane opened + hardness certificate |
| `_intrhand` | INTR.c | 30 | **30** @116/116 | 30 | both brief angles FALSIFIED (8 cells) |
| `_set_intr_callback` | INTR.c | 25 | **25** @83/82 | 25 | v1.76 corpus twin FOUND; 15 cells falsified |
| `_initIntr` | INTR.c | 6 | **6** @54/54 | 6 | corpus twin CONFIRMS our shape (no delta) |
| `PAD_update` | pad.c | 2 | **2** @66/66 | 2 | 4 new cells + ladder inapplicable |

Board delta: **+1 production seal** (gate board unchanged — the fn was already gate-PASS).
`tu_order_audit.py` = 0 inversions. `tugate.py recon/eaclib/psx/sndpsxz/sdpacket.c` = **13/13 PASS**.
Zero PASS→FAIL anywhere. Only file modified: `recon/eaclib/psx/sndpsxz/sdpacket.c` (committed).

---

## 1. 🏆 SEAL — `iSNDfillspuwithpackets` DUAL-LANE (the first jump-threading-class production fix)

**Cure (zero instructions, first try):** read the DMA-kick loop's entry guard through the same
`volatile` channel-count pointer that every loop-back read in the fn already uses:

```c
    if (*(volatile unsigned char *)(voice + 0x1F) != 0) {   /* was: voice[0x1F] != 0 */
```

**Mechanism.** With the read PLAIN, `jump.c`'s `thread_jumps` proves this test equals the three
tests whose FALSE edges land on the same block — the `|4` loop-start guard @80103ED4, the
`chunk == frames-1` test @80103F20 and the `|1` loop-end guard @80103F30 — and rewrites ONE of
them (the `|1` guard) past this block's re-test straight to `.L80103FE4`. Retail branches to
`.L80103F70`. A volatile MEM is never a provably-equal rtx, so `thread_jumps` declines.
Semantically right: the SPU IRQ/DMA server mutates the driver state block (cluster (1) of the
fn's own banner already argued this for every loop-back read of the same byte).

**Why nobody saw it:** `verify_asm` is branch-TARGET lenient AND the gate-lane cc1 does not
thread at all, so the gate reported PASS 308/308 and `tools/brdist.py` reported 0 divergences.
Only `psyqproof` (PsyQ 4.3 cc1 + ASPSX 2.77) sees it: `word 247: ours 1040002c vs retail 1040000f`.

**Receipts:** gate 2× PASS 308/308 before and after; psyqproof REAL 1 → 0, RELOP=0.
All 8 psyqproof-visible fns in sdpacket.c are now REAL=0 (the other 5 names in the file are
externs owned by other TUs — "not an XDEF/local symbol in the aspsx object").

⇒ **The w63a9 alternative (`PER_FN_NO_THREAD_JUMPS` + a production-lane probe path) is NOT
needed for this fn.** The tooling gap it named (psyqproof honours neither `W60_TEXT_MOVES_FILE`
nor `W60_TU_FLAGS`) is still real for any future case where the source device is unavailable.

---

## 2. 🔑 NEW CORPUS FACT — xenogears-decomp carries a **v1.76** `libetc/intr.c` (our exact revision)

Acting on the mid-wave corpus relay. Result of the capped sweep:

| repo | file | `$Id:` revision | trapIntr / setIntr / startIntr |
|---|---|---|---|
| **ours (NFS4)** | `recon/syslib/psx/libetc/INTR.c` | **v1.76** (PsyQ 4.3) | — |
| **xenogears-decomp** | `src/slus_006.64/psyq/libetc/intr.c` | **v1.76 1997/02/12 makoto** | INCLUDE_ASM / **matched C** / **matched C** |
| psyz | `decomp/src/libetc/intr.c` | v1.76 | INCLUDE_ASM / INCLUDE_ASM / matched |
| sotn-decomp | `src/main/psxsdk/libetc/intr.c` | v1.73 (PsyQ 3.x) | matched / matched / matched |
| **mgs_reversing** | — | **NONE** | the `lib*` dirs are MGS's OWN libraries (libgv/libgcl/libdg/libfs/libsio); the only PsyQ presence is CALL SITES (`SetIntrMask`, `EnterCriticalSection` in gamed.c/stream.c/…). **No PsyQ SDK source in the repo** — the "non-canonical lib names" lead does not apply to libetc. |
| VandalHearts-PcPort / TOMB5 | `platform/pc/src/libetc.c`, `EMULATOR/LIBETC.C` | — | **PC re-implementations** (host shims), not PSX SDK code |
| KAIN2 | — | none | — |

**So the `_intrhand` corpus axis stays retired, but for a sharper reason than w63a8 had:** the
ONLY two v1.76 twins in existence (psyz, xenogears) both ship `trapIntr` as INCLUDE_ASM, i.e.
**nobody has matched this function**, and the one fully-matched body (sotn) is a generation older
(v1.73, falsified across six angles in w63). Per the w63a8 `$Id`-revision law: check the revision
first — mgs adds nothing, and no new revision exists to test.

**`setIntr` (= our `_set_intr_callback`) IS matched in xenogears at our own revision** — the first
same-revision matched twin this function has ever had. Its two structural deltas vs ours were
extracted and measured (§3); **both are codegen-NEUTRAL**, which is itself the useful result:
it removes "we have the wrong source shape" from the hypothesis list for this fn.

**`startIntr` (= `_initIntr`)** in xenogears is statement-for-statement OUR shape
(`g_pInterruptControl->setVsyncIntrCallback = startIntrVSync();` then `…setDMAIntrCallback =
startIntrDMA();` then the cleanup call + `ExitCriticalSection()`), confirming the shipped form.
No delta to port.

---

## 3. `_set_intr_callback` 25 @83/82 — the v1.76 twin measured, 15 cells falsified

**The residual, restated precisely from the side-by-side** (retail regs): `a1` = `&g_intr.cb`
(the `la` base), `a0` = the slot `v0+a1`, and — the whole cluster — `a2 = a1-4` (= `&g_intr`,
materialised in the `beqz` DELAY SLOT) which the ENABLE arm uses as `lhu/sh 48(a2)` while the
DISABLE arm uses `lhu/sh 44(a1)`. Both reach the SAME word. Our cc1 folds them onto one base.
Plus one extra `andi v1,v1,0xffff` (the `pendingValue` fence's cost).

**(a) The xenogears v1.76 structural deltas — MEASURED, both NEUTRAL:**

| angle (from the matched v1.76 twin) | result |
|---|---|
| single combined guard `if (fn != old && inited)` (their shape) replacing our early-return + empty-then/else | **25 @83 (identical)** |
| the same as two nested `if`s | 25 @83 |
| combined guard + `st` hoisted above it | 25 @83 |

⇒ our CFG spelling and theirs are the same code. **The `&&` axis (methodology §3.12 #7) is closed
for this function**, and the shipped form may be replaced by the corpus-faithful one at will
(codegen-free); I did not churn the source for a zero-diff change.

**(b) The struct-name spelling (what retail's `48(a2)` "looks like") — FALSIFIED, all count-OVER:**

| angle | result |
|---|---|
| enable arm as `g_intr.enabled` (keep `st`) | 35 @85 |
| … + drop the now-dead `st` | 35 @85 |
| both arms as `g_intr.enabled` | 41 @87 |
| … + the inited test as `g_intr.inited` | 31 @87 |
| disable arm only as `g_intr.enabled` | 25 @85 |

Read off the emitted `.s`: a struct-name access emits **its own full `lui/addiu` with the +48
folded into `%lo`** (displacement 0) — it never becomes retail's `addiu a2,a1,-4`. So retail's
second base is a POINTER DERIVED BY AN ADD, not a second symbol reference.

**(c) Anti-fold devices for the derived pointer — FALSIFIED (this is the real mechanism question):**

| device | result |
|---|---|
| `st = base-2` moved ABOVE the guard, test spelled `*st` / `st[0]` / anonymous | 25 @83 (×3, inert) |
| opaque COPY then the add (`stx = base; identity-fence(stx); st = (u_short*)stx - 2;`) | 25 @83 (the copy is eaten — 13B "cse eats synthetic copies") |
| identity fence ON `st`, in the guard block (w61's known cell, re-priced) | 27 @83 |
| identity fence on `st` moved to the **successor** block (arm head) — the 13B "Collide" cure, so the `addiu` sits in reorg's backward-scan range and only the def→use path is fenced | **25 @83, inert** ⇒ the fold is NOT combine-late; it happens where the asm cannot separate it |
| fence at the first `st[0x18]` use inside the enable arm | 25 @83 |
| `volatile` view on the enable arm's field | 33 @**81** (2 SHORT) |

⇒ **the fold is an address-arithmetic simplification upstream of anything an asm can separate**
(`(plus (plus base -4) 48)` → `(plus base 44)`), so the only device that has ever restored the
second base is an identity fence ON `st` itself, and that fence provably costs the `beqz` slot
(13B reorg.c:685). The mutual exclusion stands, and it is now known NOT to be a fence-PLACEMENT
problem — moving the fence out of the branch's block does not buy the pointer at all.
**NEXT ANGLE (named, untried): a non-asm anti-fold — the pointer must become opaque before
`expand`/`cse1` folds the two constant addends, e.g. a lane/flag device, not a C spelling.**

---

## 4. `_intrhand` 30 @116/116 — both brief-named angles FALSIFIED (8 cells)

The residual (re-read from the side-by-side, both sites): the three pend operands are BORN in the
wrong order. Retail `ptr#1 = g_istat_ptr ($a0), enabled ($v1), ptr#2 = g_imask_ptr ($v0)`;
ours `ptr#1 = g_imask_ptr ($a0), ptr#2 = g_istat_ptr ($v1), enabled ($v0)`. At **both** sites the
required change is the same 2-element swap: **`enabled` must be born SECOND and the second
pointer THIRD** (at the loop site retail is `lui v1; lhu v1,0(v1)` for `g_intr.enabled` between
the two pointer materialisations).

**(a) PE2's `p = &b` BIRTH-ORDER lever** (DECOMPILATION_LEARNINGS ~12462, `func_800BC2C4`: take the
ADDRESS of the global and read through the pointer so gcc materialises THAT address first):

| cell | result |
|---|---|
| `ap = &g_istat_ptr; … *(*ap)` at the ENTRY site | 30 @116 (inert) |
| same at the LOOP site | 30 @116 |
| both sites | 30 @116 |
| the mirror on `g_imask_ptr` at the entry site | 30 @116 |

gcc folds `*(*ap)` back to the plain global load **with the same materialisation order** — the PE2
lever does not transfer to a double indirection (`*g_istat_ptr`), only to PE2's single one.
**Brief angle #2 CLOSED.**

**(b) PE2's `T* volatile` vs `volatile T*`** (~12352): our globals are already `volatile T *`
(pointee-volatile, correct for MMIO); the `T* volatile` swap is the cell w63a8 measured at
**51 @119**, the worst of that set. The combination `volatile T * volatile` is the same
pointer-volatile store class and was not re-run. **Brief angle #1 stands closed.**

**(c) NEW cells this wave — scheduling barriers (the "make the order explicit" family):**

| cell | result |
|---|---|
| `en = state[0x18]; asm("":: "i"(0)); pend = I_MASK & (en & I_STAT);` (entry) | 35 @117 |
| the same with `en` hoisted above `state[1] = 1` (retail's textual order) | 35 @117 |
| loop-site twin | 39 @117 |
| both | 44 @118 |

Every barrier form goes COUNT-OVER (the named `en` costs an insn), so they are rejected under the
14E count-exact bar regardless of the diff number. Combined with w62's finding that all six
AND-tree permutations are byte-identical (fold canonicalises), **no source-visible ordering device
reaches this**: the order is fixed before local-alloc, and the remaining route is unchanged —
2.7.2 `-dS/-dR` sched1 dumps, or the wiring below.

**(d) 04Z ladder (re-stated, not re-run this wave — the basin did not move):** 2.6.3 = **26 @116/116**
(kills the closing-test `lhu` pair at count parity), 2.7.2 / wired lane = 30, 970404 / 2.8.0 / 2.8.1
= 112 @114. `spec_ver_splice_intrhand_263.json` (w63a8) is still the -4 partial on offer.

---

## 5. `iSNDpsxmalloc` 26 @127/127 — the brief's angle is FALSE, and the instrument lane is now OPEN

**🔴 BRIEF CORRECTION.** The brief called the index-first commutative-`addu` respelling
("the 5.0c row, source-reachable per w42/w44") **UNTRIED**. It is not: the fn's own in-source
receipt (w61-a19, this basin) records it falsified, and I re-ran three cast flavours to be sure:

| spelling of the scan-arm `prev` | result |
|---|---|
| `(unsigned short *)((unsigned int)(idx*4) + (unsigned int)previous)` | 32 @127 |
| `(unsigned short *)((long)(idx*4) + (long)previous)` | 32 @127 |
| `(unsigned short *)((unsigned int)idx*4 + (unsigned int)previous)` | 32 @127 |

(w61-a19's `(int)`-cast form: also 32. The commit-site and scan_done-site forms: 26, neutral.)
So the axis is closed by four independent spellings, not one.

**🏆 THE INSTRUMENT LANE WORKS FOR THE eaclib C LANE (new; W59-11A was cc1plus-only).**
Fidelity receipt for THIS function: with

```
GCC_TRACE_ALLOC=1 cc1-ecoff.exe -quiet -O2 -G4 -g1 -mgpOPT -fgnu-linker -mgas -msplit-addresses
```

the instrumented gcc-2.8.1 `cc1` output for `iSNDpsxmalloc` is **byte-identical to the real
CC1PSX** (132 vs 131 lines, the single delta being an `LM2:` debug label). 🔑 **`-mgas
-msplit-addresses` are MANDATORY** — without them the instrumented cc1 emits `la` where PsyQ
splits, and the whole address/allocation picture diverges (that is what a naive fidelity check
would have mis-read as "the lab does not reproduce this TU"). ⚠️ it also needs `TMPDIR`/`TMP`/`TEMP`
set to a real directory or it dies with `\/ctaNNNNN: No such file or directory`.
Trace + dumps: `scratchpad/w64a8/instr/` (`trace.txt`, `psyq/`, `instr/`).

**WHAT THE TRACE SAYS (`tools/qtytrace.py … --blocked`), cluster (ii) = the scan-arm `prev` pointer:**

```
--- block 9 : 4 qtys ---
  q1 p117  refs 5 life 10  win [6,16)  -> v0
  q3 p118  refs 4 life  8  win [10,18) -> v1
  q0 p119  refs 3 life  4  win [4,8)   -> v1     <- `prev`; retail wants $a2
  q2 p123  refs 2 life  4  win [8,12)  -> a0
```

`prev`'s window `[4,8)` overlaps **exactly one** other qty (p117). Under `find_free_reg`'s plain
ascending scan (13A), **K overlapping local qtys can only occupy the first K free registers**, so
`prev` can be `$v0` or `$v1` and NOTHING ELSE. Retail's `$a2` is the THIRD ⇒ **no priority, ref-step
or live-length dial can reach it; it requires a third value live across those four insns**
(14C INTRUDER-EVICTION). That is a *quantified hardness certificate*, not a floor: the named
requirement is now exact.

**Attempts to mint that intruder from C — all NORMALISED AWAY (12 cells, every one 26 @127/127):**

| cell | result |
|---|---|
| read the arm's limit into `int lim` BEFORE `prev` (3 decl placements) | 26 (inert ×3) |
| the same with the limit read `volatile` (sched1 cannot sink a volatile MEM) | 26 |
| `volatile` on the `prev[0]/prev[1]` reads | 26 |
| commit-block: `commit_block = *(volatile unsigned int *)&local_block` | 26 |
| commit-block: void fence between the read and the first entry store | 26 |
| … + commit index-first | 26 |
| (sanity control: `idx * 8` stride → 38 @125, so the probe path IS live) | — |

The commit-site half (cluster (iv), `lhu v0,16(sp)` before both stores in retail, between them in
ours) is a **sched2** placement — i.e. AFTER local-alloc — which is why no scheduling device there
moves the register handout at all.

**NEXT ANGLE (named, now instrument-backed):** the only reachable dial is a **structural** one that
adds a real fourth qty overlapping `[4,8)` in block 9 — i.e. a value the SCAN ARM genuinely needs
across the `prev` computation. The trace + `--want` output (`scratchpad/w64a8/instr/trace.txt`)
prices every alternative; re-run it after ANY structural landing (04Z basin-relativity).

---

## 6. `_initIntr` 6 @54/54 and `PAD_update` 2 @66/66

**`_initIntr`** — the v1.76 corpus twin (xenogears `startIntr`) is statement-for-statement ours, so
the corpus adds no angle. w63a8's `qty272` reading stands (five block-4 qtys tie at refs 2 / live 4
/ pri 5000 → the NUMBER tie-break; pseudo 91 reuses `$v1` only because 89 is already dead), and the
brief's "%hi-reload-tie CALL-IN-EACH-ARM cure" (tenchu `docs/matching-cookbook.md` ~1212 +
`docs/compiler-facts.md` ~297: *combine_regs refuses a tie when the source pseudo crosses a block
boundary; duplicate the CALL into each arm to make the argument pseudo block-local*) **does not
have a subject here**: `_initIntr`'s two hook-pointer loads are not call ARGUMENTS and there are no
two arms to duplicate a call into — the tenchu law applies to a shared local funnelled from both
arms into one post-join call (their FileRead/PrepareAccess/AfsOpen). The angle is mis-typed for
this function; the standing angle remains 14C INTRUDER-EVICTION on `$v1` across pseudo 91's
4-insn window without crossing the `jal`.

**`PAD_update`** — 4 new cells, none better than 2:

| cell | result |
|---|---|
| `btnOff = 0;` before the loop, `for (i = 0; …)` | 10 @66 |
| `for (btnOff = 0, i = 0; …)` (swap the comma order) | 10 @66 |
| `i = 0;` before the loop, `for (btnOff = 0; …)` | 2 @66 (inert) |
| both inits before a hand-rolled `while` | 2 @66 (inert) |

Swapping which counter is initialised first makes it WORSE (the copy direction flips and cascades),
which independently confirms the in-source reading: retail's `i` is first and `btnOff`'s zero is
FRESH. 04Z ladder is **inapplicable** to this TU: `NFS4_FORCE_CC1_ALT` routes through the 272
recipe (no maspsx), 2.6.3/2.7.2/970404 fail outright and 2.8.0/2.8.1 measure 21 @65 on a pipeline
this TU does not use. The residual is an instance of the **11B cse constant-sharing identity**
(ours copies a live zero, retail re-materialises from `$zero`; the identity fence is not the cure —
here it costs 5 preheader insns, w63-a7). Route unchanged: instrumented-cc1 (why loop.c declines
the `i*8` giv), for which §5's `-mgas -msplit-addresses` recipe is now available.

---

## 7. CATALOG-ROW CANDIDATES (for the orchestrator to harvest)

1. **§F / PRODUCTION — "a gate-PASSing EA fn with `psyqproof REAL=1` on a single `beqz/bnez` word
   is jump.c `thread_jumps`; cure = make the SECOND test's read `volatile`."** Zero instructions,
   both lanes unchanged otherwise. Symptom: our branch offset lands one block PAST the retail
   target, and the retail target block re-tests the SAME value. Invisible to `verify_asm`
   (target-lenient) AND to `brdist` (the gate-lane cc1 does not thread) — psyqproof is the only
   witness. (`iSNDfillspuwithpackets`, first landing of the class.)
2. **§G / CORPUS — the instrumented cc1 needs `-mgas -msplit-addresses` (and a real `TMPDIR`) to be
   byte-faithful to CC1PSX on the C lane.** Without them it emits `la` for every address and the
   fidelity check fails for the wrong reason. With them: `iSNDpsxmalloc` byte-identical.
   ⇒ the W59-11A instrument lane extends to eaclib/syslib `.c` TUs, not just cc1plus.
3. **§A — the 13A UNREACHABILITY TRIAGE, stated as a symptom:** *retail's register is the (K+1)-th
   free one while your qty's `--blocked` window overlaps only K−1 others* ⇒ stop dialing priority;
   the only lever is a structural third live value. (`iSNDpsxmalloc` block 9: window `[4,8)`
   overlaps ONE qty, retail wants `$a2` = the third register — 12 source cells normalised away.)
4. **§G/META — the `$Id:` revision law gains a POSITIVE case:** `xenogears-decomp
   src/slus_006.64/psyq/libetc/intr.c` is **v1.76**, our exact PsyQ 4.3 revision, with `setIntr`
   and `startIntr` matched (only `trapIntr` INCLUDE_ASM). Corpus map for libetc/intr.c:
   ours v1.76 · xenogears v1.76 · psyz v1.76 · sotn v1.73. **`mgs_reversing` contains NO PsyQ SDK
   source** (its `lib*` dirs are MGS's own libraries) — that lead is closed for SDK work;
   VandalHearts-PcPort/TOMB5 `libetc.c` are PC host re-implementations.
5. **§A — a corpus twin can close a hypothesis by measuring NEUTRAL.** The v1.76 twin's `&&`-guard
   shape for `setIntr` scores identically to our early-return + empty-then form (25 @83, three
   spellings) ⇒ "we have the wrong source shape" is removed from that fn's hypothesis list, which
   is worth as much as a diff reduction when the next agent picks it up.
6. **§F — the 13B fence/slot mutual exclusion is NOT a placement problem** when the fence's job is
   to block an ADDRESS fold: moving the identity fence out of the branch's block (the "Collide"
   cure — put the filler in reorg's backward-scan range) leaves the fold intact, because
   `(plus (plus b -4) 48)` is simplified upstream of anything an asm can separate.
   (`_set_intr_callback`, 3 cells.)

## 8. ORCHESTRATOR ACTIONS

- Nothing to wire from this belt. `spec_ver_splice_intrhand_263.json` (w63a8, -4 partial on
  `_intrhand`) is unchanged and still a judgement call.
- Tooling gap re-stated (w63a9): `tools/psyqproof.py` honours neither `W60_TEXT_MOVES_FILE` nor
  `W60_TU_FLAGS`, so a production-lane-only residual cannot be probed with a build.py mechanism.
  This wave's fix was source-side, so the gap did not block it.
- Promote-worthy: `scratchpad/w64a8/cfast.py` (C-lane `fast.py` twin: gate + real-CC1PSX/272
  allocno picture + `dumps()`), `scratchpad/w64a8/probe2.py` (dual-lane variant runner — reports
  gate AND psyqproof per variant, which is what caught the seal in one run).

## 9. FILES / BACKUPS / HAZARDS

- Landed: `recon/eaclib/psx/sndpsxz/sdpacket.c` (commit `d01c88ef`). No other source touched
  (`git status` clean for INTR.c / pad.c / sdmemman.c at close).
- Backups: `sdpacket.c.base.bak`, `sdmemman.c.base.bak`, `pad.c.base.bak`, `INTR.c.base.bak`.
- Specs/artifacts: `spec_fillspu.json`, `spec_setintr{1,2,3,4,5}.json`, `spec_intrhand{1,2}.json`,
  `spec_malloc{1,2,3}.json`, `spec_pad1.json`, `spec_sanity.json`, `malloc_sbs.txt`,
  `instr/` (fidelity pair + `trace.txt`).
- Hazards: (a) the instrumented cc1 dies with `\/ctaNNNNN: No such file or directory` unless
  `TMPDIR`/`TMP`/`TEMP` point at an existing dir; (b) `probe2.py`/`cfast.py` assert `count==1` on
  every anchor — one of my anchors (`    int *base;`) matched twice in INTR.c and was caught
  rather than silently mis-patching (the w63a9 loose-anchor trap); (c) no heredocs carried escapes;
  every payload was built from Python literals; (d) all probes restore in `finally:` and re-assert
  the original bytes.
