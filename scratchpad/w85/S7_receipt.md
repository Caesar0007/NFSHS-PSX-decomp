# W85-S7 receipt — device purity sweep (recon/eaclib/psx/eacpsxz/)

Gate used for every number below (whole-TU, authoritative):

```
NFS4_SOURCE_ONLY=1 python tools/tugate.py recon/eaclib/psx/eacpsxz/<file>.c
python tools/verify_asm.py recon/eaclib/psx/eacpsxz/<file>.c <fn>   # focused read
```

## BASELINE (measured first, before touching anything) — 2026-09-02

| file | gate |
|---|---|
| nfile.c | **27/27 PASS** |
| stream.c | **32/32 PASS** |
| nsync.c | **10/10 PASS** |
| unref.c | **2/2 PASS** |
| resize.c | **1/1 PASS** |
| cdfs.c | **14/14 PASS** |
| syncfile.c | **8/8 PASS** |
| systask.c | **3/3 PASS** |
| textcode.c | **3/3 PASS** |
| callback.c | **2/2 PASS** |
| crc.c | **1/1 PASS** |
| getm.c | **2/2 PASS** |
| random.c | **2/2 PASS** |
| shpdepth.c | **1/1 PASS** |
| shpsubs.c | **3/3 PASS** |
| blkfill.c | **2/2 PASS** |
| blkmov.c | **1/1 PASS** |
| nullfunc.c | **1/1 PASS** |
| asinfunc.c | **2/2 PASS** |
| sinfunc.c | **2/2 PASS** |
| fixddiv.c | **1/1 PASS** |
| fixdinv.c | **1/1 PASS** |
| fixdmult.c | **1/1 PASS** |
| fixdsqrt.c | **1/1 PASS** |
| math64a.c | **2/2 PASS** |
| movf.c | **1/1 PASS** |
| fastmovf.c | **1/1 PASS** |
| vramfxya.c | **3/3 PASS** |
| savegp.c | **3/3 PASS** |

Total **136/136 PASS** at baseline. IRON RULE binding: any removal that cannot
be re-cracked source-only is RESTORED verbatim and receipted KEEP-with-reason.

(sections appended per device — in progress)

---

## LANDED (device removals, all re-gated)

### nsync.c — identity fence ELIMINATED, TU now 100% device-free (10/10 PASS)
`loadbigfileheaderatomic` carried `__asm__("" : "=r"(rm1) : "0"(rm1))` (an opacity/identity
fence) whose whole job was to KILL cse's value-number equality `rm1 == retry - 1`, so both
trailing `FILE_closesync(handle, retry - 1)` sites RECOMPUTE `addiu a1,s4,-1` and `retry`
keeps its long live range (which is what puts the retry/`a` allocno pair on retail's map).

**🆕 NEW CATALOG LAW — PURE-C ZERO-INSN CSE KILL: a DEAD REASSIGNMENT of the laundered
variable is an exact drop-in for the identity fence.** `rm1` has no reader after the second
`FILE_readsync`, so cse still SEES the write (equality destroyed) while flow's dead-store
elimination deletes the insn again → zero instructions, zero asm.

| variant (source-only gate, loadbigfileheaderatomic) | result |
|---|---|
| identity fence (old baseline) | PASS 81/81 |
| **`rm1 = 0;` (LANDED)** | **PASS 81/81** |
| `rm1 = retry;` / `rm1 = handle;` / `rm1 = -1;` | PASS 81/81 (all work) |
| no device at all | FAIL 24 |
| `rm1 = rm1 + 0;` | FAIL 24 — folds away; the write must be to a value cse cannot prove equal |
| `rm1` block-scoped inside the inner `{ }` | FAIL 24 — C scope is NOT a cse boundary |
| compiler axis 2.6.3 / 2.7.2 / 2.8.0 / 2.8.1 / 2.95.2, no device | FAIL 24 on every rung |

### cdfs.c — read-only fence deleted as INERT (14/14 PASS, unchanged)
`CD_Read`'s `__asm__("" : : "r"(cache))` (w47-a5 "sched fixpoint") is no longer load-bearing:
the sched1 tie it pinned is already decided the oracle's way by the SPLIT statement pair
`off = rs->curOff; off += (int)cache;`. Deleted; whole TU re-gated 14/14 PASS.
KEEP in this TU: the `volatile int info` / `volatile int cachedSector` CD-context fields and
the `RS_Cdinfo` / `CD_cachedSector` volatile views — **measured**: dropping the two struct
volatiles regresses 14/14 → 9/14 (CD_Restart 2, CD_Stopread 3, CD_Read 21, readsectorB 25,
CdReadyHandler 91). Genuine IRQ-shared device state (GUIDE KEEP class).

### syncfile.c — 16 volatile casts → 10 (8/8 PASS)
Removed as pure codegen crutches: `c->buf +=`, `c->done +=`, `c->offset =` (synccallback's
advance chain) and the `0 < c->remain` re-issue guard.
KEPT (semantic, oracle-proven re-read): the 7-store ordered init block in `syncblockio` plus
its `firstchunk = c.chunk` reload, and the `c->remain` store/clamp views. See the in-source
W85-S7 block for the full falsification table (incl. the NON-ADDITIVITY warning: the remain
guard cast and the remain clamp cast are each free alone but cost 10 diffs together).

### stream.c — `volatile StreamFilter *f` ELIMINATED (32/32 PASS)
`filterchunk` declared its record pointer `volatile StreamFilter *f` and walked it with `f++`.
That volatile was a **codegen crutch for a GIV-ANCHOR problem**, not a semantic property (the
filter table is plain read-only config). Without it, the pointer-walk lets loop.c strength-reduce
the three field addresses onto a SECOND walking giv — `addiu a2,a0,8` / `lw v1,-4(a2)` /
`addiu a2,a2,12`, **21 insns vs the oracle's 20** — where retail keeps ONE base with
displacements 0/4/8 and a single `addiu a0,a0,12` (catalog SS-B "loop.c never ran").

**FIX = the INDEX FORM `f[i].field`** (methodology §3.12 #1): gcc strength-reduces it back to
retail's single-base walk.

| variant (filterchunk) | result |
|---|---|
| `volatile` + `f++` walk (old baseline) | PASS 20 |
| plain ptr + `f++` walk | FAIL 15 @ 21 insns |
| **index form `f[i].mask/value/consumer` (LANDED)** | **PASS 20** |
| goto-loop + `f++` walk | PASS 20 (equivalent) |
| goto-loop + byte-offset `MI(fp,0/4/8)` spelling | PASS 20 (equivalent) |

### nfile.c — one volatile status read removed (27/27 PASS)
`FILE_completeop`'s SECOND `op->status` read is now plain. The other four are SEMANTIC (IRQ/DMA
writes `op->status` while these poll it) and oracle-proven — see the measured table below.

### movf.c — `extern char * volatile nextprim` → plain (1/1 PASS)
The per-TU volatile decl device is INERT here now. **NOTE the sibling `fastmovf.c` still needs
it (3 diffs without)** — that one is the sanctioned DMPSX-template dummy-input volatile.
Do not "harmonise" the two declarations.

---

## KEPT (restored verbatim after a measured regression, or sanctioned class)

| site | device | measured cost of removal | verdict |
|---|---|---|---|
| `resize.c` resizememadr | `__asm__("" : : "r"(tail))` | **2** @ 94/94 | KEEP — see mechanism below |
| `unref.c` unrefpack | `__asm__("" : : "r"(src),"r"(op)x3)` | **122** | KEEP — 4-operand allocno REF dial; no pure-C zero-insn ref exists |
| `stream.c` restartstream | `__asm__("" : : "r"(uVar3))` | **2** @ 167/167 | KEEP — sched2 load-order tie |
| `stream.c` STREAM_cancelrequest | `__asm__("" : : "i"(0))` | **2** @ 173/173 | KEEP — jump.c forwarding artifact |
| `vramfxya.c` vramfxya | 5x `r(maskHi)` + 4x `r(clutXm),r(clutYm)` | **16** @ 165/165 | KEEP — but 16→**2** reached in pure C, see below |
| `vramfxya.c` vramfxya | `volatile unsigned int clut24tail` | **4** | KEEP — frame-slot pad; plain/array/removed all 4, `clut24[131]`/`[132]` 50 |
| `cdfs.c` CD ctx | `volatile int info` + `volatile int cachedSector` | **14/14 → 9/14** (91/25/21/3/2) | KEEP — genuine IRQ-shared device state |
| `nfile.c` x4 | `*(volatile int *)&op->status` | 2 / 1 / 13 / 20 (all five: 23/27) | KEEP — IRQ/DMA-written async op status |
| `syncfile.c` x10 | SyncCtrl volatile view | init block 8 @47/48 insns; each single cast 2 | KEEP — async control block, oracle-proven reload |
| `systask.c` | `extern volatile int libticks` | **26** on systemtask | KEEP — IRQ tick counter (genuinely volatile) |
| `fastmovf.c` | `extern char * volatile nextprim` | **3** | KEEP — sanctioned DMPSX-template dummy input |
| `movf.c` / `fastmovf.c` | `__asm__ volatile(...)` OT-link templates | (not probed) | KEEP — sanctioned EA expander templates (methodology §3.25-2) |
| `nfile.c` / `stream.c` | `mfc0/mtc0 $12` critical-section macros | (not probed) | KEEP — cop0, explicitly sanctioned |
| `crc getm random shpdepth shpsubs blkfill blkmov nullfunc sinfunc fixddiv fixdinv fixdmult fixdsqrt math64a savegp` | file-scope `__asm__` whole-fn transcriptions | n/a | KEEP — SLD-proven `C:\LIB\PSX\*.ASM` vendor hand-asm |
| `textcode.c` / `nullfunc.c` | `__asm__("name = target")` symbol aliases | n/a | KEEP — symbol aliasing, not a codegen device |
| `savegp.c` | `extern unsigned int g_bootGP __asm__("D_801234E8")` | n/a | KEEP — asm *label* on a declaration (symbol rename), not an instruction device |
| `callback.c` / `systask.c` / `movf.c` | file-scope `__asm__(".section .bss …")` | n/a | KEEP — DATA materialization, see note below |

**`.bss` data-definition asm — probed, not landed.** Replacing them with C definitions
(`short mutexbuf[64];`, `static int systemtasksubs[64];`, `int windowbuf[78]; int currentwindow[39];`)
gates IDENTICALLY (2/2, 3/3, 1/1 PASS) and gcc does emit real `.bss` (not `.comm`) of the right
size — but the C form loses the explicit `.align 2` (section alignment drops 2\*\*2 → 2\*\*0) and,
for `movf.c`, the guaranteed `windowbuf`→`currentwindow` adjacency the W65-A6 data-mat receipt
depends on. These are data materialization, not codegen devices, and are outside this wave's
CLEAR list — left as-is. Orchestrator call if the wave wants them converted.

---

## NAMED ANGLES + CATALOG CANDIDATES

Full falsification detail, mechanisms and catalog-row candidates are in the companion file:
`scratchpad/w85/S7_named_angles.md`.

## FINAL STATE — all 29 TUs re-gated, ZERO PASS->FAIL

**136/136 PASS**, identical to baseline.  Devices net **-11**:

| file | devices before | devices after |
|---|---|---|
| nsync.c | 1 identity fence | **0** |
| cdfs.c | 1 read-only fence + 4 volatile | 4 volatile (semantic) |
| stream.c | 2 fences + 1 volatile ptr | 2 fences |
| syncfile.c | 16 volatile casts | 10 volatile casts |
| nfile.c | 5 volatile status reads | 4 volatile status reads |
| movf.c | 1 volatile decl + template + bss | template + bss |

Files restored byte-identical after failed probes (verified with `cmp`): `resize.c`,
`unref.c`, `vramfxya.c`, `systask.c`, `textcode.c`, `callback.c`, `fastmovf.c`.
Backups: `scratchpad/w85/s7_backup/`.  No git operations, no tools/*.py or memory edits.
