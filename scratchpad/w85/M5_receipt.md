# W85-M5 receipt — the two open `DoLanguageScreen__Fv` regional rows

Agent **W85-M5**. Rows: board 57 (`UK-ES-IT`, was FAIL 50 @193/193) and board 58
(`UK-SW`, was FAIL 4 @182/182).
Gate (authoritative):
`python regiondiff/tools/verify_region.py <REGION> <cand> DoLanguageScreen__Fv --lane-as=recon/frontend/psx/psxfront.cpp`

## RESULT — BOTH ROWS SEALED

| row | region | before | after |
|---|---|---|---|
| 57 | UK-ES-IT | FAIL 50 (193/193) | **REGION-PASS (193 insns)** |
| 58 | UK-SW    | FAIL 4  (182/182) | **REGION-PASS (182 insns)** |

Final sweep (one run each, end of wave):
```
  DoLanguageScreen__Fv: REGION-PASS (193 insns) [NFS4-R-UK-ES-IT]
  DoLanguageScreen__Fv: REGION-PASS (182 insns) [NFS4-R-UK-SW]
  DoLanguageScreen__Fv: REGION-PASS (183 insns) [NFS4-R-FR-DE]   (untouched, re-confirmed)
  DoTitleScreen__Fv:              REGION-PASS (66 insns) [NFS4-R-AU]  (sibling psxfront rows, untouched)
  Init_RenderingEnvironment__Fv:  REGION-PASS (62 insns) [NFS4-R-AU]
```
Base tree re-checked untouched and green:
`python tools/verify_asm.py recon/frontend/psx/psxfront.cpp DoLanguageScreen__Fv,DoTitleScreen__Fv,Init_RenderingEnvironment__Fv`
-> `PASS (15) / PASS (64) / PASS (59)`.

With FR-DE already sealed, **all three regional `DoLanguageScreen` rows now
REGION-PASS.**

---

## Row 58 — UK-SW: the whole body replaced by a port of the SEALED FR-DE body

**Finding that made it trivial: the UK-SW and FR-DE oracles are the SAME body.**
Diffing the two oracle instruction streams (`scratchpad/w85/o_frde.txt` vs
`o_uksw.txt`) gives only:

```
-addiu s2,sp,16       (position: FR-DE before the STR_FRMT lui, UK-SW after the Paths lui)
-li v0,1 / sb v0,80(sp) / li v0,2      <- languages[] = {1,2}
+li v0,5 / sb zero,80(sp)              <- languages[] = {0,5}   (0 stores as `sb zero`)
```
Everything else — 182 vs 183 instructions — is identical. So the candidate was
rewritten as the FR-DE body verbatim with UK-SW's data (7 shape names,
`languages = {0,5}`, `"language.psh"`).

The three structural spellings that carried over and killed W84-R09's last 4
diffs (`addu a0,zero,zero; addu s1,a0,zero` placed 3 insns too late):

1. **Statement order `x = ...; VSync(0); i = 0; shapeOffset = 4;`** — cse's
   copy-propagation gives the shared zero to the FIRST-assigned pseudo, so the
   VSync argument must be assigned first; the position then follows because
   the draw loop below is a real loop, not a `goto` label loop.
2. **Real `for (; i < 2; i++)` draw loop** replacing the `goto
   language_draw_loop;` body — this is what let the `do{}while(0)` nest go.
   R09 measured FLATTENING that nest alone at 44-46 diffs and correctly called
   it load-bearing *for the goto-loop shape*; with the loop converted, the nest
   is not needed at all (it was holding a position the real loop holds for
   free). R09's "a real `for` is not viable" note was about converting the loop
   while KEEPING the goto tail — the full port has no goto.
3. **Both-arms-assign offset select** (`if (selected == i) sel = shapeOffset;
   else sel = (i+3)*4;`) plus the explicit `shapePtr` / `drawX` / `y` locals
   (methodology §5.0c #3).

### Angle (b) — the three mis-named callees: APPLIED and re-gated

W84-R04's opcode+register skeleton match (regional jal targets vs
`NFS4-B-USA.EXE`) reads the trio as `sprintf` / `systemtask` /
`FEInput_GetKeyFromPlayer`, and the trio is exactly the idiom `DoTitleScreen`
uses two functions earlier in the base TU. All three renames were applied to
the UK-SW candidate:

| was | now | notes |
|---|---|---|
| `creatememclass(&memclass, RegionalLanguageShapeMemory, RegionalLanguageShapeMemorySize, "language.psh")` | `sprintf(fullName, STR_FRMT[0], Paths_Paths[0x20], "language.psh")` | the 48-byte `struct LanguageMemClass` blob is `char fullName[48]`; `static char *STR_FRMT[2];` re-declared in this standalone TU as the base TU declares it |
| `setmemclass(0)` | `systemtask(0)` | `int systemtask(...)` in psxfront_externs.h, so the 1-arg and 0-arg call sites coexist |
| `GetPSXPadValue(p,-1)` | `FEInput_GetKeyFromPlayer(p,-1)` + the mangled `asm("...__F7tPlayerl")` label, as the UK-ES-IT candidate spells it | |

Re-gated after each step: **REGION-PASS (182) held throughout.** ⚠️ Documented
in-file: the ARRAY_REF spelling of the two middle arguments is codegen-relevant
in general (see row 57 below); it is inert here only because this TU's 7-name
initializer is unrolled at constant frame addresses, so there is no
varying-address block store for the load to be alias-chained behind.

Backups: `scratchpad/w85/M5_uksw_base4.cpp` (prior FAIL-4 state),
`M5_uksw_PASS2.cpp` (post-port, pre-rename), `M5_uksw_PASS.cpp` (final).

---

## Row 57 — UK-ES-IT: FAIL 50 -> PASS in three steps

Backups: `M5_esit_base50.cpp` (prior), `M5_esit_34.cpp` (mid), `M5_esit_PASS.cpp`
(final). Side-by-side dumps: `m5_esit_raw.txt` (before), `m5_esit_raw2.txt`
(mid). Read-only helpers written for this row (they re-`exec` the head of
`verify_region.py` and print instead of diffing; **no tool was modified**):
`scratchpad/w85/m5_side.py` (aligned) and `m5_raw.py` (raw index-paired).

### Step 1 (50 -> 34): port the FR-DE inner-loop spelling — clears TWO clusters

R04's cluster "~12 — the `selOffset` scratch: ours `a3`, oracle `v0`" and its
"~8 — two move-order/position pairs" both fell to one edit: the FR-DE draw-loop
spelling (statement order `x; VSync(0); i; shapeOffset`, real `for`,
both-arms-assign offset, explicit `shapePtr`/`drawX`/`y`, `x += 10 + width`).

What each fixed, read off the aligned dump:

* **Shared zero** — ours `addu s1,zero,zero; li s2,4; addu a0,s1,zero`,
  retail `addu a0,zero,zero; addu s1,a0,zero; li s2,4`. Moving `i = 0;` and
  `shapeOffset = 4;` BELOW `VSync(0)` flips the direction *and* keeps the slot.
  (Same root cause as the UK-SW residual; one fix, two rows.)
* **selOffset cluster** — the default+override form
  (`selOffset = shapeOffset; if (selected != i) selOffset = (i+4)*4;`)
  materialises the default into a scratch BEFORE centerOffset
  (`addu a3,s2,zero` at index 116) and pushes the centerOffset `subu` into the
  `beq` delay slot. Retail computes `subu v1,v1,v0` before the branch and puts
  `addu v0,s2,zero` IN the delay slot — the both-arms if/else shape
  (methodology §5.0c #3).
* `x += 10 + shapes[7]->width;` is fine here (R04 had measured the algebraic
  `x = x + 10 + w` at 194 insns / needing a `nop`); the sealed FR-DE row uses
  the same `+=` spelling.

Falsified at this step (measured, both 34 — inert): FR-DE's walking-pointer
locate loop (`i=0; shapeBase=shapes; for(;i<9;i++) *shapeBase++ = ...`) instead
of the index `do{...}while(i<9)`. Left as the index form.

### Step 2 (34 -> 34): `*(char **)STR_FRMT` — FALSIFIED, and why

The residual 34 was R04's cluster 1 (the `shapeNames[9]` block copy) plus its
downstream schedule. Reading the `-dg` dump (methodology §3.12b) named it
exactly:

```
;; 19 regs to allocate: 136 138 139 97 140 98 137 141 88 99 100 95 87 219 218 142 96 89 94
;; 87 conflicts: ... 2 4 16 29      <- dest_reg, conflicts v0/a0/s0/sp -> v1
;; 88 preferences: 2                <- src_reg  -> v0
;; 89 conflicts: 87 88 89 29        <- final_src -> a0
```
(`expand_block_move` in mips.c creates `dest_reg`, `src_reg`, then
`block_move_loop`'s `final_src`, in that order; 36 bytes = leftover 4, bytes 32,
so a 2-iteration 16-byte loop + a 4-byte tail.)
Retail: `dest=a2, src=v1, final=v0`.

The dump also showed the real driver: in OUR RTL the 4-byte leftover
`movstrsi` (insn 41) is a *dependency predecessor* of BOTH sprintf argument
loads — `(insn 77 ... (insn_list 41 (insn_list 68 ...)))` — so it must be
emitted before `lw a1`, which is what pins `dest` live across `a0 = s0` and
frees a0 for `final_src`. Retail emits `lui v0(STR_FRMT); lw a1,...` ABOVE the
leftover copy and `lw a2,...` BELOW it, i.e. retail has the dependence for
`Paths_Paths` but NOT for `STR_FRMT`.

`gcc-2.8.1/sched.c:830-856 true_dependence` explains it: the varying-address
struct store (`(mem/s:BLK (reg))`) is proved independent of a load only when
the LOAD is `! MEM_IN_STRUCT_P && ! rtx_addr_varies_p`. `canon_rtx` already
resolves the load's `lo_sum` base to its `REG_EQUIV` constant, so
`rtx_addr_varies_p` is 0 — the only blocker is `/s`, which `STR_FRMT[0]` has
because it is an ARRAY_REF.

`*(char **)STR_FRMT` did **not** clear it (still `mem/s:SI` in the dump):
expand_expr's INDIRECT_REF case sets `MEM_IN_STRUCT_P` when the address is an
`ADDR_EXPR` of an aggregate (or a `PLUS_EXPR`).

### Step 3 (34 -> 0): read the format pointer through a pointer LOCAL

```c
char **fmt = STR_FRMT;              /* MATCH: non-aggregate VAR_DECL */
...
sprintf(fullName, *fmt, Paths_Paths[0x20], "lang.psh");
```
`*fmt` is an INDIRECT_REF of a plain `char **` VAR_DECL -> `MEM_IN_STRUCT_P`
CLEAR -> `true_dependence` proves independence -> the `lui/lw a1` pair hoists
above the leftover copy -> `dest` now conflicts with a0 AND a1 (and dies before
`lw a2`, so a2 is free) -> `dest=a2`; `final_src` takes v0 (it dies at the loop
`bne`, before the STR_FRMT `lui` reuses v0); `src` takes v1. All 26 block-copy
diffs and the 8 downstream schedule diffs vanish together.

**-> REGION-PASS (193 insns).**

`Paths_Paths[0x20]` deliberately STAYS an ARRAY_REF: retail keeps its load
below the leftover copy, i.e. that alias edge is real in the oracle too. Both
constraints are commented loudly in the candidate (a future reader would
otherwise "simplify" `fmt` away and silently reintroduce the 34-diff miss).

---

## Reusable lever (new — for the catalog's §A / §14D alias-dial family)

**BLOCK-COPY CALLER-SAVED TRIO IS AN ALIAS-EDGE SYMPTOM, NOT AN ALLOCATOR
COIN-FLIP.** Symptom: a brace-initialized local array big enough for
`block_move_loop` (> 2*16 bytes) whose copy uses a different caller-saved
`dest/src/limit` trio than retail, PLUS the copy's 4-byte tail sitting at a
different point among the following argument loads. Diagnosis: the tail
`movstrsi` is `(mem/s:BLK (reg))` = varying + struct, so `true_dependence`
(sched.c:849) chains EVERY following `/s` load behind it; the chain is what
sets the copy pseudos' live ranges and hence global-alloc's assignment.
Fix: spell the loads retail hoists ABOVE the copy as NON-aggregate MEMs —
read a global array's element through a `T *p = arr;` pointer local and
dereference `*p` (an INDIRECT_REF of a non-aggregate VAR_DECL). ⚠️ `*(T*)arr`
and `&arr[0]`-style casts do NOT work (ADDR_EXPR-of-aggregate re-sets `/s`);
and only convert the loads retail actually hoists — the ones it keeps below
the copy must stay ARRAY_REFs.

## Compliance

* Files written: `regiondiff/recon/NFS4-R-UK-ES-IT/frontend/psx/psxfront.cpp`,
  `regiondiff/recon/NFS4-R-UK-SW/frontend/psx/psxfront.cpp`, and
  `scratchpad/w85/**` (this receipt, backups, dumps, two read-only helper
  scripts, `dump/` RTL dumps).
* NO git operations. NO edits to `tools/*.py`, `regiondiff/tools/*.py`,
  MANIFEST, REGION_PROGRESS, `.github/**`, the memory dir, or the base tree
  (`recon/**`, `src/**`, `asm/**`, `configs/**`).
  `update_region_progress.py` NOT run (per the wave guide).
* NO `volatile`, NO `__asm__` statements, NO `register ... asm("$N")` pins, NO
  post-compile instruction moves, no seals introduced. The only `asm(...)`
  used is a DECLARATION label (`asm("FEInput_GetKeyFromPlayer__F7tPlayerl")`)
  carrying the retail mangled symbol name — the same device the base TU and the
  UK-ES-IT candidate already use; it emits no instruction.
* Both edited candidates were left in their best (PASSing) state; no
  previously-PASSing function anywhere was left broken (base-tree and sibling
  regional rows re-gated above).
