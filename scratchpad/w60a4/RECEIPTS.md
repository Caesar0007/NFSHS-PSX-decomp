# W60-A4 receipts — belt: `recon/syslib/psx/libcd/**` (except `iso9660.c`, USER-DIRTY)

Gate: `python tools/verify_asm.py` / `tools/tugate.py`, cc1_272 lane as wired.
Every number below was re-gated by me; all TUs gated twice after each landing.

---

## 0. BASELINE (re-gated at wave start, after a fresh `build.py --skip-asm`)

| TU | PASS | FAILs (diffs) |
|---|---|---|
| TYPE.c | 2/2 | — |
| cdcont.c | 18/19 | CdControl 8 |
| cddebug.c | 0/0 | — |
| cdread.c | 3/6 | _read_int 21, _read_issue 23, CdRead 43 |
| cdread2.c | 2/2 | — |
| cdtables.c | 0/0 | — |
| drv.c | 7/13 | CD_datasync 8, CD_init_80108140 10, CD_ready 22, CD_sync 22, CD_get_intr 61, CD_cw 84 |
| event.c | 5/5 | — |
| stcdint.c | 1/3 | _st_dma 25, StCdInterrupt 36 |
| stream.c | 3/3 | — |
| streamhelp.c | 5/6 | data_ready_callback 9 |
| toc.c | 1/2 | CdGetToc2 64 |

Belt FAIL total **436 diffs**.  Briefing rows that were STALE: `StGetNext` (99.89%) already
PASSes; `CD_sync`/`CD_ready`/`CD_datasync`/`CD_get_intr` percentages did not match the real
diff counts.

## FINAL (re-gated after a fresh full rebuild)

| TU | PASS | FAILs (diffs) |
|---|---|---|
| cdcont.c | 18/19 | CdControl 8 |
| cdread.c | 3/6 | _read_int 21, _read_issue 23, CdRead 43 |
| drv.c | 7/13 | CD_datasync 8, **CD_ready 8**, **CD_sync 8**, **CD_get_intr 10**, CD_init_80108140 10, CD_cw 84 |
| stcdint.c | 1/3 | _st_dma 25, StCdInterrupt 36 |
| streamhelp.c | 5/6 | data_ready_callback 9 |
| toc.c | 1/2 | **CdGetToc2 56** |
| everything else | unchanged | — |

Belt FAIL total **349 diffs** (**−87**).  **ZERO PASS→FAIL** anywhere.

---

## 1. INVERSIONS — 23 → 5 (the 5 left are all in the USER-DIRTY `iso9660.c`, skipped)

Procedure per the briefing: rebuild + tugate baseline, move whole function definition
blocks into `configs/symbol_addrs.txt` VA order, leave file-scope data alone, add forward
decls, rebuild, tugate (PASS set must be identical), `tu_order_audit.py`, commit per TU.
All moves were done at the BYTE level (python `os.replace`) so each file's line-ending
regime survives verbatim — `streamhelp.c` is LF-only, `toc.c` is MIXED CRLF/LF, the rest
CRLF.  Post-edit control-byte scans clean.

| TU | inversions | fix | gate before → after |
|---|---|---|---|
| drv.c | 11 | `_cd_intr_dispatch` (@0x80108680, the HIGHEST VA) sat 2nd in source → moved to the TU END + forward decl | 7/13 → 7/13, all diff counts identical |
| event.c | 2 | retail order is CdInit 0x8010908C < _cd_event_init < _cd_event_sync/ready/read; source had them reversed → CdInit first + 4 forward decls | 5/5 → 5/5 |
| toc.c | 1 | CdGetToc 0x8010929C before CdGetToc2 0x801092C0 | 1/2 → 1/2, CdGetToc2 64 → 64 |
| cdread2.c | 1 | CdRead2 0x800F8F48 before _cdread2_ready 0x800F8FCC | 2/2 → 2/2 |
| stcdint.c | 1 | StCdInterrupt 0x800F7E78 before _st_copy_words/_st_dma | 1/3 → 1/3 |
| stream.c | 1 | StClearRing 0x800F8968 before StSetStream/StSetRing | 3/3 → 3/3 |
| streamhelp.c | 1 | StUnSetRing 0x800F8EC8 before StGetNext/StFreeRing/... | 5/6 → 5/6 |

Commits: `libcd/drv.c: move _cd_intr_dispatch…`, `libcd/event.c: reorder…`,
`libcd/toc.c: reorder CdGetToc…`, `libcd: reorder cdread2/stcdint/stream/streamhelp…`.

**LAW (new):** the drv.c case shows one mis-placed function can invert an entire object —
11 rows collapsed to 0 with a single block move.  Always look for the single HIGHEST- or
LOWEST-VA outlier before hand-sorting a whole TU.

---

## 2. SEALS / REDUCTIONS

### 2.1 `CD_ready` 22 → 8 — **PER-REGION FIELD ANCHORS (catalog 11D)**  *(committed)*

Retail derives BOTH `Intr` sub-field addresses from the single `&Intr` base —
`addiu s6,s2,1` (`&intr->ready`, consumed by the drain) and `addiu s4,s2,2` (`&intr->c`) —
then **reads** the two poll bytes through the **+2 anchor** (`lbu 0(s4)` = c,
`lbu -1(s4)` = ready) and **writes** the clears through the **base**
(`sb zero,2(s2)`, `sb zero,1(s2)`).

Three cooperating edits, each measured:

| step | result |
|---|---|
| (a) inline the drain here with the local pointers (`*readyp`, `intr->sync`) instead of the shared `callback()` — `callback()` reaches the `Intr` GLOBAL, so gcc materialized `&Intr` a second time and cse turned it into the copy `addu s5,s2,zero` retail does not have | **59** (175 insns, 3 SHORT) |
| (b) `cflag = &intr->c`, reads AND writes through it | **45** (179 insns, +1) |
| (a)+(b) | **30**, count-EXACT 178/178 — residual = an s3/s4 band swap + the two stores |
| (c) asymmetric access: READ via `*cflag` / `cflag[-1]`, WRITE via `intr->c` / `intr->ready` | **8** |

(c) is the load-bearing half: dropping `cflag`'s ref count by 2 hands it `$s4` and the
result pointer `$s3` (retail's band) AND restores the base-relative `sb`s.
Declaration/assignment POSITION of `cflag` was swept 3×2 (first/after-intr/last ×
early/late) — **all 45**, position is NOT the dial here.

### 2.2 `CD_sync` 22 → 8 — **identity fence keeps the MASKED byte live**  *(committed)*

Retail's tail runs on the masked byte: `lbu v0,0(s2); andi a2,v0,255; beq a2,s3; bne a2,v0;
… addu v0,a2,zero`.  The raw `lbu` result dies at the mask and `$a2` carries the value to
the return, leaving `$a3` for the `_memcpy8` −1 sentinel.  Ours returned the RAW byte — cse
substitutes it for the mask result (the two are provably equal after an `lbu`) — which
pinned the raw pseudo to the exit and put the sentinel in `$a2`.

A zero-insn **identity fence** on the masked value makes it cse-opaque; 6 of the 22 diffs
(load reg, mask reg, both compares, sentinel, return copy) resolve at once.

### 2.3 `CD_get_intr` 61 → 10 (count-EXACT 343/343) — five levers + **1 REAL BUG**  *(committed)*

| # | lever | result |
|---|---|---|
| 2 | **DOUBLE `CD_debug > 0` GUARD** in the `nReg==5` arm — retail guards BOTH the `puts("DiskError: ")` and the printf (the second test survives cse because the intervening `puts()` may clobber the global).  **REAL BEHAVIOURAL FIX: retail does not print "DiskError: " when CD_debug is 0.** | 61 → 56 |
| 1 | **OPAQUE `Intr` BASE** — a block-local `volatile u_char *b = &Intr` is NOT enough (gcc const-folds the pointer back into the store address, giving the assembler's absolute `lui at; sb v0,Intr+N` macro).  A zero-insn **identity fence on the pointer** makes it opaque → retail's `lui v0; addiu v0,v0,0; sb v1,1(v0)` / `sb v1,2(v0)` / `lbu v1,2(v0)`.  cases 4+5: 56→39.  case 1: 39→33.  **case 2 REGRESSES under the same edit (39→42) — retail really does use the absolute macro there.** | 56 → 33 |
| 3 | **NON-VOLATILE ALIAS READ** `*(const unsigned char *)&nReg` at the two constant compares ONLY.  `nReg` must stay `volatile u_char` (the `sb 16(sp)`/`lbu 16(sp)` round-trip depends on it), but a volatile QImode read cannot fold its zero-extend into the load — that is where our two redundant `andi v0,v0,255` came from. | 33 → 21 |
| 4 | ternary value into a named local BEFORE the base in case 1 (retail materializes the base after the 5/1 select) | 21 → 17 |
| 5a | identity fence on `i` between the two fill loops — retail RE-EVALUATES `i < 8` as the second loop's entry guard where ours cse-shared the value it had speculated into the break-branch delay slot | 17 → 16 (count-exact) |
| 5b | `&result[i]` taken BEFORE the CDREG0 test in the fill loop — retail fills the `beqz` delay slot with `addu v1,a0,s0`, which reorg's backward scan can only steal if the address is computed BEFORE the branch | 16 → 10 |

FALSIFIED on the way: plain non-volatile `nReg` (163), non-volatile + an `"m"` constraint
(77), `(unsigned char)` casts on the compare constants (inert), the non-volatile alias on
the `switch` selector (inert), `j != 8` guard (25), while-form second loop (17), void-tail
fence between the loops (16, same as the `i` fence), a `dst` local before the fenced base in
cases 4/5 (10, .s order unchanged), the same with the memcpy call pulled inside the block
(10), an identity fence on `dst` as well (32).

### 2.4 `CdGetToc2` 64 → 56 — **MAGIC-RECIPROCAL SHARING (catalog 09H), partially landed**  *(committed)*

A named `int magic = 0x66666667;` plus a zero-insn **read-only fence on it at the top of the
TRACK-LOOP BODY** (in-loop ⇒ +2 refs ⇒ callee-saved rank) reproduces retail's preheader
hoist exactly — `sw s5,52(sp); lui s5,26214; ori s5,s5,26215` and the 7-callee-saved-register
frame — which retires the whole s0/s1/s2/s5/s6 band rotation the previous basin carried.

**POSITION IS THE DIAL** (measured): fence at the FUNCTION TOP = 66 diffs but count-EXACT
137/137 (the magic lands in a caller-saved `$t0`, the loop still rematerializes its own);
fence IN THE LOOP = 56 at 139 (+2); fence at BOTH = 56; the magic local with NO fence = 64
(inert, identical to the pre-W60 form); a 2-operand read-only fence = 69.

---

## 3. RECEIPTED RESIDUALS / NEW NAMED ANGLES (no code change)

### 3.1 The shared timeout-printf sync-chain register — 8 × 3 (`CD_sync`, `CD_ready`, `CD_datasync`)
After 2.1/2.2 this is now the **whole** residual of all three functions: retail runs the
`CD_intstr[intr->sync]` chain in a SEPARATE scratch (`lbu a0; sll a0; addu a0,a0,sN;
lw a3,0(a0)`), ours self-temps it in the arg register (`a3` throughout).  The W55-A5 in-source
receipt already carries the RTL-level mechanism (sched1 hoists the `$LC5` format-string
`a0`-set, making `$a0` live over the chain qtys, so local-alloc's numeric first-free scan
falls through to `$a3`).  I re-confirmed the class transfers unchanged after both of this
wave's CD_sync/CD_ready landings.  **NEXT ANGLE stands: an insn-level sched1 instrument
(cc1 sched-dump-driven priority dial).**  TEXT_MOVES cannot help — the final text order
already matches, only the register differs.

### 3.2 `CD_get_intr` residual 10 = **pure line order → `PER_FN_TEXT_MOVES` spec**
- **8 diffs:** in switch cases 4 and 5 retail emits the `_memcpy8` DESTINATION `la` BEFORE the
  Intr-base `la`.  Ours emits the base first because the identity fence (lever 1) is a
  scheduling barrier the dest `la` cannot cross.  Current `.s`
  (`build/recon/syslib/psx/libcd/drv.c.s`):

  ```
  $L71:                       $L84:
      la  $2,D_8013C224           la  $2,D_8013C224
   #APP                        #APP
   #NO_APP                     #NO_APP
      la  $4,D_801489AC           la  $4,D_8014899C
  ```
  retail wants the `la $4,…` line FIRST in both blocks.  Suggested entries for
  `PER_FN_TEXT_MOVES["recon/syslib/psx/libcd/drv.c"]["CD_get_intr"]`, applied in order:
  ```python
  {"take": r"\tla\t\$4,D_801489AC\n", "after": r"\$L71:\n"},
  {"take": r"\tla\t\$4,D_8014899C\n", "after": r"\$L84:\n"},
  ```
  (⚠️ `$L` numbers are build-dependent — the orchestrator should re-derive them, or anchor on
  `\tj\t\$L99\n\$L71:\n` / the preceding `j` to make the match unique.  `la $4,D_8014899C`
  occurs more than once in the TU, so the case-5 entry must be anchored, not bare.)
- **2 diffs:** ours steals `li v0,5` into a `beqz` delay slot where retail has a `nop`.

### 3.3 `data_ready_callback` 9 — fenced basin re-probed, still not beaten
The W55-A5 in-source receipt already documents that an identity fence on `dst` gives the
structurally correct anchor (count-EXACT 35/35) but scores 10 because the anchor lands in
`$a0` where retail has `$a2`.  **New falsifications this wave (all count-exact 35/35):**
fence placed after the status store = **10**; fence + an identity fence on `slot` as well =
**28**; a read-only operand `"r"(slot)` added to the same fence = **10**.  The un-fenced
9-diff form is still the gate optimum; the register-assignment dial inside the fenced basin
is the open angle.

### 3.4 `CdControl` 8 (cdcont.c) — two clusters, both named
1. **6 diffs:** the prologue parm-copy pair `sw s4,32(sp); addu s4,a0,zero` is emitted AFTER
   `sw s0,16(sp); li s0,3` in ours, BEFORE it in retail (a sched1 tie at the top of the first
   BB).  Source statement order is already retail's (`cmd = com;` precedes `retries = 3;`) and
   is INERT: moving `retries = 3` after `command = …` = 8, moving it to the last preamble
   statement = 8.  Rage Racer's byte-exact `CdControl` reaches it with `register long cmd
   asm("$20")` + an identity fence; we already GET `$s4` without the pin, and adding **only**
   the identity fence rotates the whole s-band → **22** (falsified).  Whole-TU
   `-fno-schedule-insns` → **worse** (measured via a scratchpad copy of verify_asm).
   ⇒ a 2-line `PER_FN_TEXT_MOVES` (move the `sw $20,32($sp)` + `addu $20,$4,$0` pair up two
   slots) would take it to 2; it cannot reach PASS alone.
2. **2 diffs:** `li v0,1` (ours) vs `li t0,1` (retail) for the `command != 1` constant — a
   local-alloc `find_free_reg` handout; likely a knock-on of cluster 1's luid shift.

### 3.5 `CD_cw` 84 — probed, no landing
The CD_ready/CD_get_intr opaque-base lever does NOT transfer: an identity fence on the
function-scope `ip = &Intr` gives **103**; + routing the `while (Intr.sync == 0)` read through
`ip` **107**; + routing the return test through `ip` **91**.  Structural gap remains: ours
uses a **72-byte frame with 7 saved regs**, retail a **56-byte frame with 8** — i.e. retail
buys one more callee-saved register and 16 fewer bytes of stack.  Named angle: find the 16
bytes of stack our version carries (outgoing-arg/local sizing) before any coloring dial.

### 3.6 `CdRead` 43 — NOT a coloring residual any more
The 11D note retires the old base-anchor floor, and indeed the current residual is **block
LAYOUT**: retail lays the two error returns out as fall-through `j`+`sw v0,16(a0)` pairs off a
single materialized `&_cdr` anchor in `$a0`, ours materializes `$v1` twice and inverts the
arms (`li v0,585` vs `li v0,582` order, `jal`/`addu a0,zero,zero` swapped).  ours 102 /
oracle 103.  This wants the arm-order + shared-anchor treatment before any register dial — a
full re-lay, not a dial; out of this wave's remaining budget.

### 3.7 gcc RUNG LADDER — re-run and CLOSED for `cdread.c` and `drv.c`
`NFS4_FORCE_CC1_ALT` over 2.6.3 / 2.7.2 / 2.7.2-970404 / 2.8.0 / 2.8.1 / 2.91.66 / 2.95.2:

- **cdread.c** (DEFAULT lane, cc1 2.8.0 + maspsx): baseline 3/6 PASS, total 87.
  2.6.3 1/6 (152) · 2.7.2 1/6 (122) · 2.7.2-970404 1/6 (109) · 2.8.0 2/6 (87) ·
  2.8.1 2/6 (81) · 2.91.66 0/6 (241) · 2.95.2 0/6 (261).  **Every rung LOSES a PASS.**
  The 2.8.1 rung's 81 < 87 total but costs `_read_data_int`'s PASS ⇒ not wirable whole-TU.
  A per-fn version splice would need a **DEFAULT-lane `PER_FN_CC1_VER_SPLICE` twin**
  (`PER_FN_CC1_VER_SPLICE_272` only runs in the 272 lane) — the same wiring 11G already
  requests for MULDF3.
- **drv.c** (272 lane + `no_strength_reduce`): baseline 7/13.  2.6.3 6/13 (CD_ready 22→55) ·
  2.7.2-970404 / 2.8.0 / 2.8.1 all **0/13** and catastrophic (CD_get_intr 271, CD_cw 249+).
  The wired 2.7.2 rung wins outright.  (Confirms the W55-A5 ladder verdict in the current
  basin — 04Z re-ladder done AFTER this wave's structural landings.)

---

## 4. TOOLS / HAZARDS

- **`scratchpad/w60a4/vprobe.py`** — a scratchpad COPY of `tools/verify_asm.py` with two env
  hooks (`W60_TU_FLAGS`, `W60_FN_FLAGS`, both JSON) that patch `PER_TU_FLAGS` /
  `PER_FN_FLAG_SPLICE_272` **in memory** before compiling.  Lets an agent price a
  per-TU/per-fn flag without touching `tools/build.py`.  Needs
  `sys.path.insert(0, ROOT/'tools')` (the 272 lane imports `fix_symsizes`) and an absolute
  `ROOT`.  **Promotion candidate.**
- **`tools/tugate.py` fails with `AttributeError: module 'va' has no attribute '_name2addr'`
  when the TU does not COMPILE** — the real error is swallowed by its
  `except SystemExit: pass`.  When you see that traceback, run `verify_asm.py` directly to
  see the compiler diagnostics.  (Cost me one cycle; a 2-line fix in tugate would surface it.)
- **Mixed line endings inside one file** (`toc.c` = 53 lone LFs in a CRLF file,
  `streamhelp.c` = LF-only): all block moves were done with byte-level python
  (`open('wb')` + `os.replace`) so the regime is preserved.  Post-edit control-byte scan run
  on every touched file — clean.
- **Silent no-op replaces**: two probes reported "inert" because the `\r\n` pattern did not
  exist in an LF region of the file.  Every subsequent probe asserted `count(old)==1`
  BEFORE writing.  (This is the 9th-ish firing of the line-ending-hazard family.)
- Concurrent agents: only `recon/syslib/psx/libcd/*` touched; `iso9660.c` never opened for
  write.  No `git checkout`/`stash`/`reset`; every commit named explicit paths.
