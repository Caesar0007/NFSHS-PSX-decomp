# W63-A3 receipts — the libgpu vendor belt (`recon/syslib/psx/libgpu/SYS.c` + `FONT.c`)

Base `10e1a01b`. Gate = `tools/verify_asm.py` / `tools/tugate.py`, diff polarity `-` = ours,
`+` = oracle. Every variant ran through an ASSERTING prober (`scratchpad/w63a3/probe.py`,
`probe2.py`) that hard-fails on a missed anchor, so no reading below can be a fake "inert".
Syslib = Sony vendor-prebuilt ⇒ GATE-PARITY only (no psyqproof requirement).

## 0. Baselines (re-gated by me, both TUs) and finals

| fn | board row | re-gated baseline | final |
|---|---|---|---|
| `FntPrint` | 99.31% | **3** (239/240) | **2**, count now EXACT 240/240 — **PASS 240/240 with the one wiring row in §2** |
| `FntFlush` | 98.99% | **2** (199/199) | 2 (4 new angles falsified, §5) |
| `MoveImage` | 74.78% | **9** (45/46) | 9 (corpus deltas falsified, §3) |
| `PutDispEnv` | 98.99% | **38** (318/318) | 38 (not re-attacked, §7) |
| `_drs` | 98.67% | **10** (160/160) | 10 (§4) |
| `_dws` | 98.94% | **8** (143/143) | 8 (§4) |
| `_gpu_que_drain` | 92.99% | **14** (152/152) | 14 (sotn transplant falsified, §3) |
| `_set_draw_mode` | 98.75% | **2** (8/8) | 2 — certificate re-verified, NOT touched (§6) |

`tugate` after every landing, twice: `SYS.c 38/44` (unchanged, byte-identical to the
pre-session backup), `FONT.c 0/2 PASS` with FntFlush 2 / FntPrint 2. `tu_order_audit.py`
0 inversions. FONT.c stayed LF, 0 control bytes, 0 non-ASCII. Zero PASS→FAIL.

---

## 1. LANDED — `FntPrint` 3 → 2, count EXACT 240/240 (two source edits, commit `b0318853`)

### 1a. The `+nop` half: reorg's eager steal, blocked by a void-tail fence
Retail leaves the `beqz $a0` (`if (ch == 0) goto fnt_done;`) delay slot EMPTY; reorg steals
`percent`'s `li $s4,37` out of the FALL-THROUGH thread into it, so ours ran one instruction
short (239 vs 240). A **void-tail fence `__asm__("" : : "i"(0))` at the head of that thread**
is the documented instrument that reaches reorg (`stop_search_p` returns 1 at any asm) and it
is zero-insn here. Measured, all three identical at **2 diffs / 240 insns**: fence before the
`percent` block, fence inside it, read-only fence on `ch`. Kept the void-tail form (adds no
ref, names no value).

### 1b. The sentinel half: cse constant-sharing, broken by an identity launder
Retail materializes the trailing copy loop's sentinel FRESH (`addiu $a2,$zero,-1`); every
natural spelling gives us a COPY of the peel's -1 (`addu $a2,$v0,$zero`). Mechanism: at the
sentinel's **DEF** a register already holds -1 and cse substitutes it — an identity launder
protects USES, not the DEF, which is why a laundered sentinel declared INSIDE the guard is
still copied. Cure = born BEFORE the peel test + laundered, so cse can neither fold it back
nor feed it to the peel's own compare; both -1s are then materialized independently =
retail's exact instruction set.

FALSIFIED first (each gate-measured in this basin, all reverted):

| variant | diffs |
|---|---|
| control (comma-peel `while (len--, len != -1)`) | 2 |
| explicit peel, two literal `-1` | 2 |
| laundered sentinel declared INSIDE the guard | 2 |
| void-tail fence between peel and loop | 2 |
| read-only fence on `len` before the loop | 2 |
| peel spelled `len >= 0` (loses retail's own `li $v0,-1`) | 3 |
| un-laundered sentinel before the peel | 5 |
| laundered sentinel used in BOTH tests | 7 |
| double launder | 64 |

## 2. ORCHESTRATOR WIRING (probe-verified TWICE → `FntPrint` PASS 240/240)

After 1b the residual is a PURE ONE-LINE RELOCATION: `li $6,-1` belongs after the peel branch
(retail: `beq …; nop; addiu $a2,$zero,-1`), ours emits it before the `addiu $5,$5,-1`.

**ADD THIS KEY to the EXISTING `PER_FN_TEXT_MOVES["recon/syslib/psx/libgpu/FONT.c"]` entry**
(tools/build.py ~1192 — it already holds `FntFlush`; 12F: a duplicate rel key silently
shadows the earlier one):

```python
"FntPrint": [
    {"take":  r"\tli\t\$6,-1[^\n]*\n",
     "after": r"\tbeq\t\$5,\$2,\$L\d+\n"},
],
```

JSON copy: `scratchpad/w63a3/moves_fntprint.json` (emitted by `mk_moves.py`).
Verified with `tools/vprobe.py` + `W60_TEXT_MOVES_FILE`, run twice, identical:
`FntPrint: PASS (240 insns)`. Anti-drift control on the same harness with no moves file
reproduces the gate exactly (`FAIL 2 diffs`, same two lines), so vprobe is not drifting.
12F craft checks (counted inside the `.ent/.end FntPrint` region of the emitted `.s`):
`li $6,-1` 1 match, `beq $5,$2,$L\d+` 1 match, both label-agnostic, the `li` anchor tolerates
its trailing hex comment. The `beq` is in `.set reorder`, so maspsx's unconditional
branch-nop lands between the branch and the moved line = retail's exact shape.

## 3. CORPUS DIFF FIRST (the wave's mandated opening move) — results

Read before any dialing: `C:/Temp/psyz/decomp/src/libgpu/{sys.c,font.c}` (PSY-Q 4.0, matched),
`C:/Temp/ps1-decomp-refs/sotn-decomp/src/main/psxsdk/libgpu/{sys.c,font.c}` (matched, older
SDK), `C:/Temp/rage-racer-decomp/src/main/PAL/lib/libgpu/image_commands.c`, and
`scratchpad/w63a18/IDIOM_HARVEST.md` entries E6/E7/E10.

* **`MoveImage` (E7) — BOTH untried deltas FALSIFIED** on the authoritative 9-basin, all
  9 diffs / 45 insns (no movement whatsoever): psyz's guard phrasing `!r[2] || !r[3]`;
  RECT-typed guard reads `!rc->w || !rc->h`; psyz's dst word `(y<<16) | (u_short)x`; RR's
  `((u_long)y<<16) | ((u_long)x & 0xffff)`. Our payload reads are ALREADY the whole-word form
  the corpus agrees on. The W60/W62 diagnosis stands: the residual is the anonymous mask
  temp's `$v1` handout (06E gap), and the corpus cannot reach a register handout.
* **`_gpu_que_drain` (E6) — sotn `_exeque` shapes FALSIFIED.** Its goto-label back edge
  (`loop_1:` + `goto loop_1`, replacing our `for(;;)`) = **14, inert**; sotn's un-cached
  inline slot re-reads `_que.plain[_qout].func(_que.plain[_qout].arg, _que.plain[_qout].extra)`
  = **24**; both together = **24**. Note our body ALREADY satisfies the anti-eager-cache law
  the harvest highlights (three separate field reads, no cached `QueueItem *`). sotn's
  `_exeque` is a DIFFERENT SDK generation (null-func `printf` arm, `temp0/temp1/temp2`
  callback tail) — the CFG is not our function's.
* **`_dws`/`_drs`** were already rebuilt on psyz + RR in W52/W60; re-reading both corpora
  produced no unmined delta (the clamps, the signed `/2`, the `% 16`, the peeled loop and the
  two named spin masks are all already in-tree).
* **`FntFlush`/`FntPrint`**: psyz `font.c:303` FntFlush is matched (W52-A10 already mined it);
  **psyz leaves FntPrint as `INCLUDE_ASM`** (`font.c:434` is inside their `#else __psyz`
  branch), so there is no matched FntPrint body anywhere — our 240/240 shape is the only one.
  sotn's `font.c:91` FntFlush is an older SDK variant (no `~c` colour escape, no `unwrap`).

## 4. `_dws` (8) / `_drs` (10) — the §1b device transfers in FORM but NOT in POSITION

Residual composition (measured, uncapped): `_dws` = 4 parm-order + 2 mask + 2 sentinel;
`_drs` = 4 parm-order + 2+2 masks + 2 sentinel. The mask/sentinel 6 are the SAME
cse-constant-sharing class as §1b (`addu s3,v1,zero` vs `lui s3,1024`; `addu a0,v0,zero` vs
`li a0,-1`).

* **sentinel, laundered `neg1` born before the peel (the §1b cure): 8 → 12.** The FORM is
  fixed (`li $4,-1` appears) but the position moves, and here the relocation is NOT free:
  with the probe-verified TEXT_MOVES row (`take` `\tli\t\$4,-1\t[^\n]*\n`, `after`
  `\tbeq\t\$16,\$2,\$L\d+\n`) it lands at **9 diffs and 144 insns** — one MORE than the
  oracle's 143. Reason, read off the emitted `.s`: at its natural position that `li $4,-1`
  is FILLING A LOAD-DELAY SLOT (between `lw $2,0($17)` and `sw $2,0($3)`); moving it makes
  maspsx materialize a `#nop` there. Retail fills that slot with the loop decrement instead.
  ⇒ the §1b device is **site-conditional**: it is free only where the sentinel's `li` carries
  no load-slot duty (FntPrint), and the count bar rejects it here. NOT landed.
* **mask, laundered `readyMask` born before the guard: 8 → 41** (+1 insn and a whole-band
  rotation). Both edits together: 45. NOT landed.
* **parm (save,copy) emission order (4 diffs in each twin) — 6 more angles falsified**, all
  at 143/143: read-only fence on `rect` first (10), read-only fence on `data` first (10),
  `RECT *saved` declared FIRST (8, inert), `var_s4 = 0;` before `saved = rect;` (8, inert),
  identity launder on `rect` first (8, inert), identity launder on `data` first (8, inert).
  Retail emits the `$s1`←`$a0` pair before the `$s2`←`$a1` pair (assign_parms order); ours
  inverts them. Unchanged verdict: the 06E local-alloc/sched1 instrument gap.

## 5. `FntFlush` (2) — the reload-inheritance half, 4 NEW angles falsified

Residual is one line: ours `addu $a0,$a2,$zero` (reload INHERITANCE — gcc knows `$a2` still
holds `dr` after `sw $a2,16($sp)`), retail `lw $a0,16($sp)` (a real reload from the slot).
New this wave, all in the current basin: `__asm__("" : : "m"(*dr))` before the call **45**
(200 insns); `TermPrim(*(DR_MODE * volatile *)&dr)` **38** (199 insns — it DOES force the
reload, but re-slots the whole frame); `__asm__("" : : "m"(dr))` **20** (201 insns);
opacity launder on `dr` **45**. Together with W52/W53/W55/W61's list (direct
`TermPrim(&fs->draw_mode)`, dropping the local, void-tail fence, read-only fence, `volatile
DR_MODE *`, `DR_MODE * volatile`, the whole version ladder) this is a well-bounded
choose_reload_regs/inheritance certificate. NAMED NEXT ANGLE (unchanged): make the value
NON-inheritable at the call — i.e. get something else into `$a2` between the store and the
call — which needs a competing materialization to pin (the §1-style intruder device); there
is none in that block today.

## 6. `_set_draw_mode` (2) — certificate re-verified, untouched

Re-gated at 2 (8/8). The W62 certificate ("one commutative operand order; the register map
already matches; `set_preference` hands op0 the dest reg in find_reg pass 0, and in an
8-instruction leaf there is NO third live value to pin, so the conflict `prune_preferences`
would need cannot be manufactured") is exactly the brief's "no third value to pin" — I found
no NEW mechanism, so per the brief I did not spend budget on it.

## 7. `PutDispEnv` (38) — not re-attacked

The W62 landing (intruder-eviction fence at site 1) and its TEXT_MOVES row are both in the
tree and wired; 38 re-gated. Sites 2/3 are one joint problem in one basic block whose every
measured edit lands in the 134–148 basin (W62 §3). No corpus delta exists for it (psyz's
PutDispEnv is a different SDK generation: `CLAMP` macros + a `get_dx` helper + `RECT_EQ`,
and our overscan/mode structure already matches this oracle). Budget went to the two FONT.c
landings, the corpus diffs and the falsification maps above.

## 8. Catalog-row candidates (orchestrator to harvest)

1. **THE SENTINEL/CONSTANT cse-SHARING BREAKER, with its DEF-vs-USE rule (new, general).**
   Symptom: ours `addu rD,rS,zero` where retail materializes the same constant fresh
   (`li rD,K` / `lui rD,K>>16`), typically a loop sentinel or a spin mask that a nearby guard
   already materialized. Mechanism: cse substitutes a live equal register **at the constant's
   DEF**. ⇒ **an identity launder on the local is NOT enough — the local must be BORN BEFORE
   the competing materialization** (a laundered local declared inside the guard is still
   copied; measured 4 ways). With the def hoisted + laundered, both constants materialize
   independently. ⚠️ TWO site conditions: (a) the fresh `li` is then emitted at the DEF's
   position, so the residual becomes a one-line relocation (TEXT_MOVES) — FntPrint 3→PASS;
   (b) if the copy was ALSO filling a load-delay slot, the relocation costs a `nop` and the
   device is rejected by the count bar (`_dws` 8→9 at 144/143). Price the slot duty first.
2. **A void-tail fence at the FALL-THROUGH THREAD'S head blocks reorg's eager steal** — a
   second clean instance (FntPrint's `beqz` zero-check slot, ours-1-short → count-exact), and
   the three placements (before the block / inside it / read-only fence on the tested value)
   measure identically, so pick the one that adds no ref.
3. **A matched-corpus body from a DIFFERENT SDK GENERATION is a shape oracle only where the
   CFG matches.** sotn's `_exeque` (null-func printf arm + `temp0/1/2` callback tail) and
   psyz's `PutDispEnv` (`CLAMP`/`get_dx`) are the same *function names* as ours but not the
   same *code*; both transplants regressed or were inert. Check the oracle's block skeleton
   against the corpus body BEFORE porting, and prefer the generation closest to ours
   (PsyQ 4.0 psyz over the older sotn drop for libgpu).
4. **psyz's `libgpu/font.c` FntPrint is NOT matched** (it is `INCLUDE_ASM` outside their
   `__psyz` branch) — worth recording so no future belt re-mines it expecting a body.

## 9. Hazards hit

* **STALE RTL DUMPS in `build/**` are a trap.** `build/recon/syslib/psx/libgpu/FONT.c.i.{rtl,
  cse,loop,greg,…}` are left over from W61-A4's ladder probing and do NOT correspond to the
  current source (they still carry a `(not/xor)` sentinel device that is not in the file). I
  read one before noticing. Same family as the W62-A3 stale-`.s` incident: re-generate any
  dump you are about to reason from.
* **The emitted `.s` is CRLF while `build.py` reads it through universal newlines.** An
  anchor-counting script that opens it with `newline=""` fails to match `[ \t]*$` line ends
  and silently reports 0 hits — read `.s` files the way `_apply_text_moves` does.
* `git add` of the LF-only FONT.c warns "LF will be replaced by CRLF the next time Git touches
  it" (core.autocrlf) — do NOT `git checkout` the file to "fix" it.
* All landings written by asserting scripts with `newline=""` (never the Edit tool), then
  byte-scanned for CR / control bytes / non-ASCII drift.

## 10. Files and artifacts

* Touched: `recon/syslib/psx/libgpu/FONT.c` only (committed, `b0318853`).
  `SYS.c` byte-identical to `scratchpad/w63a3/SYS.c.bak0` (verified).
* Backups: `scratchpad/w63a3/{FONT.c.bak0,SYS.c.bak0}`, `RESTORE.bak` (last probe base).
* Tools left in `scratchpad/w63a3/`: `probe.py` / `probe2.py` (asserting multi-edit variant
  probers, the second prints the uncapped diff), `probe_moves.py` (source variant + a
  `PER_FN_TEXT_MOVES` JSON through `vprobe`, N runs — **promotion candidate**), `show.py`,
  `dumps.py` (variant → emitted `.s` window), `sbs.py`, `anchors.py` (12F anchor counter,
  region-scoped), `mk_moves.py` / `mk_moves2.py`, `land_a1.py` / `land_b7.py`,
  `spec_*.py` (every measurement above), `moves_fntprint.json` (the wiring row),
  `moves_dws.json` (the rejected one, kept as the receipt).
* No git operations outside my own TU; `tools/*.py`, maspsx and the memory dir untouched.
