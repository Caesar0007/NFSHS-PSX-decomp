# W60-A1 RECEIPTS — link-model triage lead + the libetc/libcard/libmcrd/libapi belt

Baselines were RE-GATED at start; the briefing numbers were stale in both directions
(see the ledger). All gates = `tools/tugate.py` / `tools/verify_asm.py`, run from repo
root, gated twice after every landing.

## 0. Belt ledger (re-gated baseline -> final)

| TU | baseline (re-gated) | final | note |
|---|---|---|---|
| `syslib/psx/libetc/INTR.c` | 10/13 PASS; `_initIntr` 6, `_set_intr_callback` 27, `_intrhand` 49 | 10/13 PASS; 6, 27, **44 count-exact** | 12 inversions -> 0; `_intrhand` advanced (below) |
| `syslib/psx/libetc/INTR_VB.c` | 4/4 PASS | 4/4 PASS | 3 inversions -> 0; offsets now EXACTLY retail |
| `syslib/psx/libetc/VSYNC.c` | 2/2 PASS | 2/2 PASS | 1 inversion -> 0; offset EXACTLY retail |
| `syslib/psx/libcard/PATCH.c` | 4/4 PASS | 4/4 PASS | 2 inversions -> 0 **+ a real missing word** |
| `syslib/psx/libmcrd/BIOS.c` | 17/17 PASS | 17/17 PASS | 2 inversions -> 0; EVERY offset now EXACTLY retail |
| `syslib/psx/libapi/FIRST.c` | 0/2; `_first_patch` 2, `firstfile` 6 | 0/2; 2, 6 | 1 inversion -> 0; offsets EXACTLY retail; FAILs PROBED-BLOCKED |
| `syslib/psx/2mbyte/2mbyte.c` | **4/4 PASS** | 4/4 PASS | briefing said "stup0 42.86% FAIL" -- STALE, sealed in W52 by the verify_asm alabel-`.word`/`dword` fix. No work needed. |
| `syslib/psx/libpad/**` | -- | -- | **SKIPPED-USER-LIVE** (user's belt this session; `git status` showed MCXMAIN.c/PADMAIN.c/PADSEQD.c modified). PADCMD.c (12) / PADSEQD.c (3) inversions left for the owner. |

Belt totals: **21 inversions -> 0**, **zero PASS->FAIL**, one function advanced
49 -> 44 at count parity, one real (runtime-visible) defect fixed.

## 1. DELIVERABLE 1 — the link-model verdict

Full write-up + evidence: **`scratchpad/w60a1/LINKMODEL.md`**. Headline:

> Placement is **PER-OBJECT-SECTION**. GNU ld copies an input `.text` verbatim and never
> reorders symbols inside it, so intra-TU order IS linked VA order and every inversion is
> a real defect. Per-symbol placement does not exist here and could not mask it. The only
> reason inversions are not *currently* wrong VAs is that `linkers/nfs4.ld` is STALE and
> links **zero** reconstruction text (`nfs4_TEXT_SIZE = 0`, 12 objects LOADed, the other
> 459 `src/*.o` + all `build/recon/**` never presented to ld). For the TRUE-SOURCE goal
> the answer is the same but stronger: retail's VA layout IS each object's internal
> function order, so an inverted TU cannot produce retail's VAs under ANY whole-object
> linker — it is a wrong reconstruction of the source file.

Receipts: an actual ld probe of `INTR.c.o(.text)` at retail's base put **13/13 functions
at the wrong VA** (table in LINKMODEL.md §1.1); the in-tree `build/nfs4.map` shows
`.text 0x0` for both linked code objects (§1.2).

**Risk tiering** (tools written for this: `scratchpad/w60a1/xfn.py`, `tier.py`; output
`xfn_all.txt`, `tier.txt`):

* **tier 1 = 0 objects.** Class A (assembler-baked cross-function branch, the MSC02
  byte-visible class) has exactly **ONE site in the whole tree** — MSC02's
  `VectorNormalS -> VectorNormalSS` — and it is already fixed and no longer inverted.
* **tier 2 = 46 objects** (inverted + a relocation naming a same-object function: wrong
  VAs including its own intra-TU call targets).
* **tier 3 = 3 objects** (no intra-object refs: wrong VAs for external callers only).

**Consequence:** since tier 1 is empty, NO inversion is reachable by any byte gate
(`verify_asm`, `tugate`, objdiff, even whole-object byte compare are all blind — a
function's bytes are position-independent inside its own `.text`). `tu_order_audit.py`
must become a standing wave-close gate.

Population snapshot: 250 inversions / 49 objects at my start (274 at f2170255); **159**
by the time this belt finished — the wave is clearing them concurrently. Tiering is
stable, counts are not.

## 2. DELIVERABLE 2 — the belt

### 2.1 Inversion fixes (6 TUs, all codegen-neutral)

Method per TU: re-gate -> move whole function DEFINITION blocks (with leading comments)
into `configs/symbol_addrs.txt` VA order, leaving file-scope data in place and adding a
forward declaration wherever a moved definition now follows its caller -> rebuild ->
re-gate (PASS set + per-fn diff counts must be identical) -> `tu_order_audit` silent ->
commit. Commits: `9282481e` INTR, `81c0f6aa` INTR_VB, `aecf5fc9` VSYNC, `66654f28` PATCH,
`08a11e65` BIOS, `7c4d4674` FIRST.

**LAW confirmed 6/6: reordering function definitions is codegen-neutral.** Not one PASS
changed and not one diff count moved. gcc-2.8 at -O2 does not inline non-`inline` statics,
and pseudo/label numbering is per-function, so definition order only moves the emission
offset.

**LAW (new, and the reason to do this beyond hygiene): once a TU is in VA order its
object offsets can be compared against the retail VA deltas directly** — instrument
`scratchpad/w60a1/ord.py`. 4 of 6 TUs then matched retail's spacing EXACTLY (INTR_VB,
VSYNC, BIOS, FIRST — BIOS on all 17 symbols). The two that did not each exposed something
real:
* INTR.c: a +4 drift from `_intrhand` being one instruction short — which is exactly the
  FAIL fixed in §2.2 (the offsets *diagnosed* it).
* PATCH.c: a genuinely **missing word** (§2.3).

### 2.2 `_intrhand` 49 -> 44, COUNT-EXACT 116/116 (`c34c2094`)

Two named mechanisms, both the delete_noop_moves / combine_regs identity (catalog w47
§A: *combine_regs refuses to tie when the destination is a GLOBAL allocno*):

1. **The `pend` temp.** Retail computes the pending-IRQ mask into a BLOCK-LOCAL pseudo,
   tests THAT, and copies it into the loop-carried `s0` in the branch's DELAY SLOT
   (`and v0,v0,v1; beqz v0,T; addu s0,v0,zero`) — at BOTH sites (entry test and the outer
   do-while back-edge). Assigning the AND result straight into `s0` (a multi-block global
   allocno) makes the copy the noop-move flow deletes, leaving a bare `nop` in each slot.
   A separate `long pend` restores both copies; spelling the mask
   `I_MASK & (state[0x18] & I_STAT)` also fixes the AND operand order (retail keeps
   `(state & I_STAT)` inner; the flat form lets fold reassociate I_MASK inward).
2. **The timeout read-then-copy — the missing 116th instruction.** Retail mutates the
   loaded pseudo IN PLACE for the store and keeps a COPY of the pre-increment value for
   the compare (`lw t; addu c,t,zero; addiu t,t,1; slti c,c,2049; ...; sw t`).
   `c = g; g = c + 1;` coalesces that copy away and lands the whole function one
   instruction short.

**FALSIFIED, count-exact basin:** flat `(state[0x18] & I_STAT) & I_MASK` 50; two-statement
`pend = state&I_STAT; pend = pend & I_MASK` 46; two-statement `I_MASK & pend` 46;
`I_STAT & (state & I_MASK)` 44 (ties); `(I_MASK & I_STAT)` for the closing timeout test 46.
**FALSIFIED, old 115-insn basin (04Z — re-test if the basin moves):** the catalog's
STORE-SIDE $at LEVER — `g_intr_timeout` as unsized `[]` and as sized `[1]/[2]/[4]` all
measure **48 @114/116**; they REMOVE an instruction rather than adding retail's copy.
`volatile int []` 53. **This is a genuine falsification of that lever at this site** —
worth a catalog row: the $at lever converts a macro store into a shared address register,
but where retail's extra instruction is a COPY (not an address), it subtracts instead.

**RESIDUAL (44, count-exact) = pure register ASSIGNMENT:** the AND chain lands in
{v0,a0} where retail uses {v1,v0}, and the two closing `lhu` land in the opposite pair.

### 2.3 PATCH.c — a real, runtime-visible defect found by the layout audit (`66654f28`)

splat's `endlabel func_8010CA40, 0x24` stops at 0x8010CA64, but the retail object carries
ONE MORE word there (the oracle `.s` prints it right after `endlabel`) and `_patch_card`
starts at 0x8010CA68 == blob+0x28. That word is **load-bearing**: `_patch_card2` copies
`[func_8010CA40+0x14, _patch_card)` as BIOS patch template 2, so with the word missing the
copy loop moves FOUR words instead of five and the `B0[0x57]` table-91 handler gets a
truncated template. Emitted outside the symbol behind an explicit `.type`/`.size` plus a
LOCAL `pad_8010CA64:` label (the label ends the objdump block so `verify_asm` still slices
exactly the oracle's 9 instructions). Result: 4/4 PASS held AND the object's layout is now
byte-exact retail (base+0x28 / +0xBC / +0x12C).

**NEW GENERAL ANGLE from this:** an oracle `.s` that prints instructions AFTER `endlabel`
is telling you the TU emits them; per-function gates can never see them, and they can be
semantically load-bearing when a sibling's loop bound is another symbol's address.
**Sweep candidate: every `asm/nonmatchings/**/*.s` with content after `endlabel`.**

### 2.4 FIRST.c FAILs — PROBED-BLOCKED, with the blocker named

`_first_patch` 2 / `firstfile` 6, unchanged by the reorder (the point of the check).
Both carry exhaustive W48/W59 in-source falsification lists including a full flag/version
re-ladder on the current basin. I did not re-fight them; instead the blocker:

**NEW NAMED ANGLE (wave-level): the whole libetc/libapi/libmcrd belt is on the `cc1_272`
lane, where the campaign's allocator instruments do not apply.** W59-11A records
`allocsim` at 6/10 on 2.7.2 dumps and `reqdelta` as *unusable in the 272/alt lanes*. Every
residual left on this belt — `_intrhand` 44 (register assignment), `_set_intr_callback` 27
(a documented three-pseudo local-alloc rotation), `_initIntr` 6 (a two-address-qty
handout), `firstfile` 6 / `_first_patch` 2 (a sched1 ready-list + reload-scratch tie) — is
a local-alloc/QTY question. So they are all blocked on the SAME missing instrument, and
"another spelling sweep" is provably the wrong budget. **Instrument request: extend
allocsim/reqdelta (or qtytrace) to the 2.7.2 lane** — that single item unblocks this whole
cluster, not one function.

## 3. Laws / catalog-row candidates (for the orchestrator to harvest)

1. **PER-OBJECT LINK LAW.** GNU ld `file.o(.text)` = verbatim copy, never per-symbol.
   Intra-TU definition order IS linked VA order, under both the current GNU-ld model and
   any period whole-object linker. Corollary: intra-TU order is a *source-reconstruction*
   property, not a link-script detail.
2. **REORDERING FUNCTION DEFINITIONS IS CODEGEN-NEUTRAL** (6/6 TUs, PASS sets and diff
   counts byte-identical). Cost: a forward declaration where a definition now follows its
   caller. So the inversion class can be swept aggressively.
3. **OFFSET-VS-RETAIL-DELTA IS A FREE SECOND GATE.** After a reorder, compare each
   symbol's object offset against `retailVA - firstVA`. Exact = the object reproduces
   retail's layout; a drift localises a wrong-length function (INTR) or a missing word
   (PATCH). Instrument: `scratchpad/w60a1/ord.py`.
4. **CONTENT AFTER `endlabel` IN AN ORACLE `.s` IS REAL TU CONTENT** the per-function
   gates cannot see, and may be load-bearing for a sibling's address-bounded loop.
5. **THE STORE-SIDE $at LEVER SUBTRACTS WHERE RETAIL'S EXTRA INSN IS A COPY.**
   `g_intr_timeout` as `[]`/`[1]`/`[2]`/`[4]` all lose an instruction (114 vs the needed
   116). Gate the lever on WHAT the missing instruction is: an address -> $at lever; a
   reg-reg copy -> the combine_regs/global-allocno device instead.
6. **THE COPY-vs-GLOBAL-ALLOCNO DEVICE, second confirmation** (both `_intrhand` sites):
   to keep a retail reg-reg copy, the PRODUCER must write a block-local pseudo and the
   long-lived variable must be assigned FROM it; writing the long-lived variable directly
   deletes the copy AND empties the delay slot it filled.
7. **A `nop`-in-a-delay-slot residual can be a deleted COPY, not a scheduling tie** — the
   copy and the slot fill are one decision (both `_intrhand` sites, and the timeout copy).

## 4. Hazards encountered

* **`FIRST.c` has MIXED line endings** (172 CRLF + 35 bare LF) — the documented hazard.
  The block move was done in byte mode with a bare-LF-count assertion; one closing brace
  flipped to CRLF and was restored numerically. Byte-check every scripted edit.
* **`git add -A` avoided throughout**; only explicitly-named paths were staged, one commit
  per TU, nothing pushed, no `git checkout`/`stash`/`restore` on any path.
* **Concurrent wave.** A8/A9/A10 and the user landed reorders on other TUs during this
  run; the audit total moved 250 -> 159 mid-belt. Never quote a stale audit count.
* All probe harnesses restore in `finally` and assert byte-identity afterwards
  (`probe_intrhand.py`, `probe_tmo.py`, `probe2.py`, `probe3.py` in this directory).

## 5. Files

* `scratchpad/w60a1/LINKMODEL.md` — Deliverable 1 (verdict + evidence + tiering).
* `scratchpad/w60a1/xfn.py` — cross-function-reference classifier (classes A/B/C).
* `scratchpad/w60a1/tier.py` — crosses inversions x classes into the tier table.
* `scratchpad/w60a1/ord.py` — object offset vs retail VA delta table (the free 2nd gate).
* `scratchpad/w60a1/probe*.py` — the falsification harnesses behind §2.2.
