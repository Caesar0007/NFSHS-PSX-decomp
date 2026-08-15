# W63-A15 RECEIPTS — game/common misc + eaclib belt

Base HEAD at start: `10e1a01b`. All numbers below are MY OWN re-gated runs
(`python tools/verify_asm.py`), never board rows.

## 0. RE-GATED BASELINES (board rows vs gate truth)

| fn | TU | board % | GATE baseline | note |
|---|---|---|---|---|
| SetupChunkBuildList__FP13DRender_tView | game/common/bworld.cpp | 99.09 | FAIL 7 (202/203) | |
| Cars_ResetCollidedCars__FP8Car_tObjii | game/common/cars.cpp | 99.98 | **PASS (280)** | board STALE |
| Cars_DoExtraCarCollisionProcessing__FP8Car_tObj | game/common/cars.cpp | 99.99 | **PASS (597)** | board STALE |
| Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2 | collide.cpp | 98.54 | FAIL 14 (763/765) | |
| Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2 | collide.cpp | 99.72 | FAIL 8 (1164/1164) | |
| NFS3_CheckForFileOperations__Fv | nfs3.cpp | 96.19 | FAIL 8 (21/21) | |
| Draw__25tPMenuItemLeftRightSliderb | pausemenu.cpp | 98.05 | FAIL 8 (171/169) | |
| Sim_MainGameLoop__Fv | sim.cpp | 98.68 | FAIL 6 (319/321) | |
| SimQueue_SetCurrentInput__Fi | simqueue.cpp | 99.79 | FAIL 4 (48/48) | |
| Stats_TrackEndGame__Fv | stats.cpp | 97.11 | FAIL 44 (232/232) | |
| intarcsin | eacpsxz/asinfunc.**c** | 99.79 | FAIL 2 (48/48) | brief said `.cpp`; file is `.c` |
| FILE_cancelop | eacpsxz/nfile.**c** | 99.95 | **PASS (109)** | board STALE |
| STREAM_cancelrequest | eacpsxz/stream.**c** | 99.97 | **PASS (173)** | board STALE |

3 of the 13 were already gate-PASS. **All three carried a gate-INVISIBLE defect
(see §1).**

---

## 1. 🔴🔴 HEADLINE — `tools/brdist.py` IS VACUOUS ON MOST TUs, AND THE 04Q
##    BRANCH-TARGET CLASS IS LIVE IN THREE "SEALED" FUNCTIONS

### 1.1 The tool defect (orchestrator action item)

`tools/brdist.py` exists precisely to catch the 04Q blind spot (verify_asm
normalises branch TARGETS to `T`, so a wrong target reads PASS). Its
`ours_branches()` parses the objdump target address with

```python
m = re.search(r'\b([0-9a-f]{4,8})\b\s*<', t) or re.search(r',([0-9a-f]+)$', t)
```

`objdump` prints the target **without zero padding**, so any function whose
target address is 1–3 hex digits — i.e. every function in the first 4 KiB of an
object, which is most of a small/medium TU — matches NEITHER alternative. The
branch is then recorded as `None` and the compare loop skips it
(`a is not None and b is not None`). The census prints
`0 with branch-offset/count divergence` **vacuously, for exactly the branches it
was built to find**.

* Proof: `Cars_ResetCollidedCars` word 15 is `bnez v0,d20` (3 hex digits);
  our offset is `0x100`, retail's is `0x4b`. `tools/brdist.py recon/game/common/cars.cpp`
  reports **0 divergences**.
* Fix = one character: `{4,8}` → `+`. My corrected copy is
  `scratchpad/w63a15/brdist2.py` (everything else is brdist.py verbatim).
* **Cross-validated**: brdist2's hits are exactly the rows `tools/psyqproof.py`
  independently scores `REAL=1` — two independent instruments, same three fns.
* This is the 5th instance of the standing law *"VALIDATE ANY CENSUS TOOL
  AGAINST A KNOWN-POSITIVE before trusting empty output"* (w43). Recommend the
  one-character fix in `tools/brdist.py` **and a tree-wide re-run**: every
  gate-PASS fn ever cleared by brdist is unaudited.

### 1.2 The three live defects found

| fn | brdist2 (idx, ours, oracle) | psyqproof | meaning |
|---|---|---|---|
| `FILE_cancelop` | (7, 56, 11) | REAL=1 | **FIXED — see §2** |
| `Cars_ResetCollidedCars` | (0, 257, 76) | REAL=1 word 15 | open, angle named §3.1 |
| `Cars_DoExtraCarCollisionProcessing` | (1, 28, 32) | REAL=1 word 14 | open, same family |
| `STREAM_cancelrequest` | (13, 42, 66) | REAL=1 word 88 | open, mechanism named §3.2 |

In every case the instruction STREAM is byte-identical (counts exact, psyqproof
`REAL=1` = one single word) and only the branch's target label differs — i.e.
these are pure `jump.c` edge-redirection differences that the gate cannot see.

---

## 2. ✅ SEAL — `FILE_cancelop` (eaclib/psx/eacpsxz/nfile.c), commit `68698aa9`

**DUAL-LANE: gate PASS 109/109 · psyqproof `REAL=0 RELOP=0` (was `REAL=1`) ·
brdist2 divergence 1 → 0 · TU `tugate` 27/27 PASS (gated 2×).**

Diagnosis: oracle branch #7 is
`beqz $v0,.L800EC0F4` (dist 11) — the **duplicate CS-leave block**
(`mtc0 $s0,$12 ; j .L800EC1AC`) that the *not-in-queue* exit already emits.
Ours branched to `.L800EC1A8` (dist 56), the shared `cleanup:` tail. Both blocks
existed in our object; only the edge was wrong.

Source cause: the EMPTY-QUEUE early-out was spelled `goto cleanup;` while the
NOT-IN-QUEUE early-out was spelled `{ FILE_CS_LEAVE(sr); return; }`
(a w29 lever). Retail routes **both** to the same duplicate block.

Fix (retail's CFG, 2 lines):

```c
        if (node == 0) goto notfound;
        while (node != 0) { if (node == op) break; prev = node; node = node->qnext; }
        if (node == 0) {                               /* not in queue */
notfound:
            FILE_CS_LEAVE(sr); return;
        }
```

Falsified on the way: duplicating the whole `{ FILE_CS_LEAVE(sr); return; }`
body at the pre-loop site (**FAIL 5, 112/109** — the two copies do NOT
cross-jump-merge; only the shared-label form works).

**CATALOG ROW CANDIDATE (new):** *symptom* — gate PASS but brdist2/psyqproof show
one wrong branch TARGET into a duplicated exit block; *fix* — two source exits
that must reach the SAME retail block need ONE labelled block reached by `goto`,
not two textual copies (copies stay unmerged and cost 3 insns).

---

## 3. OPEN — NEW NAMED ANGLES (no floors)

### 3.1 `Cars_ResetCollidedCars` / `Cars_DoExtraCarCollisionProcessing` (cars.cpp)
Both gate-PASS, both `REAL=1`. `ResetCollidedCars`: our `bnez $v0` at word 15
goes straight to the epilogue (word 272); retail goes to word 91, which is
`j <epilogue>` with `sw $zero,0x78C($s2)` in its delay slot. Ours is the
*jump-to-jump redirect* (`jump.c` `follow_jumps`), retail is not.

* **FALSIFIED:** `-fno-thread-jumps` on the real production `CC1PLPSX`
  (`C:/Temp/psq43/COMPILER/CC1PLPSX.EXE -quiet -O2 -G8 [-fno-thread-jumps]`)
  is **byte-identical** — the `bne $2,$0,$L551` is emitted either way.
  ⇒ `PER_FN_NO_THREAD_JUMPS` cannot help; the mechanism is `follow_jumps`
  inside `jump_optimize`, not the `thread_jumps` pass.
* Our `.s` (saved at `scratchpad/w63a15/cars_prod.s`, line 1290+) shows the
  target block IS `j $L551` preceded by `sw $0,1932($18)` — i.e. at jump.c time
  `next_active_insn(label)` should NOT have been a simple jump, so the redirect
  must be happening in a LATER `jump_optimize` run, after the store was moved.
* **NAMED ANGLE:** dump the RTL after each `jump_optimize` (`-dj`/`-dJ` on the
  instrumented cc1plus at `C:\Temp\nfs4-instr-cc1`) and find which run redirects
  the edge; the source-side lever is whatever keeps a non-jump insn at the head
  of that block through that run.

### 3.2 `STREAM_cancelrequest` (stream.c) — THE VOID-TAIL FENCE HAS A PRICE
Branch #13 is the ring-walk's **zero-trip guard** `beq $s4,$s6,…`:
retail → `.L800FD7BC` (the join, dist 66); ours → the intermediate
`j .L800FD7BC` block (dist 42).

Mechanism (this is the previously-unrecorded cost of the w50-a4 lever): the
in-source `__asm__("" : : "i"(0))` void-tail fence at the end of the
`if (u2 != 0)` arm sits between `Lexit:` and that arm's `j <join>`. That is
exactly what makes the loop-bottom inversion fire (`bne p,s6,head`, worth 2 gate
diffs) — **and it is the same precondition that blocks `follow_jumps` from
forwarding the zero-trip guard through `Lexit`**, which retail did.
So the fence buys a gate-visible win and pays a gate-INVISIBLE wrong edge.

* **NAMED ANGLE:** a device that keeps `Lexit` alive for the *inversion* check
  while still letting the GUARD's reference be forwarded — e.g. moving the fence
  to the head of the `else` arm, or (orchestrator lane) a
  `PER_FN_TEXT_MOVES`-style relocation. Both were out of budget here; nothing
  measured, so nothing falsified.
* **STANDING WARNING:** every `void-tail fence` landed by earlier waves should be
  re-checked with `brdist2` — the fence is a `follow_jumps` blocker by
  construction, so this class is likely NOT unique to `stream.c`.

### 3.3 `NFS3_CheckForFileOperations` (nfs3.cpp) — 8 @21/21
W62-A12's route was *"a source shape whose pre-loop test and loop test use
SIMULTANEOUSLY-LIVE pseudos (retail's `addu a1,a0,zero` is that overlap made
visible)"*. Executed and **FALSIFIED**:

```c
piVar1 = (int *)mgr->oparray;
if (piVar1 < (int *)mgr->handlearray) {     /* ANONYMOUS guard evaluation   */
   int *end = (int *)mgr->handlearray;      /* NAMED loop bound -> cse copy */
   do { … piVar1 = piVar1 + 1; } while (piVar1 < end);
}
```
= **8 diffs @21/21, byte-identical to the `for` baseline** (reverted).
The 13B trichotomy case (2) cure that cracked `FILE_cancelop` does NOT reach
here: cse folds the two `lw 0x1C` loads into ONE pseudo, so no copy insn is ever
created for local-alloc to keep apart. ⇒ the class is confirmed to be
**reload-side** (`-dg`: `Spilling reg 5. Spilling reg 6.`), not cse-side.
NEXT: the reload instrument (`order_regs_for_reload` / spill-reg pick), or a
device that makes the asm's two `"r"(0)` operands real allocated pseudos rather
than reload spill regs.

### 3.4 `SetupChunkBuildList` (bworld.cpp) — 7 @202/203 — **COUNT-EXACT BASIN FOUND**
The receipt in-source says *"the fences never change the COUNT (202 in every
case)"*. **That is now falsified**: a `volatile` on the count read

```c
totalVisChunks = (int)*(volatile u_char *)((char *)Track_gInViewCount + gCurrContext->currentChunk);
```

is the **first form that reaches 203/203** and it emits retail's exact prologue
order — `sll a0,a1,6 ; addu s3,v1,a0 ; addu v0,v0,a1 ; lbu ; nop` (the addu no
longer sinks into the load-delay slot). Cost: 18 diffs, because of the
**VOLATILE-QImode LAW** (a volatile QImode MEM cannot fuse its zero_extend, so
an extra `andi v0,v0,255` appears) plus the recolor it drags.
Reverted (7 < 18, honest-count rule) but **this is the right basin**: the open
question is now "a non-volatile scheduling barrier on the byte load", not
"which pass sinks the addu".

### 3.5 `Draw__25tPMenuItemLeftRightSliderb` (pausemenu.cpp) — 8 @171/169 — NEW BASIN
The in-source receipt's `step`-local basin gates 83 at **frame +8 bytes**.
A cheaper basin exists: keep the giv but move the existing read-only fence's
operand from `i * 5` to `xpos` (= `i*5 + 66`):

```c
xpos = i * 5 + 66;
__asm__("" : : "r"(xpos));    /* was "r"(i * 5) */
xpos += x;
```
= **81 diffs @170/169**. It reproduces retail's giv exactly — `li s7,66` +
`addiu s7,s7,5` + `addu fp,s6,s7` — at only **+1 insn** instead of the
`step`-local basin's +8 frame bytes, i.e. it is strictly the better base for the
qtytrace attack the receipt already names. Reverted (8 < 81) but recorded as the
structurally-correct basin.

### 3.6 `Sim_MainGameLoop`, `SimQueue_SetCurrentInput`, `intarcsin`
Re-gated (6 / 4 / 2) and their in-source receipts read in full. All three carry
multi-wave falsification maps whose named next step is an INSTRUMENT
(`-dS/-dR` layout pass; `-dl` local-alloc handout; qtytrace), not a spelling.
I added no new spellings — per the standing rule that spelling sweeps in a
receipted local-alloc/layout class are wasted budget. **No floor is claimed.**

### 3.7 Not reached this run
`Collide_DoActualObjectCollisionCheck` (14 @763/765 — ours 2 SHORT, so
structural, best remaining ROI in this belt), `Collide_TestObjectVertices`
(8 @1164/1164), `Stats_TrackEndGame` (44 @232/232, the W61 reqdelta job).
Baselines above are re-gated and current.

---

## 4. FILES / ARTEFACTS

* Committed: `recon/eaclib/psx/eacpsxz/nfile.c` (commit `68698aa9`).
* Reverted probes (tree clean): `nfs3.cpp`, `bworld.cpp`, `pausemenu.cpp`.
* `scratchpad/w63a15/brdist2.py` — the fixed branch-distance census.
* `scratchpad/w63a15/cars_prod.s`, `cars_nothread.s` — production-lane `.s`
  receipts for §3.1 (the `-fno-thread-jumps` falsification).

## 5. HAZARDS HIT

* The brief's eaclib paths say `.cpp`; the files are `.c` — `verify_asm` fails
  with a raw `cc1.exe: fatal error: no such file` (not a "NO ORACLE"), easy to
  misread as a broken fn.
* `scratchpad/w62a20/dumpfn.py` takes a `build/<rel>.i` key WITHOUT the `recon/`
  prefix while `tools/psyqproof.py` includes it — dumpfn dies with
  "no preprocessed input". Use psyqproof (it prints the differing words itself).
