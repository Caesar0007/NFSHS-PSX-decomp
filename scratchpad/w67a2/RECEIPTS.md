# W67-A2 RECEIPTS — BYTE-TRUTH EXPLOITATION, LIBETC + LIBGPU (2026-08-15)

Repo `C:\Temp\nfs4-decomp`, base HEAD `77c09895`. Gate = `tools/verify_asm.py` (`-`=ours,
`+`=oracle), whole-TU = `tools/tugate.py`. Syslib = vendor gate-parity lane (no psyqproof).
`tools/*.py` / memory dir / build.py NEVER edited. All probes via asserting scripts in
`scratchpad/w67a2/` (anchor `count==1`, restore in `finally:`, byte-compare re-assert).

## 0. PER-FN LEDGER (every number re-gated by me; landing gated 2x + tugate 2x)

| fn | TU | briefed | re-gated baseline | final | note |
|---|---|---|---|---|---|
| `_set_intr_callback` | INTR.c | 25 | **25** @83/82 | 🏆 **12** @84/82 | xenogears body landed (04T), 5 identity fences REMOVED |
| `_intrhand` | INTR.c | 30 | **30** @116/116 | 30 | byte-truth certificate; xeno-WIP shape falsified (51 @117) |
| `_initIntr` | INTR.c | 6 | **6** @54/54 | 6 | byte-truth certificate (54/54 incl. relocs); no new cell |
| `PutDispEnv` | SYS.c | 38 | **38** @318/318 | 38 | 05J RR mine executed: BOTH RR site-2/3 shapes falsified (42 / 176) |
| `_gpu_que_drain` | SYS.c | 14 | **14** @152/152 | 14 | certificate 152/152 |
| `_drs` | SYS.c | 10 | **10** @160/160 | 10 | certificate 160/160 |
| `_dws` | SYS.c | 8 | **8** @143/143 | 8 | certificate 143/143 |
| `_set_draw_mode` | SYS.c | 2 | **2** @8/8 | 2 | certificate 8/8, ZERO relocs — or-operand floor stands |
| `FntFlush` | FONT.c | 2 | **2** @199/199 | 2 | certificate 199/199 (FONT.obj +0x398) |

Board delta: **−13 diffs** (25→12 on `_set_intr_callback`). INTR.c 10/13 PASS before AND
after (zero PASS→FAIL, tugate 2x); SYS.c 39/44 PASS unchanged (comment-only edit, tugate 2x).
Files LF, 0 CR, 0 control bytes, non-ASCII counts unchanged vs HEAD.

## 1. 🏆 THE BYTE-TRUTH RESULT — all 9 targets are BYTE-IDENTICAL to the PsyQ **4.3** vendor members

Tool: `scratchpad/w67a2/objtruth.py` (SN-LNK .obj parser with FULL reloc-expression decode,
`find` = masked alignment scan, `relocs` = annotated truth listing, `diff` = verdict).
Corpus: `C:/Temp/nfs4-clean/psyq43/extracted/` (own 4.3 extraction, per coordinator redirect).
Reloc masks by patch type: t52=HI16, t54=LO16 (low 16 bits), t4A=jal/j (low 26), t10=word32.
⚠️ spimdisasm `.s` word comments are BYTES IN FILE ORDER — byteswap before comparing (the
first scan scored 11/116 until fixed; sanity fn = ResetCallback 12/12).

| fn | member | .text offset | verdict |
|---|---|---|---|
| `_intrhand` | LIBETC/INTR.obj | +0x26C | **116/116** (reloc-masked; every reloc word+addend consistent) |
| `_set_intr_callback` | LIBETC/INTR.obj | +0x43C | **82/82** |
| `_initIntr` | LIBETC/INTR.obj | +0x194 | **54/54** |
| `PutDispEnv` | LIBGPU/SYS.obj | +0xBAC (XDEF, 318w) | **318/318** |
| `_gpu_que_drain` | LIBGPU/SYS.obj | +0x24A0 | **152/152** |
| `_drs` | LIBGPU/SYS.obj | +0x1E5C | **160/160** |
| `_dws` | LIBGPU/SYS.obj | +0x1C20 | **143/143** |
| `_set_draw_mode` | LIBGPU/SYS.obj | +0x170C | **8/8** (zero relocs) |
| `FntFlush` | LIBGPU/FONT.obj | +0x398 | **199/199** |

⇒ NFS4's syslib LIBETC/LIBGPU code IS the PsyQ 4.3 lib build, byte-for-byte. Every residual
on these nine is now CERTIFIED pure coloring/scheduling identity — zero structural drift,
zero declaration-shape drift (the vendor reloc/symbol structure matches what our recon emits).

**REVISION MAP CORRECTION (settles a 3-wave confusion):** psyq43 INTR.obj `.rdata` carries
`$Id: intr.c,v 1.75 1997/02/07` == NFS4's retail rdata EXACTLY; psyq400's is v1.76 1997/02/12.
**PsyQ 4.3 ships an OLDER-dated intr.c revision than 4.0** (rollback/branch) — every earlier
"ours = v1.76 (PsyQ 4.3)" receipt line (w63a8/w64a8 tables) is wrong; w64a3's v1.75 reading
was right. The 4.0 members DRIFT (trapIntr 122w vs our 116w, 66/116; setIntr 85w, 36/82;
startIntr 55w, 52/54): the fns were REBUILT between 4.0 and 4.3. The SpongeBob v1.75 tiebreak
is unnecessary — the 4.3 members already ARE the exact truth.

## 2. 🏆 SEAL-CLASS LANDING — `_set_intr_callback` 25 → 12 (xenogears body AS-IS, 04T law 4th proof)

xenogears-decomp `src/slus_006.64/psyq/libetc/intr.c :: setIntr` (matched there; sotn's
matched v1.73 is statement-identical) transplanted verbatim with our names. Commit-gated
2x at **12 @84/82**; the OLD Rage-Racer-transplant body (5 identity fences, comma-staging)
and its whole receipt history are superseded — the fences were COLORING THE FN BACKWARDS
(the a0/a1 base/slot web now matches retail exactly).

**Residual 12, named from the vendor relocs (no guesses):** retail derives a SECOND base
`addiu a2,a1,-4` (= `&g_intr`) in the `beqz` delay slot, writes the ENABLE arm's mask via
`lhu/sh 0x30(a2)` and folds the DISABLE arm onto the cb base (`0x2C(a1)`); ours folds the
ENABLE arm (44(a1)) and goes ABSOLUTE (lui + lui-$at) in the DISABLE arm (branch-target
block, cse cold), plus keeps a second `addu v0,s4,zero` return copy. NO reloc sits on any
of those words (vendor truth) ⇒ w63a8's "cse NON-MERGE / derived pointer" classification is
now byte-certified.

**FALSIFIED THIS WAVE on the new body (all gated via `scratchpad/w63a8/w63a8_verflag.py`):**
- the ENTIRE xenogears flag set, one-by-one and combined (`-fpeephole`, `-ffunction-cse`,
  `-fpcc-struct-return`, `-mips1 -mcpu=3000`, `-msoft-float`, `-G8`): ALL 12, inert.
- `-fcse-follow-jumps` / `-fcse-skip-blocks` ± (12; both `-fno-` = 36 @90).
- fn-scope `IntrState *ctl` assigned in the enable arm: 31 @87 (la's own address + head
  recolor — the 06A fresh-pseudo trap); `((u_short*)g_intr.cb)[22]` disable spelling: 12
  provably inert (constant addresses canonicalize identically).
- 04Z re-ladder ON THIS BODY (basin moved, so re-run): 2.6.0/2.6.3 = 12 @84;
  **970404/2.8.0/2.8.1/2.91.66 = 64 @82 COUNT-EXACT** (the only count-exact basin; the
  param web shifts s1→s2); 2.95.2 = 77 @83; 2.8.x + `-mno-split-addresses` = 75 @85;
  2.8.0 nosplit + `-fno-schedule-insns` = 83 @83.

**NAMED NEXT ANGLE (w63a8 PADCMD precedent):** re-derive the source inside the 2.8.x
count-exact basin — the 64 diffs there are one param-web shift + downstream, and w63a8's
`_padSetActAlign_rcv` seal came exactly this way (basin-correct rung + source re-derivation).
Alternative unchanged: a non-asm anti-fold for `(plus (plus base -4) 48)` upstream of cse1.

## 3. `_intrhand` 30 — certificate + one falsification

- Byte-truth: source shape CERTIFIED exact (both `enabled` access devices — entry `48($s1)`
  vs loop-tail absolute `lui/lhu g_intr+0x30` with base live in $s1 — already reproduced;
  the residual is the known 3-way live-length rotation, sites confirmed by reloc positions).
- xenogears' commented WIP trapIntr (for-loop + comma clause + postincrement timeout),
  gated AS-IS: **51 @117** — falsified, count-over. Corpus axis stays retired at BOTH
  neighboring revisions (4.0's v1.76 drifts as a binary; v1.73 sotn already falsified w63).
- The w63a8 2.6.3 ver-splice (-4 partial, `spec_ver_splice_intrhand_263.json`) remains the
  only mechanical offer; unchanged.

## 4. LIBGPU belt — certificates + the 05J RR mine executed

- **PutDispEnv 38:** RR `display_environment.c` (byte-exact for RR's 2.6.3-era revision)
  spells sites 2/3 as block decl-inits `long hi=…; long lo=…; u_long k=0x…; submit(hi|(lo|k))`.
  Both cells gated on our 4.3 revision: named-k triple **42**, literal-k **176** — FALSIFIED;
  the shipped comma-expr basin (38) stays. The RR shape does not survive the revision gap.
  (RR also confirms the overscan `*10+608` arithmetic model our recon already has.)
- `_dws`/`_drs`/`_gpu_que_drain`/`_set_draw_mode`/`FntFlush`: certificates only (§1);
  their w64a3 falsification maps + named angles (06E local-alloc gap, `$a2` intruder for
  FntFlush, or-operand floor for _set_draw_mode) stand unchanged, now byte-certified as
  identity-class rather than possible-structure-class.

## 5. CATALOG-ROW CANDIDATES (orchestrator harvest)

1. **§G / NEW CORPUS LAW — "the psyq43 vendor members ARE the NFS4 syslib truth":**
   `C:/Temp/nfs4-clean/psyq43/extracted/<LIB>/obj/*.obj` members are byte-identical
   (reloc-masked) to NFS4 retail syslib fns — 9/9 proven incl. every reloc word. Use
   `scratchpad/w67a2/objtruth.py find` to certify any syslib fn's source structure before
   grinding; a certificate converts "possible structure miss" into "identity class" in one
   run. ⚠️ spimdisasm word comments are file-order bytes — byteswap (the tool does).
2. **§G — PsyQ revision NON-MONOTONICITY:** 4.3 ships intr.c v1.75 (1997/02/07), 4.0 ships
   v1.76 (1997/02/12) — a LATER SDK can carry an EARLIER-dated lib revision, and the same
   source revision exists in multiple REBUILDS (4.0's binaries drift, 4.3's match). Check
   the MEMBER's own `.rdata $Id`, never the SDK version, and never assume revision ==
   build identity.
3. **§A / 04T (4th proof) — gate the community body AS-IS FIRST:** xenogears' matched
   setIntr transplanted verbatim = 25→12 where three waves of isolated-delta ports of the
   SAME twin measured "neutral" (w64a8 ported the guard shape onto the fence-laden body and
   saw 25). An as-is transplant tests the whole interference graph; isolated deltas do not.
   Corollary: a fence-laden "best basin" can be COLORING THE FN BACKWARDS — re-test the
   natural body whenever a matched twin exists.
4. **§F — the heredoc backslash hazard fired again** (06F, ~9th): a `\\n` inside a quoted
   bash heredoc reached the C file as a raw byte sequence that cc1 2.7.2 reported as
   `I_STAT undeclared` (not a string error). File-based Write-tool probes only.

## 6. ORCHESTRATOR ACTIONS

- Nothing to wire. The 2.8.x count-exact basin for `_set_intr_callback` is a NAMED ANGLE,
  not a wiring recommendation (64 diffs; needs source re-derivation first).
- `spec_ver_splice_intrhand_263.json` (w63a8, −4 on `_intrhand`) unchanged, still on offer.
- Promote-worthy: `scratchpad/w67a2/objtruth.py` (the SN-OBJ byte-truth certifier —
  reusable for every remaining syslib near-miss, and for A1's full-library sweep).

## 7. FILES / BACKUPS / HAZARDS

- Landed: `recon/syslib/psx/libetc/INTR.c` (body replace + receipts), `recon/syslib/psx/libgpu/SYS.c`
  (receipt comments only). Both gated 2x + tugate 2x after final state.
- Backups: `INTR.c.probe.bak`, `INTR.c.flagprobe.bak`, `INTR.c.preland.bak`, `SYS.c.base.bak`
  (all under `scratchpad/w67a2/`).
- Probes: `objtruth.py`, `probe_setintr.py`, `probe_setintr_flags.py`, `probe_intrhand.py`.
- Hazards hit: (a) heredoc `\\n` collapse (§5.4) — moved to Write-tool files; (b) the
  `extern void _intrhand(void)` FORWARD DECL shadows the definition as an index() anchor —
  anchor on the exact definition line with its `/* @VA */` tail; (c) A1's truth/ dir was
  empty at start — the psyq43 redirect made it unnecessary for this belt.
