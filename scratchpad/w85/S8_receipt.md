# W85-S8 receipt — device audit + clearing, `recon/eaclib/psx/sndpsxz/`

Gate = `python tools/tugate.py <file>` (whole-TU, every oracle-known symbol) and
`python tools/verify_asm.py <file> <fn>` for per-fn diffs. No git, no tool edits.
Backups of every touched file: `scratchpad/w85/S8_bak/<name>.c` (verbatim pre-wave copies).

## BASELINE (all target TUs, before any edit) — ALL GREEN

| TU | gate |
|---|---|
| salloc.c | 4/4 PASS |
| sbdload.c | 1/1 PASS |
| sbhdrcpy.c | 1/1 PASS |
| sdmemman.c | 3/3 PASS |
| sdpacket.c | 13/13 PASS |
| sdresolv.c | 2/2 PASS |
| slib.c | 5/5 PASS |
| smemman.c | 4/4 PASS |
| spktplay.c | 13/13 PASS |
| sserver.c | 6/6 PASS |
| sst.c | 16/16 PASS |
| ssysinit.c | 4/4 PASS |
| ssysserv.c | 3/3 PASS |
| sdma.c | 6/6 PASS |
| spatkey.c | 10/10 PASS |
| sdplapat.c | 1/1 PASS |

## DEVICE CENSUS (in-code `__asm__` / pins)

CLEAR-candidates (GUIDE §DEVICE CLASSIFICATION):
1. salloc.c:564  `__asm__("" : "=r"(scan) : "0"(scan))`   identity fence (loop giv anti-anchor)
2. salloc.c:624  `__asm__("" : "=r"(gv) : "0"(gv))`       identity fence (anti symbol+offset fold)
3. sbdload.c:90  `__asm__("" : : "i"(0))`                 void-tail fence
4. sdmemman.c:851 `__asm__("" : "=r"(entry_off) : "0"(entry_off))` identity fence
5. sdresolv.c:116 `__asm__("" : "=r"(cur) : "0"(cur))`    identity fence
6. slib.c:188/189 `register int name __asm__("$4"/"$5")`  **REGISTER PINS** (2)
7. spktplay.c:341,345 `__asm__("" : : "r"(note))` x2      use fences (ref inflator)
8. sserver.c:296 `__asm__("" : "=r"(target) : "0"(cb))`   opacity fence
9. ssysserv.c:42 `__asm__("" : "=r"(target) : "0"(cb))`   opacity fence

KEEP by GUIDE (sanctioned, not touched):
- sdpacket.c:241/252, slib.c:184/185 — cop0 `mfc0/mtc0 $12` blocks.
- slib.c:190-211 MASK_SR_FOR_DMA{,_CALLBACK} — cop0 block; oracle @800FF82C carries the
  literal handwritten `mfc0;nop;addiu at,-0x402;and t0;mtc0;nop;nop;nop` (splat tags them
  `/* handwritten instruction */`), i.e. this IS the sanctioned cop0 macro.
- file-scope `__asm__(".globl X\n.section .bss\nX: .space N")` storage definitions in
  ssysinit/slib/sst/sdpacket/spktplay/salloc and the `extern T x[] __asm__("sym")` label
  aliases — these are DATA-SHAPE devices (the gp-rel/`%gp_rel`-free storage form), emit no
  instructions, and are not in the CLEAR list.

---

## 9. ssysserv.c `iSNDserverremoveclient` — opacity fence → **KEEP (restored verbatim)**

Baseline 3/3 PASS. Removal cost measured, plus 8 re-crack angles, all FAIL:

| angle | result |
|---|---|
| fence → plain `target = cb;` | FAIL 41 (ours 42 / oracle 43) |
| fence + `target` deleted, use `cb` directly | FAIL 41 (42/43) |
| drop the `p` pointer, guard on `base` | FAIL 44 (41/43) — worse, loses an insn |
| Yoda compare `cb == *(int*)(...)` | FAIL 41 (42/43) |
| `i = 0` hoisted above the count guard | FAIL 41 (42/43) |
| `unsigned int target` copy + `(int)target` compare | FAIL 41 (42/43) |
| cc1 rung 2.6.3 / 2.7.2 / 2.7.2-970404 (`NFS4_FORCE_CC1_ALT`) | FAIL 54 / 52 / 48 — count-exact 43 but a `nop`, not the copy |
| cc1 rung 2.8.0 / 2.8.1 | FAIL 41 (42/43) |

Residual in every failing form is ONE uniform 3-way rotation + the missing parm copy:
ours `{cb=$a0, i=$a1, base=$a2}` vs oracle `{i=$a0, base=$a1, cb=$a2}` + `addu a2,a0,zero` @insn 0.

**Why no source form reaches it (read off gcc-2.8.1 `global.c`).** `assign_parms` always emits
`(set (reg P) (reg $a0))`, so the parm pseudo unconditionally gets a `hard_reg_copy_preference`
for $a0 (`set_preference`, global.c). `prune_preferences` then ORs that into
`regs_someone_prefers[i]` for every CONFLICTING higher-priority allocno, and only removes it
again under `AND_COMPL_HARD_REG_SET (temp, hard_reg_full_preferences[allocno])` — i.e. only if
`i` ITSELF full-prefers $a0. A loop counter born from `i = 0` can never acquire a hard-reg
preference (set_preference fires only on a REG↔hard-REG set, and there is no call in this
function to copy `i` into $a0). So `find_reg` ORs $a0 into `used` for `i`, `i` takes $a1, and
the trio rotates. The identity fence is the only known zero-insn way out: `target`'s def is an
`asm_operands`, not a REG, so `set_preference` returns early (no $a0 preference) AND the `"0"`
matching constraint mints the oracle's `addu $a2,$a0,$zero` for free.
**Restored verbatim; re-gated 3/3 PASS.**

## 8. sserver.c `iSNDserverremove100hzclient` — opacity fence → **KEEP (restored verbatim)**
Exact twin of #9 (same shape, offsets 0x40/0x4c). Removal measured: `target = cb;` →
FAIL 41 diffs (ours 42 / oracle 43), identical `{cb,i,base}` rotation + missing `addu a2,a0,zero`.
Same global.c mechanism; restored verbatim, TU re-gated 6/6 PASS.

## 7. spktplay.c `SNDPKTPLAY_start` — 2 USE FENCES → 🟢 **CLEARED, PASS 187/187, zero devices**

Both `__asm__("" : : "r"(note))` fences DELETED. Replacement is a pure source-shape change:
**split the 2-role `int gp` into `int gsp` (&sndgs base) + `int gp` (packet length).**

Measurement chain (gate `verify_asm`, count stayed EXACT 187/187 in every row):

| form | result |
|---|---|
| baseline (2 fences + 3-statement in-place length arith) | PASS |
| fences deleted, everything else unchanged | FAIL 38 — pure `$s2`↔`$s3` swap (note vs length) |
| + `ch = ... + note*100` re-spelling (1 and 2 extra textual note refs) | FAIL 38 (CSE folds them back; refs do not survive) |
| + gp length arith as 2 statements `(gp<<8)&0xffff` | FAIL 4 — ranking fixed, but `sll v0,s3,8 / andi s3,v0,…` vs oracle in-place |
| + 2-statement mask-then-shift `(gp&0xff)<<8` | FAIL 4 (same 4) |
| + 1-statement | FAIL 60 |
| + `(MSB(params,7)-0x40)<<8` then `gp &= 0xffff` | FAIL 4 |
| + `gp <<= 8; gp &= 0xffff;` (compound ops = same 3 statements) | FAIL 38 |
| + block-local split temp `lenv` then `gp = lenv` | FAIL 60 |
| **split `gp` → `gsp` + `gp`** | **PASS (187 insns)** |

Why (read off the `-dl`/`-dg` dumps of the device-free one-variable form; gcc-2.8 priority =
`floor_log2(refs)*refs/live_length`, allocno_compare):
```
;; 11 regs to allocate: 87 162 84 89 91 85 168 83 82 81 80
;; dispositions: 91 in 18 ($s2)   85 in 19 ($s3)
Register 85 (note) used  9 times across 110 insns  -> 3* 9/110 = .2454
Register 91 (gp)   used 10 times across 108 insns  -> 3*10/108 = .2778   <- allocated first
```
`gp` out-ranks `note` and takes `$s2`; retail has them the other way. The two fences were buying
`note` 9→11 refs (`3*11/110 = .300 > .2778`) at zero instructions. The 2-statement length form
instead buys `gp` 10→8 refs (`.222`) but loses the oracle's in-place `sll s3,s3,8 / andi
s3,s3,0xffff`: at `-O2` `flag_expensive_optimizations` makes `preserve_subexpressions_p()` return
1, so `expand_expr` never passes the assignment target down as a subexpression `subtarget` — the
in-place shape is structurally tied to one-operation-per-statement, hence the 3-statement form,
hence the 10 refs. **Splitting the variable removes the trade entirely**: the &sndgs role and the
length role each keep their own refs/live_length, the length allocno no longer out-ranks `note`,
and the 3-statement in-place arithmetic is kept. gcc still hands both roles `$s3`, so the split is
invisible in the emitted code — it is a source-model correction, not a device.
Devices in spktplay.c after: only the file-scope `sndpps` `.bss` storage definition (sanctioned).
**TU re-gated 13/13 PASS.**

## 5. sdresolv.c `iSNDplatformresolve` — identity fence → **KEEP (restored verbatim)**

Baseline 2/2 PASS. The fence does two jobs: breaks cse's copy-propagation of `cur = scan`
(so the compare addresses through `cur`=$a0 like retail) and blocks `fill_simple_delay_slots`.
Oracle scan loop (`asm/nonmatchings/main/iSNDplatformresolve.s` @8010B850):
```
.L850: addu  a0,v1,zero      ; cur = scan          <- the copy retail did NOT propagate
       lw    v0,0(a0) ; nop ; beq v0,s3,found ; nop
       addiu v1,a0,8          ; scan = cur + 1
       lw    v0,8(a0) ; nop   ; cur[1].offset
       bne   v0,a1,.L850
       addiu s2,s2,1          ; idx++ in the delay slot
```
Angles measured (gate `verify_asm`, oracle 127 insns):

| angle | result |
|---|---|
| fence deleted, source unchanged | FAIL 7 (ours 126) — copy sinks, compare/advance go through `$v1` |
| cc1 rung 2.6.3 / 2.7.2 / 2.7.2-970404 / 2.8.0 | FAIL 23 / 19 / 11 / 7 (all 126) |
| `cur`-carried loop, copy at bottom, test via `cur->offset` | FAIL 6, count-EXACT 127 |
| same, test via `scan->offset` | FAIL 6 (127) |
| single-pointer walk + `scan = cur` | FAIL 6 (127) |
| `for(;;)` + `if (cur[1].offset == end) break; cur = scan;` | **FAIL 6 (127)** — best; residual = back-edge polarity (`beq`+`j` vs oracle `bne`) + copy position |
| same with `idx++` after the test | FAIL 8 (127) |
| `scan = cur;` pre-seed before the original do-while | FAIL 7 (126) |
| test value hoisted into a temp (`val`), copy at bottom | FAIL 8 (127) — `val` gets a stack home |
| goto-loop with the copy inside the conditional back-edge | FAIL 24 / 29 |

**Mechanism (cse.c).** `(set (reg cur) (reg scan))` calls `make_regs_eqv(cur, scan)`; both are
pseudos, so `qty_first_reg` stays `scan`, and `canon_reg` rewrites every later `cur` use to
`scan`. Making `cur` the class representative would require its def NOT to be a register copy —
which no C spelling of `cur = scan` produces (`+0`, `&scan[0]`, casts and `x-x` all fold in
`fold-const` before expand). The recorded cause is a per-obj compiler identity (methodology
§3.25-3d "old-gcc no-copy-prop"); wiring a per-TU flag would be a `tools/build.py` edit, which
this wave prohibits. **Restored verbatim; re-gated 2/2 PASS.**

## 3. sbdload.c `iSNDdownloadbank` — void-tail fence → **KEEP (restored verbatim)**

Baseline 1/1 PASS. The fence is a pure position barrier: it stops gcc's `fill_simple_delay_slots`
BACKWARD scan from stealing `anchor = bankData` (`addu $fp,$s4,$zero`) into the guard's `beqz`
delay slot. Oracle @801026C0:
```
  addu  fp,s4,zero        <- the anchor copy stays here
  lhu   v0,6(s4) ; nop
  beqz  v0,.L80102788
  addu  s0,zero,zero      <- slot = i = 0 (FORWARD fill)
```
Angles measured (gate `verify_asm`, oracle 84 insns; all count-EXACT 84):

| angle | result |
|---|---|
| fence deleted, source unchanged | FAIL 2 — only the `addu fp,s4,zero` position (it lands in the slot) |
| `i = 0;` hoisted above the guard | FAIL 4 |
| guard spelled through `anchor` (`anchor + 6`) | FAIL 2 (cse propagates `anchor`→`bankData`) |
| `anchor = bankData;` moved above the clear loop | FAIL 4 (`sw fp`/`addu fp` land in the prologue) |
| `anchor = bankData;` moved inside the if-body (before / after `i = 0`) | FAIL 2 / FAIL 2 |
| `i = 0; anchor = bankData;` and `anchor = bankData; i = 0;` before the guard | FAIL 4 / FAIL 4 |
| cc1 2.7.2 / 2.8.0 / 2.8.1 (`NFS4_FORCE_CC1_VER`, maspsx route kept) | FAIL 71 / 2 / 2 |

**Mechanism (reorg.c `fill_simple_delay_slots`).** The backward scan runs BEFORE any forward
fill and stops only at a LABEL/JUMP/CALL/BARRIER (`stop_search_p`). Between the clear loop's
back-edge jump and the `beqz` there are exactly two insns: the `lhu` (the branch's own operand,
skipped) and the `move $fp,$20` — which is therefore always found and always wins. No C spelling
removes that candidate while keeping the copy in the oracle's position: putting it earlier moves
it into the prologue (4 diffs), putting it later leaves it adjacent again (2 diffs). An
output-less `__asm__` is the only construct that plants a `stop_search_p` boundary at zero
instructions. **Restored verbatim; re-gated 1/1 PASS.**

## 4. sdmemman.c `iSNDpsxmalloc` — identity launder on `entry_off` → **KEEP (restored verbatim)**

Baseline 3/3 PASS. The launder makes `entry_off` die TWICE so local-alloc's `combine_regs`
(local-alloc.c:1866) refuses to tie the entry-pointer add's OUTPUT to its dying INPUT — retail
forms the pointer into a FRESH register (`addu a1,v1,a0`), ours ties it (`addu v0,v0,a0`).

| angle | result |
|---|---|
| launder deleted | FAIL 6 (count-EXACT 127/127) |
| launder deleted + `commit_base` folded to `table - 0x520` | FAIL 6 |
| `commit_base` derived from `entry - entry_off - 0x520` (a real later use of `entry_off`) | FAIL 6 — cse folds `entry - entry_off` back to `table` |
| operand-order swap `entry_off + (unsigned)table` | FAIL 6 |
| second store re-spelled `*(u16*)(table + entry_off)` (extra textual use) | FAIL 23 (128 insns) |

**Mechanism.** `combine_regs` ties the add's dest to whichever input dies in that insn. `table`
survives (it feeds `commit_base`), so the tie lands on `entry_off`. Preventing it needs a use of
`entry_off` AFTER the add that survives cse — and every C spelling tried either folds away
(`entry - entry_off`, `- x + x`) or costs an instruction. **Restored verbatim; 3/3 PASS.**

## 1+2. salloc.c `iSNDfreechan` — two identity fences → **KEEP (restored verbatim)**

Baseline 4/4 PASS. Removal costs measured independently (gate `tugate`, oracle 110 insns):

| angle | result |
|---|---|
| both fences deleted | FAIL 86 |
| only the loop-walker fence (`scan`) deleted | FAIL 81 |
| only the tail base fence (`gv`) deleted | FAIL 5 (ours 109 / oracle 110) |

**Fence 1 (`scan`, worth 81).** Zero-insn anti-anchor on the pool-scan walker: without it loop.c
re-anchors the address givs onto the LAST access (`scan+0x36`), turning retail's single
positive-displacement walker into `addiu a2,v1,54` + `lb v0,-43(a2)`. The obvious alternative —
`*(volatile signed char *)` reads — is itself a device AND breaks `lb` (a volatile QImode MEM
cannot fuse with its `sign_extend`, catalog §C VOLATILE-QImode LAW), which is the residual the
w50 wave spent two waves on. Prior falsifications recorded in-file: goto-loop (50), index form
(50), all-volatile-dropped without the fence (62-93), fence after the increment (17).

**Fence 2 (`gv`, worth 5).** Retail materializes a fresh `&sndgs` for the tail as a split
`lui` + `%lo` `addiu` DUPLICATED on both incoming paths, then `lw 0x44(v0)`; every folded spelling
emits `lui %hi(sndgs+0x44); lw %lo(...)` instead. Newly falsified this wave (all FAIL 5, count
109/110):

| spelling | result |
|---|---|
| `*(int *)((unsigned char *)sndgs + 0x44)` (direct, no local) | FAIL 5 |
| `sndgs[0x11]` (int-array index) | FAIL 5 |
| `int *gvp = (int *)sndgs_v; gvp[0x11]` | FAIL 5 |
| `gv` assigned after the byte store (position dial) | FAIL 5 |

**Mechanism (`config/mips/mips.c mips_check_split`).** The split (`lui %hi; lw %lo(sym+off)`) is
taken for any `SYMBOL_REF`/`CONST(PLUS(SYMBOL_REF, const))` whose `SYMBOL_REF_FLAG` is clear
(i.e. every non-small-data global) at word size or below — so a constant displacement off a global
ALWAYS folds into the `%lo`. The only banked non-asm defeat is a `volatile` MEM (catalog: "volatile
MEM defeats TARGET_SPLIT_ADDRESSES"), which would just trade one device for another on plain state.
**Both restored verbatim; re-gated 4/4 PASS.**

## 6. slib.c — **2 REGISTER PINS CLEARED**, TU still 5/5 PASS 🟢

`#define DECLARE_DMA_CHANNEL(name) register int name __asm__("$4")` and
`DECLARE_DMA_CALLBACK(name) register int name __asm__("$5")` — the only `register … asm("$N")`
pins in the whole `sndpsxz/` directory — are **deleted**. Both macros are now plain `int name`.

The DMACallback arguments are instead threaded THROUGH the cop0 critical-section block as
MATCHING in/out operands (`: "=r"(sr), "=r"(channel) : "1"(channel)`), which is what the masked
window means semantically: those values must survive it. No hard register is named anywhere;
gcc picks `$a0`/`$a1` by itself because they are the outgoing args of the following
`jal DMACallback`.

| form | iSNDinit | iSNDrestore | TU |
|---|---|---|---|
| pins + `"+r"` operands (baseline) | PASS | PASS | 5/5 |
| plain `int` + `"+r"` operands | — | — | **cc1 abnormal termination (2.8.0 ICE)** |
| plain `int`, operands dropped | FAIL 3 (169/168) | FAIL 2 (85/85) | 3/5 |
| … + `dma = 4;` hoisted above `iSNDpsxfxinit(0)` | — | FAIL 2 | — |
| … + literal `DMACallback(4, 0)` | — | FAIL 2 | — |
| plain `int` + read-only `"r"(channel)` inputs | FAIL 7 | FAIL 3 | 3/5 |
| **plain `int` + `"=r"(x)` / `"N"(x)` matching in/out operands** | **PASS** | **PASS** | **5/5** |

Residual without any operand was solely the POSITION of `addiu $a0,$zero,4`: retail materializes
the channel BEFORE `mfc0` (iSNDrestore @800FFA9C), gcc sinks the constant down to the `jal`.
The cop0 block itself stays (GUIDE: cop0/GTE macro blocks are KEEP) — the oracle carries the
identical hand-written `mfc0;nop;addiu at,-0x402;and t0;mtc0;nop;nop;nop` at both sites, tagged
`/* handwritten instruction */` by splat.

**`grep -rn 'register.*__asm__' recon/eaclib/psx/sndpsxz/` is now EMPTY (0 pins in the directory).**

---

# VOLATILE AUDIT — whole `recon/eaclib/psx/sndpsxz/` directory

Method: `scratchpad/w85/S8_vol.py <tu.c> [--only LINES]` strips `volatile` from CODE lines
(block-comment aware; `__asm__ volatile` never touched), runs `tools/tugate.py`, prints the
whole-TU gate, then RESTORES the file in a `finally:`. Whole-file strip first; the failing
function list then localises which sites are load-bearing; survivors re-tested individually.

## CLEARED — 24 `volatile` qualifiers removed, every TU still fully PASS 🟢

| TU | lines | what they were | gate after |
|---|---|---|---|
| sdmemman.c | 720, 733, 754, 903, 912 | SPU-alloc-table words in main RAM (`pd+0x51A`, `entry`, `base+0x518`, 2 `PackedAllocSlot` copy views) | 3/3 PASS |
| spatkey.c | 20, 109, 120, 131, 146, 161 | `SNDPD_VOICEREG` macro + five `int *base = (int *)sndpd` driver-state bases | 10/10 PASS |
| slib.c | 377, 394, 413 | the three latched-SPU-base reads assigned to locals (`postmask_spu`, `vr`, `post_ctrl`) | 5/5 PASS |
| sdcdvol.c | 16, 32, 35, 36 | `int *base = (int *)sndpd` driver-state base | 1/1 PASS |
| sdresolv.c | 108, 117, 121 | resolve-table entry reads in main RAM | 2/2 PASS |
| sdpacket.c | 881 | `iSNDpacketserve`'s `pp+0x20` DMA-handle read (ordered by the following call) | 13/13 PASS |
| sdtimrem.c | 19 | `voice+8` sample-rate word | 1/1 PASS |
| srandom.c | 16 | RNG state pointer | 1/1 PASS |

Each edited TU carries a `W85-S8 VOLATILE AUDIT` header note naming the cleared lines so the
qualifiers are not silently reintroduced.

## KEPT — measured load-bearing or MMIO

| TU | sites | verdict |
|---|---|---|
| slib.c | 51 → 48 | the `DPCR/SPU_DELAY/D4_*/VOICE_00/SPU_MAIN_VOL_*/SPUCNT/SPUSTAT/…_F` macros are literal-address **MMIO** (0x1F8010xx / 0x1F801Cxx). The INLINE `*(volatile int *)(latched + 0x514)` re-reads inside the SPU stores are semantic: stripping all of them costs `iSNDinit` **33 diffs** (gcc CSEs the `lw 0x514(s1)` the oracle re-issues at every store). The `vp+…` voice-table reads are IRQ/DMA-shared (`iSNDserve` runs off the timer, `iSNDdmcallback` off the DMA IRQ) |
| sdma.c | 36 | full strip → **1/6 PASS** (iSNDdmqueuesplit 4, iSNDdmservice 8, iSNDdmqueue 26, iSNDdmcallback 78, iSNDdmtransfer 106). DMA-channel MMIO + IRQ-shared queue state |
| sdpacket.c | 27 → 26 | full strip → **9/13 PASS**; every remaining site sits in iSNDpacketsetirq / iSNDfillspuwithpackets / iSNDpacketgetirq / iSNDplatformpacketplay (packet ring + SPU-visible buffer flags, IRQ side) |
| sst.c | 21 | full strip → **6/16 PASS**; every site (incl. the `MVI` macro) is used by a failing stream function — request-block state shared with the CD/DMA service |
| spktplay.c | 14 | full strip → **5/13 PASS**; all sites are the packet-ring header words `ppp+0x4/0xa/0xc/0xe` (and the `VH`/`MVUH`/`VHR` macros over them) — the game↔player ring indices |
| spatkey.c | 18 → 12 | remaining are the SPU-register accesses through the latched base (`c1+0x19a` etc.) and the voice-table reads in iSNDsetvol / iSNDstartvoice (individually: full strip 8/10, minus-the-6-cleared 10/10) |
| sserver.c | 6 | full strip → **3/6 PASS**. `253/254` alone are gate-neutral, but the neighbouring RMWs on the SAME objects (`g+0x3f` lock depth, `g+0xB2` deferred-server count, lines 250/251/255/256) are NOT — stripping the group costs `iSNDleaveaudio` 8 diffs. Kept as one consistently-qualified IRQ-shared object (also the catalog's SPIN-LOOP-LOAD-HOIST hazard class) |
| sdplapat.c | 2 (19 incl. sub-expressions) | full strip → 0/1 PASS (iSNDplatformplay 43) |
| sdfx.c | 2 | each site tested ALONE → iSNDpsxfxinit 2 diffs either way |
| spvoices.c | 5 | full strip → 3/4 PASS (SNDSTRM_purge 10) |
| s3dpos / span / sstgetrp / sstvol / sdtimrem:22 | 1-2 each | full strip → 0/1 PASS in each single-function TU |
| salloc.c | 0 code sites | every `volatile` in this file is inside comments (the w50-a7 narrative); nothing to clear |

---

# FINAL STATE — `recon/eaclib/psx/sndpsxz/`

```
register T x __asm__("$N") PINS ............ 0   (was 2; both cleared in slib.c)
in-code __asm__ fences ..................... 6   (was 8; spktplay's 2 cleared)
   salloc.c:564 / :624, sbdload.c:90, sdmemman.c:851, sdresolv.c:116,
   sserver.c:296, ssysserv.c:42  -- each receipted KEEP with a measured
   device-free floor and a named gcc mechanism
volatile qualifiers ........................ 24 removed
cop0 blocks (sanctioned) ................... slib.c, sdma.c, sdpacket.c  -- untouched
file-scope .bss / asm-label storage defs ... untouched (data shape, no instructions)
```

Whole-directory final gate (every TU touched or examined):

```
spktplay 13/13   slib 5/5     sdmemman 3/3   spatkey 10/10  sdpacket 13/13
sdcdvol 1/1      sdtimrem 1/1 srandom 1/1    sdresolv 2/2   ssysserv 3/3
sserver 6/6      sbdload 1/1  salloc 4/4     sst 16/16      sdma 6/6
sdplapat 1/1     ssysinit 4/4 smemman 4/4    sbhdrcpy 1/1
```

**No previously-PASSing function is left FAILing. No git operations, no `tools/*.py` edits.**
