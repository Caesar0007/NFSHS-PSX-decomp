# W85-M9 — recon/syslib/psx/libcd/stcdint.c

**Owner scope:** `StCdInterrupt`, `_st_copy_words`, `_st_dma`.
**Headline:** the `register int dv __asm__("$6")` PIN is **RETIRED**, one of the two
`__asm__ __volatile__("")` fences is **RETIRED**, both at the *same* gate — and the
`_st_dma` residual-1 mechanism moved from *derived* (W84-C4, read out of `reorg.c`) to
**demonstrated** (this wave constructed the missing `BARRIER` and our cc1 then performed
retail's fall-through steal, count-exact 106/106).

Backup of the pre-wave file: `scratchpad/w85/M9_stcdint_backup.c`
(md5 `ad16a2d6a954d2ce3f40035343a26423`).
Harness (scratchpad only, no `tools/*.py` touched):
`M9_try.py` (whole-TU gate per variant, always restores),
`M9_gen6.py` / `M9_gen7.py` / `M9_gen8.py` / `M9_gen9.py` (variant generators),
`M9_base_v22.c` / `M9_base_v24.c` (intermediate bases).

---

## 1. GATE — before / after

```
python tools/verify_asm.py recon/syslib/psx/libcd/stcdint.c StCdInterrupt,_st_copy_words,_st_dma
                      BEFORE                    AFTER
  StCdInterrupt   PASS (583 insns)          PASS (583 insns)
  _st_copy_words  PASS (11 insns)           PASS (11 insns)
  _st_dma         FAIL 1 (107/106) -li v0,1 FAIL 1 (107/106) -li v0,1
```

**Zero PASS→FAIL. Residual unchanged in size AND in kind. Devices strictly fewer.**

### Device delta

| device | before | after |
|---|---|---|
| `register int dv __asm__("$6")` (arg/value PIN) | present | **REMOVED** |
| `__asm__ __volatile__("")` inside the `dv/bit` block | present | **REMOVED** |
| `__asm__ __volatile__("")` after the DICR read-back | present | KEPT (measured, §4) |
| `__asm__(".local _st_slot … .bss …")` storage blob | present | KEPT (measured, §4) |
| `volatile` lines in the TU | 23 | 23 — every one classified in §4 |

---

## 2. TASK (1) — THE PIN IS NOT LOAD-BEARING **only once two source dials are added**

⚠️ **Correction to the dispatch brief.** The brief said "C4 proved the pin is NOT
load-bearing (plain `int dv;` leaves the diff byte-identical)". That misreads W84-C4 §3.1.
What C4 proved is that **the +1 `li v0,1` delay-slot row is pin-independent**; the *total*
went **1 → 47** on a bare `register`→`int` swap. Re-measured here first thing:

| edit | `_st_dma` |
|---|---|
| control (pin) | **1** (107/106) |
| pin → `int dv;` | **47** (107/106) |

So the pin *was* holding the `dv → $a2` seat. The retirement needed two plain-C levers.

### Lever A — `dv = ch << 2;` not `dv = ch * 4;`
Both fold to the same `sll`, but the `MULT` rtx reaches local-alloc with a different
qty/copy structure. Pin-free: `* 4` = 47, `<< 2` = **9**.

### Lever B — methodology §3.12 #14 IN-PLACE MUTATION, at **both** `dv` sites
`tools/sbs.py` on the 9-diff basin showed the residual is retail mutating the dead `dv`
register in place where ours lands the sub-expression in a fresh temp:

```
   ours                          retail
   sll   a2,s0,2                 sll   a2,s0,2
   addiu v0,a2,3          X      addiu a2,a2,3
   sllv  v1,v1,v0         X      sllv  v1,v1,a2
   ...
   or    v1,a2,v1         X      or    a2,a2,v1
   sw    v1,0(a0)         X      sw    a2,0(a0)
```

Source fix: `dv += 3; bit = 1 << dv;` (instead of `bit = 1 << (dv + 3);`) and
`dv |= bit; *dp = dv;` (instead of `*dp = dv | bit;`).

### Ladder (all whole-TU gated; `StCdInterrupt` 583 PASS and `_st_copy_words` 11 PASS in **every** row)

| variant | `_st_dma` |
|---|---|
| control (PIN, `ch * 4`, anonymous stores) | 1 |
| no pin, `ch * 4` | 47 |
| no pin, `ch * 4`, in-place ×2 | 5 |
| no pin, `ch << 2` | 9 |
| no pin, `ch << 2`, in-place site 1 only | 5 |
| no pin, `ch << 2`, in-place site 2 only | 5 |
| **no pin, `ch << 2`, in-place ×2** | **1  ← LANDED, pin-free** |
| PIN kept + `ch << 2` + in-place ×2 | 3 — *the pin is now a net LOSS* |

### Falsified pin-free shapes (all 107/106 unless noted)
`int bit;` declared before `int dv;` 47 · `unsigned dv` 47 · `register int dv` (no seat) 47 ·
two separate variables `dv`/`dv2` 47 · `register`+`<<2`+two vars 47 ·
`bit = 8 << dv` (folds the `+3` away) 46 @**106** · `bit = 8 << dv` + fence 4 @**106**.

---

## 3. TASK (2) — NEW ANGLES ON THE 1-DIFF

### (a) Is the busy-read genuine MMIO? — **YES. Branch closed on semantics.**
`*(volatile int *)(0x1F801088 + (ch << 4))` = `0x1F801080 + ch*0x10 + 8` = **D\<ch\>_CHCR**,
the DMA channel control register. It is a hardware device register, not plain state, so the
methodology §3.25-3c cast-away-`volatile` lever **does not apply**. Measured anyway as a
pure diagnostic (never a shipping candidate):

| diagnostic | `_st_dma` |
|---|---|
| loop-condition read non-volatile | 27 @**105** |
| both reads (loop + printf arg) non-volatile | 27 @**105** |

The count drops by 2 because cse then hoists the channel address out of the busy loop —
i.e. removing the qualifier does unbar `fill_simple`, but it simultaneously destroys the
loop body. **Receipted and stopped.**

### (b) A 1-word non-load, non-volatile insn between the guard and its branch — **structurally unavailable**
The oracle's own window between the volatile read and the `beqz` is
`lbu $s1,0x44($sp)` — a **load**, which `mips.md`'s `define_delay` forbids in a slot
(`dslot == "no"` required). W84-C4's `-dR` sched2 trace shows that single load-delay filler
position is claimed by that `lbu` via hazard promotion. Consequences:

* any insn we *add* there is +1, and
* the only insn whose **move** into the slot would MATCH the oracle is the `0x10000` limit
  constant itself — and it cannot be scheduled into that position. Its sched priority is 1
  (its only LOG_LINK is a `REG_DEP_ANTI`; it has no data successor inside the entry block),
  and raising the priority requires a real data predecessor = +1 insn.

Re-measured in the NEW (pin-free) basin, confirming C4's numbers still hold:

| shape | `_st_dma` |
|---|---|
| named `limit = 0x10000` before the loop | 3 (`lui a2,1` lands at entry idx 10) |
| `mode = enable_irq` moved to point of use | 13 |
| named limit + late `mode` read | 15 |
| no `mode` variable (`if (enable_irq == 1)`) | 13 |

### (c) RAW rewrite of the busy-wait head — **THE REFUSAL CONDITION IS NOW DEMONSTRATED**

| shape | `_st_dma` | guard slot |
|---|---|---|
| control (`while (busy) { if (i==LIM) {printf;break;} i++; }`) | 1 @107 | `li v0,1` (target-thread COPY) |
| `for(;;)` + explicit break on `!busy` | 1 @107 | `li v0,1` (gcc re-rotates to the control) |
| goto form with an explicit unconditional back edge | 43 @109 | — (jump.c re-inverts it) |
| `if (busy) do { … } while (busy);` | 15 @109 | — |
| counter tested after the increment | 11 @111 | — |
| **printf arm out of line behind a `goto`** | **18 @106** | **`li $6,0x10000` = RETAIL'S STEAL** |

The winning probe:

```c
    i = 0;
    while (*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000) {
        if (i == 0x10000) goto st_busy;
        i++;
    }
    goto st_ok;
st_busy:
    printf("StCdInterrupt: DMA ch busy %08x\n", *(volatile int *)(0x1F801088 + (ch<<4)));
st_ok:
    ;
```

Emitted `.s` (`build/recon/syslib/psx/libcd/stcdint.c.s`):

```
	beq	$2,$0,$L79
	li	$6,0x00010000		# 65536      <-- retail's fall-through STEAL
$L75:
	beq	$4,$6,$L77
```

and `tools/sbs.py` shows oracle indices **19–21 byte-identical**
(`beqz v0,T` / `lui a2,1` / `beq a0,a2,T`) with **insn count EXACT (106 == 106)**.

**Why:** the `goto st_ok` emits a real `j` immediately before the loop-exit label, hence a
**`BARRIER`**. `find_basic_block` (reorg.c:2237) then stops at that barrier instead of
falling off the front of the function and returning block 0, so `mark_target_live_regs`'s
live walk no longer passes **through the limit constant's own defining insn**, `$a2` is not
reported live at the target, and `fill_slots_from_thread`'s
`! insn_sets_resource_p (trial, &opposite_needed, 1)` **accepts** the fall-through trial.
That is exactly W84-C4 §2(c)'s derivation, now confirmed empirically at the object level.
(Also re-read from source this wave: `b == -1` is no escape — mark_target_live_regs then
"must assume everything is live"; only a correct block number works.)

**Why it still scores 18, and why that is the floor:** the same `goto` forces the printf
block **INLINE** (our idx 30–37) where retail keeps it **out of line after the `mode == 1`
arm** (oracle idx 40–47, `.L800F8860`). Retail's block order puts the loop's **conditional**
back-edge (`bnez $v0,.L800F8814` + delay slot) immediately before the exit label
`.L800F8838`, so in retail's layout there is **no barrier and no place to put one without
adding an insn**. Retail's cc1 did not need one: from the 970404 snapshot on,
`find_dead_or_set_registers` follows both arms of one conditional jump and kills `$a2`
directly (W84-C4 §3.5 rung table — every rung ≤ 2.7.2 copies, every rung ≥ 970404 steals,
and every stealing rung drags the post-2.7.2 address CSE that costs 47+ elsewhere and
738 on `StCdInterrupt`).

⇒ **The residual is a REORG-VINTAGE identity, and the acquisition target is unchanged:**
a retail cc1 in the 2.7.2 *codegen* family carrying the post-2.7.2 *reorg*. This wave adds a
**second, sharper acceptance test** to C4's 5-second probe: besides
`insn after beq $2,$0,$L… == li $2,1` (2.7.2 reorg) vs anything else (post-2.7.2), a
candidate compiler must produce `li $6,0x00010000` in that slot **from the control source
shape** (no `goto`), which is exactly what the barrier probe produces artificially.

---

## 4. VOLATILE + `__asm__` AUDIT OF THE WHOLE TU (every line measured)

Method: remove the qualifier/device, gate the whole TU, restore. `_st_dma` / `StCdInterrupt`.

| line | construct | remove ⇒ | verdict |
|---|---|---|---|
| 32–40 | `static volatile … *_cd_idx/_cd_reg2/_cd_reg3/_cdrom_delay/_com_delay/_dpcr/_dicr/_d1_chcr/_d3_chcr` = `0x1F80xxxx` | not attempted | **KEEP — literal MMIO device pointers** (GUIDE KEEP list, methodology §3.6) |
| 66 | `__asm__(".local _st_slot / .section .bss / …")` storage blob | `_st_dma` 1, `StCdInterrupt` PASS (**INERT**) | **KEEP** — it is a *storage-placement* device, not a codegen fence: `nm` shows `00000000 b _st_slot` (object-owned .bss) with it, and a plain tentative definition makes it a **COMMON** again, re-opening the tree invariant W66-A3 closed (37 → 0 COMMONs). Flagged for the orchestrator: retire it only together with a `dlabel`/.ld cut for `_st_slot`, same device as `debug_cause`. |
| 67 | `extern volatile u_short *_st_slot` | `StCdInterrupt` **FAIL 1** (582/583) | **KEEP** — load-bearing *and* semantic (SotN's symbol-bearing C_011 proves `volatile u16 *`; the ring consumer clears the slot asynchronously) |
| 91 / 587 | `volatile int chcr` parameter | `_st_dma` **31** @109 | **KEEP** — W52-a2 lever (1): keeps the stack-passed CHCR word in its incoming home and loads it at the point of use; the value is a device word and `_st_dma` is an MMIO routine (GUIDE: "volatile is allowed in MMIO functions") |
| 171 | `volatile short hdr[4]` (stack scratch) | `StCdInterrupt` **FAIL 4** (581/583) | **KEEP-with-reason** — the only non-MMIO `volatile` in the TU; it stages the CD result/sub-header that `CdReady` fills behind the compiler's back, and its removal deletes two real insns |
| 177 | `volatile int *dly_` | `_st_dma` 1, `StCdInterrupt` PASS (**INERT**) | **KEEP** — MMIO pointer (`_cdrom_delay` = `0x1F801018`); dropping it would be semantically wrong even though it is gate-neutral |
| 306 | `(void)*(volatile u_short *)&_st_slot[0]` (else arm) | `StCdInterrupt` **FAIL 15** (578/583) | **KEEP** — W71-A9's cluster-(C) solution; the dead read is in the oracle and is honest semantics |
| 590 | `volatile int dummy` | `_st_dma` **37** @103 | **KEEP** — the DMA write-posting flush sink; without it both read-backs are dead-code-eliminated |
| 592 | `volatile int *p` | `_st_dma` **3** @105 | **KEEP** — MMIO channel-register cursor |
| 593 | `volatile int *dp` | `_st_dma` 1 (**INERT**) | **KEEP** — MMIO (`_dpcr` = `0x1F8010F0`); semantic, gate-neutral |
| 600 / 603 | `*(volatile int *)(0x1F801088 + (ch<<4))` | 27 @105 | **KEEP** — genuine MMIO (D\<ch\>_CHCR), see §3(a) |
| 820 | `*(volatile int *)_dicr` | (covered by line 590) | **KEEP** — MMIO |
| 832 | `__asm__ __volatile__("")` after the DICR read-back | `_st_dma` **17** @105 | **KEEP-with-reason**, see below |
| *(gone)* | `__asm__ __volatile__("")` inside the `dv/bit` block | replaced source-level | **REMOVED** ✅ |
| *(gone)* | `register int dv __asm__("$6")` | replaced source-level | **REMOVED** ✅ |
| 841 | `p = (volatile int *)(0x1F801080 + (ch<<4))` | (covered by line 592) | **KEEP** — MMIO |

### The one retired fence — how
The in-block barrier existed to stop sched1 sinking the `li $v1,1; sllv $v1,$v1,$a2` pair
two insns past the `lui $a1 / ori $a1` address pair (5 diffs without it). Spelling the
shift as **two statements** holds the pair in place with no device:

```c
bit = 1;
bit <<= dv;          /* was:  bit = 1 << (dv + 3);  + an __asm__ __volatile__("") fence */
```

Falsified first (all without the fence): four statement orders of `{dv, bit, p, dp}` — all
**5**; `bit` computed last — 5; `p` hoisted out of the block — 34 @106; `dp` hoisted out —
28 @106.

### The one kept fence — why (measured negative)
Retail keeps the DICR read-back **serial** (`lui;lw;nop;lw;nop;sw`). Without a whole-block
barrier sched1 **sinks the entire read-back below the `dv`/`bit` chain** and interleaves it
(17 diffs @105 — see the hunk in the receipt's raw log). No source-level substitute exists
on this compiler:

* in gcc-2.7.2's `sched.c` **only an asm gives a whole-block barrier** — a volatile MEM
  orders against other MEMs but not against the ALU insns that do the filling (confirmed in
  the failing output: the non-volatile `lw $a0,_dpcr` moves *between* the DICR pointer load
  and its volatile deref);
* the read-back's `sw $v0,16($sp)` is a **leaf with no data successor**, so its sched
  priority is minimal and it is *always* the last thing placed;
* the whole tail from the `if (mode == 1)` merge to the CD-ready loop is **one basic block**,
  so statement order is inert by construction (six orders measured, §above).

It is also transplanted verbatim from the 100%-byte-exact Rage Racer `CD_dmastart`
(`C:/Temp/rage-racer-decomp/src/main/PAL/lib/libcd/dma_start.c`), i.e. a reference-decomp
idiom rather than an invented device. Restored verbatim and receipted per the GUIDE's
iron rule.

---

## 5. NEXT NAMED ANGLES (unmeasured, for whoever picks this up)

1. **Vendor-cc1 acquisition (unchanged, now with a sharper test).** A 2.7.2-codegen cc1 with
   post-2.7.2 `reorg` closes `_st_dma` outright. Probe: compile
   `scratchpad/w84/rtl/stcdint.i` and read the insn after `beq $2,$0,$L…` — `li $2,1` =
   2.7.2 reorg (no good), `li $6,0x00010000` = the retail steal (that is the compiler).
   Candidates not on disk: gcc 2.7.2.1/.2/.3 PSX builds, SN drops between sn0003 and
   sn0004(970404).
2. **The kept fence (line 832) is a `sched.c`-identity question, not a source question.**
   The only source-reachable route would be a data successor for the DICR read-back, which
   retail does not have. If a future wave gains a per-TU/per-fn scheduler-flag splice, the
   cell to price is `-fno-schedule-insns` on `_st_dma` only (whole-TU it was 33 @109 in W75).
3. **Not worth re-running** (all measured here or in W84-C4 and reconfirmed in the new
   pin-free basin): named-limit family, `mode`-read placement, `& 0`-style fake dependences,
   the 2.6.0→2.8.1 rung ladder, statement order in the tail block, cast-away-`volatile`.
