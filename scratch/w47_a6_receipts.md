# w47-a6 receipts — pad.c + the unclaimed eaclib singles

Base `ba09f774`, worktree `C:/Temp/nfs4-wt47-a6`, branch `w47-a6`.
Worklist `C:\Temp\nfs4-clean\eaclib_fails_2026-08-03_w47.txt` (58 rows).

## 0. CLAIMED SET (enumerated from the worklist, a1-a5 subtracted)

a1 = nfile(9) · a2 = spchpick(6)+spchrule(2)+spchevnt(2) · a3 = salloc/slib/sdpacket/spktplay(8)
a4 = sserver/sdmemman/sdresolv/ssysserv/smemman/sbdload/sdma(9) + the sndpsxz singles
     (sbhdrcpy SNDbankheadercopy, sst iSNDstreamparsedata)
a5 = stream/cdfs/nsync/trnsmult(8) + the eacpsxz singles
     (syncfile, asinfunc, resize, setfont, fileroot, unref, vramfxya)

⇒ **a6 = 5 rows**: pad.c ×3 (padinit, PAD_state, PAD_update) + the two UNCLAIMED
spchpsxz singles **spchbank iSPCH_BankMemAlloc** and **spchinit SPCH_Init**
(a2 took only spchpick/spchrule/spchevnt).

## 1. RE-GATED BASELINES (verify_asm; the worklist fuzzy% is wrong as always)

| fn | TU | worklist% | re-gated |
|---|---|---|---|
| padinit | eaclib/psx/pad.c | 94.29 | FAIL 3 (ours 27 / oracle 28) |
| PAD_state | pad.c | 94.00 | FAIL 4 (20/20) |
| PAD_update | pad.c | 88.24 | FAIL 9 (65/66) |
| iSPCH_BankMemAlloc | spchpsxz/spchbank.c | 93.58 | FAIL 4 (33/33) |
| SPCH_Init | spchpsxz/spchinit.c | 85.64 | FAIL 3 (40/39) |

Whole-TU context (unchanged by this wave): pad.c 2/5 PASS (PAD_restore, PAD_convert);
spchbank.c 7/8 PASS; spchinit.c 6/7 PASS. **No source file was modified — 0 regressions.**

## 2. HEADLINE — the residual of 4 of my 5 fns is ONE named toolchain gap, now PROVEN

methodology §3.25 axis 3b and the in-source w34-a9 receipt in `spchinit.c` both
say maspsx lacks the *scheduling* half of ASPSX 2.77's `.set reorder` mode. This
wave that stopped being a hypothesis: I built an ASPSX-reorder EMULATOR
(`scratch/w47_a6_aspsxreorder.py`, a probe-only cc1→maspsx interposer) and it
takes the functions to **byte-exact PASS**.

| fn | default gate | with the emulation | flags needed |
|---|---|---|---|
| padinit | 3 | **PASS (28)** | `-fno-delayed-branch` |
| PAD_restore | PASS | **PASS (21)** | `-fno-delayed-branch` |
| PAD_state | 4 | **PASS (20)** | `-fno-delayed-branch` |
| PAD_convert | PASS | **PASS (5)** | `-fno-delayed-branch` |
| PAD_update | 9 | 7 (65/66) | `-fno-delayed-branch` |
| SPCH_Init | 3 | **PASS (39)** | none (default) |
| (spchinit.c whole TU) | 6/7 | **7/7** | none |

⇒ **pad.obj toolchain identity: `-fno-delayed-branch` + ASPSX slot filling.**
   **spchinit.obj: default flags; only ASPSX's epilogue-`$ra` reschedule is missing.**

### 2a. The ASPSX `.set reorder` rules the retail bytes actually prove

Each rule below was forced on me by a counter-example; the emulator implements
exactly these and nothing more.

1. **Backward fill.** A branch/jump left empty in reorder mode takes the nearest
   preceding single machine instruction that can legally sink past the
   instructions between. (padinit: `addu $5,$4,8` → `jal PadInitDirect`.)
2. **Macros are never split, but they ARE stepped over.** padinit's `jal addtimer`
   skips `la $4,PAD_update` (2 insns) and reaches one further back for
   `sw $2,0($16)` — exactly retail.
3. **Never sink an `$sp`/`$gp` writer into a slot.** This is what leaves the
   retail epilogue as `addiu $sp; jr $ra; nop` instead of gcc's
   `jr $ra; addiu $sp`. Without this rule padinit/PAD_restore score 6 instead of 0.
4. **Forward fill for conditional branches and plain `j` only — never for calls.**
   PAD_state's two `beqz` slots hold the FOLLOWING `sltiu`/`sll`; padinit's
   `jal PadStartCom` slot stays `nop` although `addu $a0,$s0,$zero` followed it.
   (A whole-file assembler can prove the moved value dead on the taken path; an
   argument register moved before a `jal` would be visible to the callee.)
5. **`#nop` (gcc's load-delay placeholder) is resolved by RESCHEDULING, but only
   for the epilogue `$ra` restore.** SPCH_Init hoists `lw $ra,0x10($sp)` three
   instructions up. A GENERAL load hoist is **FALSIFIED** by padinit, which keeps
   `lw $v0,0($s0) / nop / bnez $v0` even though `sw $ra,0x14($sp)` sat above it
   and was a legal thing to cross.
6. **The hoist stops below a `lui`+`ori`/`addiu` 32-bit constant pair** (one unit
   to the assembler). Without this, SPCH_Init's `lw $ra` overshoots to just after
   the `jal` (2 diffs); with it, it lands exactly where retail has it.
7. Memory disambiguation is real: a frame load crosses a store through a
   *different* base register (SPCH_Init crosses `sw $v1,%lo(gSPCH_Initialized)($v0)`).

### 2b. Falsified on the way (basins stated)

* **`-fno-delayed-branch` ALONE on pad.c** (basin: current pad.c source, maspsx
  2.77 with no slot filling): 3/4/9 → 9/8/25, PAD_convert PASS→3. The flag is
  right but is *worthless without* the assembler half — which is why every
  earlier per-fn `-fno-delayed-branch` splice probe in the in-source receipts
  ("padinit … 3 → 12", "iSPCH_BankMemAlloc 4 → 23") read as a falsification of
  the FLAG when it was really a falsification of the flag *alone*.
* **Maximal load hoisting** — see rule 5.
* **Filling the return's slot with the sp-adjust** — see rule 3.

### 2c. What it would take to LAND this (not landable this wave)

Two changes, both outside a1-a6's remit (`tools/build.py` is off-limits, and
`C:/Temp/maspsx-master` is shared by every worktree):

```python
# tools/build.py, PER_TU_FLAGS
"recon/eaclib/psx/pad.c": {"no_delayed_branch": True},   # + the maspsx filler below
```
and a `--aspsx-reorder` mode in maspsx implementing §2a. `scratch/w47_a6_aspsxreorder.py`
is a working reference implementation (≈240 lines, no repo deps) with the rule
provenance in comments. **Predicted yield beyond my 5 rows:** the whole documented
"epilogue swap" class (methodology §3.25 3b names ~25 syslib fns:
StopCARD, _card_open/_close, CdSync, CdReady, CdFlush, CdDataSync, DMACallback,
VSyncCallbacks, InterruptCallback, ResetCallback …) plus every fn whose only
residual is a lone `nop` between the epilogue `lw $ra` and `jr $ra` — the w34-a9
receipt already predicted "a lone trailing nop there is ALWAYS this, never a
source shape", and SPCH_Init now confirms it end-to-end.
**A tree-wide census of `-fno-delayed-branch` objects (the `addiu $sp; jr $ra; nop`
signature) is the natural companion to a7's `-G` census.**

## 3. PER-FN LEDGER

### padinit / PAD_state / PAD_convert / PAD_restore — SOLVED-IN-PRINCIPLE
Byte-exact under the proven identity (§2). Nothing source-side left.

### PAD_update — 9 (default) / 7 (under the identity)
The 7 are the two items the in-source receipt already names, plus one nop:
1. (4) prologue emission order — retail's `sw $s0/addu $s0,$zero,$zero` pair sits
   after the `$s2`/`$s1` pairs (all three are loop.c givs, emitted in reverse
   creation order); ours is a real source biv, emitted first.
2. (2) `addu $a3,$t0,$zero` vs retail `addu $a3,$zero,$zero` — cse reuses `i`'s
   just-materialised 0 for `btnOff`'s; retail's two zeros are independent because
   its `btnOff` is a giv whose preheader init has no live 0 to reuse.
3. (1) a load-delay nop downstream of 1/2.
**NEW FALSIFICATION (this wave, basin = current pad.c + default flags):** dropping
`btnOff` entirely and indexing `((byte*)gPadinfo.buf)[i * 8]` — the obvious way to
turn retail's giv into a giv on our side — **regresses 9 → 20** (64/66). Reverted.
So items 1+2 are not reachable by making `btnOff` derived; they are loop.c
biv-vs-giv creation order.

### SPCH_Init — SOLVED-IN-PRINCIPLE
`lw $ra` reschedule only; PASS 39/39 under §2a rule 5+6. The in-source w34-a9
root-cause note is confirmed *and* now has a reproducing implementation.

### iSPCH_BankMemAlloc — 4 diffs at exact 33/33 parity, PARKED with a new angle
Residual is which prologue store lands in the first `bnez`'s delay slot:
retail `sw $ra,0x18($sp); bnez $v0; sw $s1,0x14($sp)⟨slot⟩; lui $s1,%hi(gNumBanks)`
vs ours `sw $s1; lui $s1; bnez; sw $ra⟨slot⟩`. Coloring is ALREADY correct
(`$s0`=gVoxBanks, `$s1`=gNumBanks, as retail); only the position of
`lui $s1,%hi(gNumBanks)` (before vs after the branch) differs, and that decides
what dbr finds nearest.
**Flag-axis probes, all FALSIFIED (whole-TU, this wave):**
`no_schedule_insns` 4→4 but breaks iSPCH_SetCycleBits (PASS→9);
`no_schedule_insns2` 4→7 and breaks 3 more; `no_strength_reduce` 4→4, no change
anywhere (neutral). `-fno-delayed-branch` is excluded on principle here: this
object's epilogue is `jr $ra; addiu $sp` (gcc-filled) so spchbank.obj is a
delayed-branch-ON object, unlike pad.obj.
**NEW NAMED ANGLE (unspent, for the next wave): "sink the lui, then re-lengthen".**
The two known one-sided moves are (a) init at the top → lui hoisted above the
branch (today's 4 diffs) and (b) init sunk into the `if` → lui lands where retail
has it BUT `nb` shortens and steals `$s0` (16 diffs, w34-a9). Nobody has tried
(b) **plus** catalog row-42's live-range-LENGTHENING read to hand `$s0` back to
`vb` — i.e. sink `nb = gNumBanks;` into the if-body *and* add one late reference
to `nb` after the zero-fill loop so its live length exceeds `vb`'s again. That is
a two-lever composition, and each lever alone is already measured, so the
prediction is checkable before probing (qtyprio/allocsim on both allocnos).

## 4. FLAG-AXIS SUSPICIONS (for a7/a8/a9)

| TU | suspicion | evidence |
|---|---|---|
| `recon/eaclib/psx/pad.c` | **`-fno-delayed-branch` — CONFIRMED, not a suspicion** | every epilogue is `addiu $sp; jr $ra; nop`; 4/5 fns byte-exact once the assembler half is emulated |
| `recon/eaclib/psx/spchpsxz/spchinit.c` | default flags; assembler-side only | epilogues are gcc-filled (`jr $ra; addiu $sp`) |
| `recon/eaclib/psx/spchpsxz/spchbank.c` | default flags | same gcc-filled epilogue; 3 flag probes all neutral-or-worse |

**Cheap tree-wide screen for a7/a8:** an object built `-fno-delayed-branch` shows
`addiu $sp,$sp,N` / `jr $ra` / `nop` at EVERY non-leaf epilogue in its oracle,
while a delayed-branch-ON object shows `jr $ra` / `addiu $sp,$sp,N`. One grep over
`asm/nonmatchings/**` classifies every object in the image, exactly as the `-G`
threshold signature does for small-data.

## 5. TOOLS ADDED (probe-only, nothing in the build path)

* `scratch/w47_a6_aspsxreorder.py` — ASPSX 2.77 `.set reorder` emulator over a cc1
  `.s`; rule provenance in the docstring/comments. Reference implementation for a
  future `maspsx --aspsx-reorder`.
* `scratch/w47_a6_verify_flag.py` — `verify_asm` with two probe hooks:
  `NFS4_A6_FLAGS=key[,key…]` injects PER_TU_FLAGS keys **without touching
  tools/build.py**, and `NFS4_A6_ASPSX=1` splices the emulator between cc1 and
  maspsx. Probe objects go to their own `build/a6probe_*` tree so they can never
  clobber the real gate's objects.

  ```
  NFS4_A6_ASPSX=1 NFS4_A6_FLAGS=no_delayed_branch \
    python scratch/w47_a6_verify_flag.py recon/eaclib/psx/pad.c padinit,PAD_state,PAD_update
  ```

## 6. BUGS / HAZARDS HIT

* **The C: volume was 100% full when this worktree was created** (`git worktree add`
  died with "No space left on device"; `df` showed 12 MB, then 7.6 MB as sibling
  agents built). It recovered to ~2 GB and the retry succeeded, but free space
  oscillated by GBs during the wave — a `worktree add` failure this wave is almost
  certainly this and not a git problem. `git worktree prune` + `git branch -D w47-aN`
  before retrying (the failed attempt leaves the branch behind).
* `scratch/` is in `.gitignore` — receipts need `git add -f`.
* Source files are **CRLF**; a `\n`-joined `old` string in a python patch silently
  fails its `assert`. Use `tools/crlf_edit.py` or join with the detected newline.
