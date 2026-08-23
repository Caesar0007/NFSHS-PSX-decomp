# W75-A12 REPORT — frontend belt (feapp / feaudio / front / psxcontroller)

Base commit `a604a578` ("Restore psxcontroller SYM type surface").
STEP 0 done: `reference_mips_isa_asm.md` + `reference_psx_cpp_reconstruction_methodology.md`
(full) + `reference_asm_pattern_catalog.md` tail (§18–§23 / W60–W74) + every target's
in-TU receipt block.

**Nothing landed.** All four TUs are byte-identical to HEAD; `tools/build.py` carries only
the foreign edits (the psxcontroller `InGame_ResetPSXController` TEXT_MOVES removal is
PRESERVED — `grep -c InGame_ResetPSXController__Fii tools/build.py` = 0 — and W75-A16's
`INTR.c` cc1-version row is untouched). `ast.parse` clean. No commits, no staging.

## SCOREBOARD (gated twice at the start and at the end; zero PASS→FAIL anywhere)

| fn | TU | baseline | final | posmis |
|---|---|---|---|---|
| `Redraw__14tFEApplication` | frontend/common/feapp | 10 @393/393 | 10 @393/393 | 25 |
| `FeAudio_InitViv__FPc` | frontend/common/feaudio | 2 @109/109 | 2 @109/109 | 2 |
| `GetPSXPadValue__Fii` | frontend/common/front | 12 @222/222 | 12 @222/222 | 4 |
| `InGame_GetPSXPadValue__Fii` | game/psx/psxcontroller | 76 @235/233 | 76 @235/233 | n/a (count-off) |

Whole-TU gates (twice, before and after): feapp 14/15 · feaudio 9/10 · front 42/43 ·
psxcontroller 3/4. **`InGame_ResetPSXController__Fii` still PASSes** after the user's
SYM-type restore + the build.py row removal — re-baselined and confirmed, twice.
`tools/textmoves_audit.py` (whole repo) unchanged at 3 pre-existing divergences
(DrawC_PrimClip, Hud_Init, __divdf3); `brdist` on feaudio 10/10 clean.

⚠️ ORCHESTRATOR POLICY (received mid-belt): post-recompile instruction rewrites are
FORBIDDEN. A probe-verified `PER_FN_TEXT_MOVES` row that took `FeAudio_InitViv` to
**PASS 109/109** was measured, then **removed** and is documented below as a row ask only.

---

## 1. `FeAudio_InitViv__FPc` — 2 @109/109. THE RESIDUAL IS NOW A CLOSED-FORM CERTIFICATE

### 1a. The residual, exactly
Whole-function byte-exact except a **two-line permutation of two independent insns** in the
loop-exit block:

```
retail : beq / lui $4,%hi [slot] / lw $7,16($sp) / addiu $4,$4,%lo / lui $8,255
ours   : beq / lui $4,%hi [slot] / addiu $4,$4,%lo / lw $7,16($sp) / lui $8,255
```

### 1b. 🏆 NEW LAW — WHY THE HEAD FENCE CAN NEVER LET THE LOAD PAST THE `la`
`sched.c:1987` (gcc-2.8.1): `if (code != ASM_OPERANDS || MEM_VOLATILE_P (x))` — an
**output-less asm is ASM_INPUT/volatile ASM_OPERANDS**, so `sched_analyze_2` adds a data
dependence on **every register's last set** and flushes the pending-mem lists. The shipped
head fence therefore welds the block into a hard chain `lui → addiu → fence → lw`
(read straight off the cc1 `.sched` dump: `T-43: 72, T-44: 66, T-45: 64, T-46: 63`, each
cycle a single-element ready list = no choice at all). No fence PLACEMENT can express
"below the mask but above the `la`'s second half", because the `la` is one C token.

### 1c. 🏆 NEW LAW — AN ASM CONSUMER COLLAPSES A LOAD'S LATENCY TO 1, WHICH IS THE ONLY
### THING THAT PRODUCED RETAIL'S ORDER
With **no** head fence, cc1plus emits retail's `lui $4 / lw $7 / addiu $4` **verbatim**
(measured `.s`, `scratchpad/w75/A12/d_nofence/v.s`). The mechanism is the reverse list
scheduler: the `lw`'s first consumer is `sll $3,$7,24`, whose dependence carries the LOAD
latency, so the `lw` becomes ready one cycle later than the `addiu`, is picked later, and is
therefore **placed earlier**. Put ANY asm immediately after the load and its dependence
cost drops to 1, the load becomes ready with the `addiu`, and the order reverts to
`lui/addiu/lw` — measured identically in four independent spellings:
`W1` fence-after-type-read **7 @110**, `Y1` `lumpyName` inside the block **7 @110**,
`Y5` fence carrying `"r"(lumpyName)` **7 @110**, `Y6/Y7` fence carrying `"r"(swappedType)`
**23 @110**. In every one of them the `nop` appears in the load-delay slot, i.e. the
selective barrier is available but it costs the very ordering it was bought for.

### 1d. The no-fence basin's own 2 diffs, root-caused
Sole diff is the position of the shared `lui $8,255` (0xff0000): it is stolen into the `beq`
delay slot instead of retail's `lui $4`. Read off the cc1 `-dR` (sched2) dump: the mask insn
(p81, priority 1) sits in the ready list from T-36 to T-43 and loses **every** pick — and at
T-40 the ready array is `[64(addiu), 81(li)]` with **no insn newly ready**, so
`SCHED_SORT` (`sched.c:2403-2408`) is a **no-op that cycle** (`if ((NEW_READY)-(OLD_READY)==1)
swap_sort; else if (>1) qsort;` — nothing at 0) and `ready[0]` is simply whatever the T-38/T-39
sort left in front. **NEW MECHANISM: a ready-list tie in gcc-2.8 sched is frequently decided
by a STALE ORDER, not by priority/class/LUID at all** — this is why every priority/ref/live
dial on the mask constant is inert (measured this belt: naming the mask before the type read,
after the type read, with and without the head fence — **all four exactly 2**, byte-identical).

### 1e. Compiler-input (flag) axis — CLOSED
`-fno-schedule-insns` → `lui/addiu/lw/li` in BOTH basins (not retail).
`-fno-schedule-insns2` → `lui/addiu/lw` + a real `#nop` (fenced) / mask-in-slot (no-fence).
Retail's order is produced by **sched2 only**, and sched2 is also the pass that hoists the
mask: one pass, two effects, so no per-TU/per-fn flag can separate them.

### 1f. 🔴 ROW ASK (documented, NOT wired — policy)
A single `PER_FN_TEXT_MOVES` row makes this fn **PASS 109/109** with **no source change**:

```python
"recon/frontend/common/feaudio.cpp": {
    "FeAudio_InitViv__FPc": [
        {"take":  r"\tlw\t\$7,16\(\$sp\)\n",
         "after": r"\tlui\t\$4,%hi\(\$LC\d+\) \# high\n"},
    ],
},
```
Pre-flight, all checked: both anchors match **exactly once** in the `.ent/.end` region;
numeric registers only; label-number agnostic; the take is **not** a branch/label/`.set`
line; the anchor **is** the delay-slot line so the slot is never emptied (`drop_after`
unused); the diff is a pure two-line multiset permutation. Measured: gate **PASS**,
TU 10/10 PASS twice, `brdist` 0 divergent, `textmoves_audit` clean for this fn.
⚠️ It is nevertheless **shim-masked in production**: `psyqproof` on the moved basin reports
`REAL=1 RELOP=1` at words 16/17 — i.e. the real cc1+ASPSX lane does not perform the move.
That is an independent argument for the new policy; the row is left unwired.

---

## 2. `Redraw__14tFEApplication` — 10 @393/393 (posmis 25). W74's NAMED ANGLE IS NOW CLOSED

W74-A7 banked a **5 @394/393** basin (`*(u_char *volatile *)0x1f800004 = ...`) whose single
residual was named as *"the read sharing the volatile store's address pseudo"*. Reproduced
this belt as a control (**R10 = 5 @394**, exact).

### 2a. 🏆 NEW LAW — THAT SHARE IS UNREACHABLE BY CONSTRUCTION
gcc-2.8.1 `config/mips/mips.c:1297` (loads) and `:1492` (stores) wrap **every volatile MEM**
in `%{ ... %}`, and `print_operand` (`mips.c:4031-4041`) turns those into
`.set volatile` / `.set novolatile`. The address register of a volatile absolute access is
therefore materialized **by the assembler inside a `.set volatile` region**, per access —
there is **no RTL pseudo** for cse/gcse to common, so two volatile accesses can never share
an address register, and a volatile and a non-volatile access never can either.
Confirmed empirically: three different spellings of "both sides volatile" are **byte-identical
at 70 @395** — `S7` `*(u_char *volatile *)0x1f800004` both sides, `S2`
`((u_char *volatile *)0x1f800000)[1]` both sides, `S6` mixed. ⇒ the 5-basin's +1 insn is a
**hard floor**, and W74's named angle is retired.

### 2b. New falsifications (all reverted)
* `R5` volatile-abs READ in both arms + macro store — **11 @394**.
* `R9` volatile-abs read in ONE arm only — **18 @397**.
* `T1` packet store moved FIRST in the 10-basin — **exactly 10 @393 (INERT)**. This is a
  positive control for W74's mechanism (1): in the macro-store basin the store is
  `.set nomacro`-ineligible for a delay slot, so its statement position cannot matter.
  W74's `store first = 26 @393` belongs to the cell/14-basin only.
* `T2` volatile-abs store moved FIRST — **5 @394**, i.e. position is inert there too.

### 2c. NEW NAMED ANGLE
Every route now splits cleanly in two, and only one is open:
1. **volatile store** (5 @394) — CLOSED by 2a (assembler-side address, +1 insn floor).
2. **`pc` cell / non-volatile store through a register base** (14 @393) — the store becomes
   one slot-eligible `sw v0,0(t0)` and reorg steals it for the `SetDrawArea` jal slot, which
   is *also* what displaces `addiu a1,sp,56` and drops fYOffset to `$a1`.
   ⇒ **THE ONE REMAINING QUESTION: deny reorg that steal without putting an asm in the
   block.** `reorg.c:685-712 stop_search_p` fires on any asm, so a fence is self-defeating;
   the packet-store-first spelling reaches 26 @393 by making the palette store adjacent to the
   `jal` but pays a different cluster. The wanted device is a *source-side* reason for the
   packet store to be unmovable that is neither `volatile` (2a) nor an asm — e.g. an
   alias/dependence edge (14D `MEM_IN_STRUCT_P` dial) between the packet store and the
   `SetDrawArea` argument set-up. Untried and cheap: give `daprim`/`r` a spelling that makes
   `sched.c:846-56` chain the packet store to the call's own MEM operands.

---

## 3. `GetPSXPadValue__Fii` — 12 @222/222 (posmis 4). GROUP ATOMICITY EXTENDED

Residual is exactly 2 shared tails × 6 lines: retail `or a2,a2,a1 / j / ori v0,a2,1` (G1)
and `or a1,a1,v1 / j / ori v0,a1,1` (G2); ours writes a fresh `$a0` dest in both. The
accumulator register itself is **already correct in both tails** (`or a2,a2,v0` /
`or a1,a1,v0` are byte-exact) — only the LAST `or`'s dest differs.

### 3a. New falsifications (all reverted)
* **`P1`/`P2` per-group variable + incremental accumulation** (`g1 = player<<0x1e; g1 |= …;
  g1 |= …; return g1|1;`, the untried cross of W71-A6(a) "per-group locals are byte-neutral"
  and W71-A6(d) "incremental decomposition") — **100 @216** (G1) / **64 @216** (G2), i.e.
  **6 insns SHORT**. Mechanism: one variable assigned in three arms hands gcse a common
  subexpression, the per-arm `sll aN,s1,30` is hoisted out of the arms, and retail's
  delay-slot materializations vanish. This closes the per-group×incremental cell.
* **`U1`/`U2` partial-group acc conversion** (block-local `acc` + clobber in arms 2,3 only)
  — G1 **19 @227**, G2 **30 @228**, both strictly worse and count-off. ⇒ **the ACC
  conversion is atomic per shared-tail group exactly like the clobber is** (extends 23B-5:
  the cross-jump group must be converted whole, and "whole" includes the accumulator
  spelling, not only the fence).
* `U3` G2 trio acc+clobber — **30 @224**, reproduces W72's number exactly (control OK).

### 3b. NAMED ANGLE (sharpened, unchanged in target)
W74's ask stands and is now bounded from a second side: arm 1 of G1 must lose `$v0`/`$v1`
over the accumulator's window **without any asm in that block** (any asm kills both the
shared `lui/addiu frontEnd` pair and the `j`-slot accumulator birth). Per 16B
(hard-regs-only availability) local-alloc sees only HARD registers, and arm 1 is call-free,
so no natural liveness exists to deny with — the denial must come from **qty ORDER**, not
occupancy: make the accumulator the 5th-priority qty in arm 1's block (it currently is when
it is the anonymous `player<<0x1e` temp, which is why `or a2,a2,v0` already matches, and it
is NOT when it becomes the named block-local acc, whose extra refs promote it to first).
⇒ the instrument to ask for is a **ref-DEcrementing / live-length-INcreasing zero-insn dial**
(the mirror of 21A(1)'s read-only fence, which only ever adds refs), or an `allocsim
--what-if` sweep over arm-1 qty orders before any further spelling work.

---

## 4. `InGame_GetPSXPadValue__Fii` — 76 @235/233. RE-BASELINED, NOT MOVED

The whole TU was re-baselined after the user's `a604a578` restore + the uncommitted
build.py row removal: **3/4 PASS, `InGame_ResetPSXController__Fii` PASS 305/305**, and this
fn at **76 @235/233** (the user's own W78 receipt records the 97 @234 → 76 @235 landing, so
the board's 98.30→97.15 drift is the +1 insn, not a regression in diffs).

Full side-by-side captured at `scratchpad/w75/A12/ingame_sbs.txt` (26 mismatching lines).
Structure of the residual, read off it:
* **+2 insns = a dispatch-chain materialization deficit.** Retail carries an extra
  `sll a1,s1,2` at oracle index 32 that we do not emit, and we carry three extras later
  (`li a0,128` @90, `sll a1,s1,2` @99, `sll a0,s1,30` @103). Retail materializes the
  player-scaled address and the `player<<30` term ONCE, in dispatch **branch delay slots**,
  and re-uses them across arms; we rematerialize per arm.
* **The rest is one role swap**: in the negative-tail arms retail keeps the address in `$a1`
  and `player<<30` in `$a0`; ours is the mirror (`addu a0,a0,v0` / `lw v1,136(a0)` vs
  retail `addu a1,a1,v0` / `lw v1,136(a1)`).

I did **not** probe this fn: the user's concurrent session is actively landing on it (W76,
W77, W78 receipts all dated today, in-file) and duplicate spelling sweeps on a shared working
copy risk clobbering. Its own W78 named angle ("the negative-tail route requires a source use
that attaches to the EXISTING shared 0x80 qty, not another literal qty") is unchanged and is
consistent with the sbs above; the `+2` half of the residual is a **dispatch-slot
materialization** question, not a tail question, and should be priced separately from it.

---

## 5. ARTIFACTS
`scratchpad/w75/A12/` — `probe.py` (generic apply/gate/restore harness, byte-mode,
CRLF-preserving, always restores), `dump.py` (cc1plus `.s` + `-dS`/`-dR`/`-dl`/`-dg` dumps for
one recon TU with optional edits), `addrow.py` (the build.py row add/del used for the InitViv
row probe — the row is REMOVED; the script is kept as the receipt), `viv1..4.json`,
`rd1..3.json`, `pad1..2.json`, `ed_nofence.json`, `d_fence/`, `d_nofence/` (the two dumped
basins), `ingame_sbs.txt`, `pad_sbs.txt`, `probe_log.txt`.
