# W84-C1 receipt — FntFlush (syslib/psx/libgpu/FONT), board row 1/4

## Setup (done)
- `recon/syslib/psx/libgpu/FONT.c` is USER-LIVE (uncommitted probes) — **never edited**.
  Working copy: `scratchpad/w84/C1_FONT.c` (verbatim copy of the live file).
- Gate: `scratchpad/w84/C1_verify.py` = copy of `tools/verify_asm.py` + three additions
  (no tool edits in-tree):
  1. `ROOT = parent.parent.parent` (copy sits two levels deeper).
  2. `sys.path.insert(0, ROOT/'tools')` so build.py's `import fix_symsizes` resolves.
  3. **lane aliasing** (verify_region.py L118-130 pattern): the candidate is copied to
     `recon/syslib/psx/libgpu/FONT__c1_gate.c` (beside the base TU, so sibling includes +
     dir-prefix class rules resolve) and every module-level dict in `bld` keyed by
     `recon/syslib/psx/libgpu/FONT.c` gets the same value under the temp rel path.
     Env `C1_LANE_AS` overrides the aliased base path. Temp deleted in `finally`.
- Command:
  `python scratchpad/w84/C1_verify.py scratchpad/w84/C1_FONT.c FntFlush,FntPrint`

## BASELINE (certificate reproduced)
```
FntFlush: FAIL 6 diffs (ours 199 / oracle 199)   <- count-EXACT, 6 words
    +sw a2,28(sp)  +sw a2,32(sp)                 (ours emits the pair later)
    -sw a2,28(sp)  -sw a2,32(sp)
    -addu a0,a2,zero        (oracle: copy a2 -> a0)
    +lw a0,16(sp)           (ours: reload a0 from the frame slot)
FntPrint: PASS (240 insns)
```
Lane in force for this TU (build.py FLAGS row): `jtbl_at_fusion`, `nop_before_label`,
`no_split_addresses`; TU compiler = CC1PSX (C lane).

## NEW ANGLE (user-flagged): retail FntPrint rung fingerprint
Premise: the 6 retail regionals link a DIFFERENT FONT.OBJ vintage — `FntPrint` is CHANGED in
all 6 regions while `FntFlush` stayed LO16. `regiondiff/oracles/NFS4-R-*/FntPrint.s` therefore
carries the retail FONT.OBJ's codegen. If one retail cc1 rung reproduces the retail FntPrint
from our FONT.c source, that rung is direct evidence about the retail FONT.OBJ toolchain and
may transfer to FntFlush's 6-word residual on the BASE oracle.

### 🔴 RESULT 1 — THE LEAD IS FALSIFIED (hard numbers, all 6 regions)
`regiondiff/oracles/NFS4-R-*/FntPrint.s` is **structurally identical to the base oracle**
`asm/nonmatchings/main/FntPrint.s` — same 243 words, same opcode+register fields everywhere.

Word-level compare (raw 32-bit encodings; base .s stores them byte-swapped, regional .s
big-endian-rendered — both decoded before comparing):

| region | words | word diffs | of those, immediate-only (opcode+regs identical) | STRUCTURAL |
|---|---|---|---|---|
| NFS4-R-AU | 243 | 14 | 14 | **0** |
| NFS4-R-FR-DE | 243 | 14 | 14 | **0** |
| NFS4-R-JPN | 243 | 14 | 14 | **0** |
| NFS4-R-UK-ES-IT | 243 | 14 | 14 | **0** |
| NFS4-R-UK-SW | 243 | 14 | 14 | **0** |
| NFS4-R-USA | 243 | 14 | 14 | **0** |

All 14 differing words are `lui/lw/sw/addiu` halves of moved-data `%hi/%lo` pairs plus the two
`jtbl_8005xxxx` halves (`jtbl_80057078` base -> `jtbl_80057848` USA) — i.e. pure relocation
addends. The only textual "differences" in a rendered diff are cosmetic: base `.s` prints
`%hi(SYM)`/`addu r,r,zero`/`addiu r,zero,N`/`(3435973837 >> 16)` where the regional slice prints
raw immediates/`move`/`li`/`52428`, and `jal strlen` vs `jal func_800EA8D0` (same VA, no symbol
names in the regional slice).

**Root cause of the "CHANGED" label:** `regiondiff/oracles/*/INDEX.tsv` splits FntPrint into a
138-word head plus three `MERGED-INTO:FntPrint` tails (30 + 8 + 67 = 105; 138+105 = 243). The
CHANGED verdict was computed on the 138-word partial slice, whose trailing relocated words made it
look modified. **The retail regionals link the SAME FONT.OBJ codegen as the beta.**

CONSEQUENCE: FntPrint cannot fingerprint a different retail FONT.OBJ rung — there is no different
retail FONT.OBJ. The regional axis is closed for the WHOLE FONT TU (FntFlush LO16 *and* FntPrint
structurally identical), which independently re-confirms the hub's "the 4 remaining certificates
are LO16 EVERYWHERE" line and retires this lead.
Script: reproduced inline (raw-word decode + `(x>>16)!=(y>>16)` structural test).

### FntFlush residual, exactly (for the record; `C1_vdiff.py`)
```
ours                                oracle
  addiu sp,sp,-80                     addiu sp,sp,-80
  li a2,128                           li a2,128
                                      sw a2,28(sp)      <- retail: colour stores at the TOP
                                      sw a2,32(sp)
  sw ra,76(sp) ... sw zero,20(sp)     sw ra,76(sp) ... sw zero,20(sp)
  sw a2,28(sp)   <- ours: sched2      bltz a0,T
  sw a2,32(sp)      carried them down
  ...
  addu a0,a2,zero  <- ours            sw a2,16(sp)
  sw a2,16(sp)                        lw a0,16(sp)      <- retail keeps the raw spill+reload
```
This is exactly catalog **30E-3**: our `.greg` (post-reload, pre-`reload_cse_regs`) already holds
retail's `sw a2,16(sp); lw a0,16(sp)` pair AND retail's two top-of-function colour stores;
`reload_cse_regs` then rewrites the reload into `move a0,a2` and sched2 carries the stores down.
ONE pass, six words of fallout.

---

## NEW ANGLE (mine, replacing the dead one): CLUSTER-RESOLVED RUNG FINGERPRINT
Instead of scoring a rung by TOTAL diff count (which conflates 2.7-era codegen deltas with the
`reload_cse_regs` identity), score every rung on the two independent predicates that MAKE UP the
residual, plus a **sp-blind / sp+reg-blind** decomposition (catalog 30E-2's instrument, rebuilt so
it works on a lane-aliased scratch sibling).

Tools written (scratchpad/w84/, none of them tool edits):
- `C1_rungsweep.py`  — P1/P2 predicate sweep over the ladder + retail rungs.
- `C1_dump.py`       — prints OUR normalized emitted stream, index-numbered.
- `C1_spblind.py`    — strict / sp-blind / sp+reg-blind diff counts.
- `C1_spdiff.py`     — sp-blind unified diff.
- `C1_vdiff.py`      — full untruncated diff (vdiff.py re-pointed at C1_verify.py).
Probe hooks added to `C1_verify.py` only: `C1_EXTRA_CC1_FLAGS`, `C1_DROP_CC1_FLAGS`, `C1_CC1_BIN`.

### RESULT 2 — the rung sweep (`NFS4_FORCE_CC1_VER`, TU's real maspsx lane, cc1 swapped only)
| rung | FntFlush | FntPrint | P1 `reload_cse` | P2 colour stores |
|---|---|---|---|---|
| TU lane (2.8.1-sn, wired) | FAIL 6 @199/199 | PASS 240 | FIRED (`move`) | carried down |
| 2.6.0 | FAIL 102 @201 | FAIL 184 | raw `sw;lw` | **TOP** |
| 2.6.3 | FAIL 98 @201 | FAIL 184 | raw `sw;lw` | **TOP** |
| **2.7.2** | FAIL 85 @200 | FAIL 168 | **raw `sw;lw`** | **TOP** |
| 2.7.2-970404 | FAIL 31 @200 | FAIL 63 | **FIRED** | carried down |
| 2.8.0 | FAIL 6 @199 | PASS 240 | FIRED | carried down |
| 2.8.1 | FAIL 6 @199 | PASS 240 | FIRED | carried down |
| 2.91.66 | FAIL 178 @205 | FAIL 246 | FIRED | carried down (frame 88) |
| 2.95.2 | FAIL 152 @195 | FAIL 235 | (body too different to read) | — |
| 2.8.1-sn (retail PsyQ 4.4/4.5) | FAIL 6 @199 | PASS 240 | FIRED | carried down |
P1/P2 were read BY HAND off `C1_dump.py` for 2.6.0/2.6.3/2.7.2/970404/2.8.x/2.91.66 (the sweep
script's automatic P2 column keys off the 2.8 slot numbers and mis-reports the sub-2.8 rungs,
whose frame is 120 — the hand dumps are the authority). **P1 and P2 flip together on exactly the
rungs that lack `reload_cse_regs`**, which is the whole point: they are ONE defect, confirming
catalog 30E-3 on retail-only evidence.

### 🔴 RESULT 3 — CORRECTION to catalog 23A-2's version fingerprint
23A-2 / the FONT.c header both record "2.6.x/2.7.2 LACK `reload_cse_regs` entirely" and imply the
pass is a **2.8** marker. **It is not.** Measured at the site (`C1_dump.py`, indices 42-44):

```
2.7.2        43 sw a2,16(sp)      44 lw a0,16(sp)        <- pass ABSENT (retail's form)
2.6.3        43 sw a2,16(sp)      44 lw a0,16(sp)        <- pass ABSENT
2.7.2-970404 42 addiu a2,s3,16    43 addu a0,a2,zero  44 sw a2,16(sp)   <- pass PRESENT
2.8.0/2.8.1  42 addiu a2,s3,16    43 addu a0,a2,zero  44 sw a2,16(sp)   <- pass PRESENT
```
**LAW: `reload_cse_regs` is already live in the 2.7.2-970404 snapshot.** The boundary is between
the gcc-2.7.2 RELEASE and the 970404 snapshot, not at 2.8. Source basis: `reload_cse_regs` is
called from `toplev.c:3501` under a bare `if (optimize > 0)` — no `-f` switch — and
`reload_cse_simplify_set` (reload1.c:8178) is gated only by `MEMORY_MOVE_COST >= 2` and
`REGISTER_MOVE_COST == 2`, both hard-wired on MIPS (mips.h:3172/3188 — `REGISTER_MOVE_COST
(GR_REGS,GR_REGS)` is the literal `2`, `MEMORY_MOVE_COST` is 4, or 6 for r4000/r6000). So the pass
is not reachable by ANY flag on ANY rung; only its ABSENCE from a binary can help.

### 🏆 RESULT 4 — THE CERTIFICATE IS NOW PROVABLE WITH **RETAIL BINARIES ONLY**
The W76-A15 sufficiency proof used the BANNED self-built `2.8.1-norcse` cc1. The same proof now
exists on a stock ladder rung. Under **gcc-2.7.2** (pass absent) the emitted prologue is retail's
topology verbatim, and both certificate clusters are GONE:
```
ours @2.7.2                          retail (oracle)
  addiu sp,sp,-120                     addiu sp,sp,-80
  li    a2,128                         li    a2,128
  sw    a2,40(sp)   <- colour          sw    a2,28(sp)
  sw    a2,48(sp)      stores FIRST    sw    a2,32(sp)
  sw    ra..s0 (10 saves)              sw    ra..s0 (10 saves)
  sw    zero,24(sp)                    sw    zero,20(sp)
  bltz  a0,T                           bltz  a0,T
  sw    a2,56(sp)   <- b in the slot   sw    a2,36(sp)
  ...                                  ...
  43 sw a2,16(sp)  44 lw a0,16(sp)     sw a2,16(sp) ; lw a0,16(sp)
```
⇒ the residual is confirmed to be exactly `reload_cse_regs` and its sched2 fallout, with no
appeal to a self-built compiler. The user's retail-purity ruling costs the project nothing here.

### 🔑 RESULT 5 — THE 2.7.2 LANE'S REJECTION IS RE-QUANTIFIED, AND ITS STATED REASON IS WRONG
FONT.c's header dismisses the pre-`reload_cse` rungs with "those rungs lose the whole-fn shape".
Scored **sp-blind** they do not:

| rung | ours/oracle | strict | sp-blind | sp+reg-blind |
|---|---|---|---|---|
| wired 2.8.1 | 199/199 | 6 | 6 | **2** |
| **2.7.2** | **200**/199 | 43 | **8** | **5** |
| 2.6.3 | 201/199 | 54 | 20 | 16 |
| 2.7.2-970404 | 200/199 | 21 | 21 | 9 |
(`strict` here is `C1_spblind.py`'s SequenceMatcher metric, not verify_asm's; use it only for the
column-to-column comparison. verify_asm's own numbers are in RESULT 2.)

The 2.7.2 lane's 85-diff headline is almost entirely **stack-displacement noise**. Its sp-blind
residual is only three clusters:
1. `addiu sp,sp,-120` vs `-80` (frame size);
2. a 5-word `a1`/`a0` colouring + `sb`/`sll` schedule swap in the glyph u/v block;
3. the epilogue `addiu sp; jr ra; nop` vs `jr ra; addiu sp` (the known epilogue-vintage class).

**ROOT CAUSE OF THE FRAME GAP, measured (slot maps via `C1_dump.py`):**
```
2.8 lane  locals 16 20 24 28 32 36 | saves 40..76   frame 80   <- 4-byte packed, == retail
2.7.2     locals 16 24 32 40 48 56 | saves 80..116  frame 120  <- 8-byte STRIDE
```
gcc-2.7.2's reload gives every spill slot an 8-byte stride; 2.8 packs them at 4. Six slots x 4
bytes + the 16-byte re-alignment of the save area = exactly the 40-byte delta. That is a
compiler-version property of `alter_reg`/`assign_stack_local`, not a source property — so the
2.7.2 lane is genuinely closed, but now **for a named, measured reason** instead of a vague one.
Corollary: retail's compiler packs spill slots like 2.8 AND lacks `reload_cse_regs` — i.e. a
2.8-shape dev snapshot from the window (2.7.2 release .. 970404). No such binary exists on disk.

### RESULT 6 — TWO PREVIOUSLY-UNSWEPT AXES, BOTH CLOSED
**(a) MIPS `-m` flag axis** (the recorded W76 sweep is all `-f*`; `-m*` had never been measured):
| flag | FntFlush | FntPrint |
|---|---|---|
| (none) | 6 @199/199 | PASS |
| `-mcpu=r4600` | 6 @199/199 | PASS (inert) |
| `-mno-gpopt` / `-mmemcpy` / `-mstats` / `-mrnames` | 6 @199/199 | PASS (all inert) |
| `-mcpu=r4000` / `-mcpu=r6000` | 142 @205/199 | FAIL 29 |
| `-mcpu=r3900` | 29 @198/199 | FAIL 72 |
| `-mcpu=r8000` | 33 @200/199 | FAIL 29 |
`-mcpu` reaches only `MEMORY_MOVE_COST` (4 -> 6) and `BRANCH_COST`; both stay >= 2, so the
`reload_cse` gate never opens. **Axis closed.**

**(b) RETAIL cc1 BINARY CENSUS** (md5 over psq43/psq44/psq45/psq47/psyq400/psyq_sdk-master/ladder).
Distinct C compilers found, and their status:
| md5 (12) | size | path | status |
|---|---|---|---|
| f6ceb8939f92 | 1446912 | psq43/COMPILER/CC1PSX.EXE | 2.8.0 SN32 4.0.0007 — wired lane family |
| 91bf9c08cbdf | 1447936 | psq44/pssn/bin, psq45/BIN, psyq_sdk 4.4 | 2.8.1 SN32 4.0.0010 = wired rung; **6 @199** |
| e88ab168d074 | 1409024 | psyq400/COMPILER, psyq_sdk 4.3 | 2.7.2 SN32 3.7 (raw40 lane; W76: 84, frame 120) |
| **c9f8626ec07c** | **1598464** | **psq45/BIN/WIN/CC1PSX.EXE** | **NEVER TRIED — measured here: 178 @205/199** |
| 8ef6f044eda5 | 1293312 | psq43/44/45 `DOS/CC1PSX.EXE` | 2.7.2.SN16 — 16-bit DOS, will not execute on Win10 |
| 14cce3bf6baa | 1289216 | psyq400/COMPILER/DOS | 16-bit DOS, will not execute |
psq47 ships **no** CC1PSX. ⇒ the retail C-compiler census is now **exhaustive on this box**: no
untried retail binary owns the shape, and the newly-found psq45 WIN build is a 205-insn/frame-88
codegen (2.6/2.7-era), not a candidate. **Axis closed.**

---

## FINAL STATUS
- **FntFlush: FAIL 6 @199/199** (unchanged — the row is a certificate, and this belt did not
  spend its budget re-confirming it: it killed the assigned lead, corrected a banked law, and
  closed two axes).
- **FntPrint: PASS 240/240.**
- Gate command (reproduces both numbers):
  `python scratchpad/w84/C1_verify.py scratchpad/w84/C1_FONT.c FntFlush,FntPrint`
- **`recon/syslib/psx/libgpu/FONT.c` was never opened for writing** — `diff -q` against
  `scratchpad/w84/C1_FONT.c` is IDENTICAL, `git status` shows only the user's pre-existing ` M`.
  No temp `FONT__c1_gate.c` remains (deleted in `finally`). No git ops, no tool edits, no memory
  edits, no volatile/asm, retail compilers only.

## FALSIFIED / CLOSED THIS BELT (so the ground is not re-walked)
1. **The assigned FntPrint-regional-vintage lead** — 0 structural diffs in all 6 regions (RESULT 1).
2. **`reload_cse` is a 2.8 marker** — false; live at 2.7.2-970404 (RESULT 3).
3. **MIPS `-m` flag axis** — 10 cells, all inert or catastrophic (RESULT 6a).
4. **Retail cc1 binary census** — exhaustive; psq45/BIN/WIN newly measured at 178 (RESULT 6b).
5. **"the sub-2.8 rungs lose the whole-fn shape"** — refuted as stated; 2.7.2 is sp-blind **8**
   and its rejection is specifically the 8-byte spill-slot stride (RESULT 5).

## NAMED NEXT ANGLE (for whoever picks this row up)
The only unexhausted direction is the one RESULT 5 sharpens: retail's compiler = **4-byte spill
slot packing (2.8 `alter_reg`) + no `reload_cse_regs`**, a snapshot in the window
[gcc-2.7.2 release .. 970404]. Acquisition targets are therefore dated precisely: a PSY-Q/SN
Systems C compiler drop between PsyQ 4.0 (2.7.2 SN32 3.7) and PsyQ 4.3 (2.8.0 SN32 4.0.0007) —
i.e. a **PsyQ 4.1 CC1PSX** (4.2 is confirmed never to have existed, w81/A14). That is a
single-artifact acquisition, not a search.


