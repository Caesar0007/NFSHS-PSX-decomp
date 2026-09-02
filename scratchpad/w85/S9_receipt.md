# W85-S9 receipt — recon/eaclib/psx/spchpsxz/{spchevnt,spchpick,spchrule,spchdata}.c

Wave: W85 device purity (clear `asm` / pins / fences / `&&label` / plain-state `volatile`).
Rules followed: no git, no `tools/*.py` edits, no post-compile moves, no new devices.
Gate: `python tools/verify_asm.py <file> <fn>` / `tools/tugate.py <file>` (whole-TU), plus
`tools/build.py --skip-asm` (whole recon tree) and `mipsel-none-elf-nm` on each object.

## Headline

| file | fns | gate BEFORE | gate AFTER | code devices BEFORE | AFTER |
|---|---|---|---|---|---|
| spchevnt.c | 16 | 16/16 PASS | **16/16 PASS** | 11 | **5** |
| spchpick.c | 27 | 27/27 PASS | **27/27 PASS** | 6 | **2** |
| spchrule.c |  9 | 9/9 PASS | **9/9 PASS** | 17 | **0** |
| spchdata.c |  8 | 8/8 PASS | **8/8 PASS** | 1 | **1** |
| **total**  | 60 | 60/60 | **60/60** | **35** | **8** |

Zero PASS lost. **27 of 35 device sites removed (77%).** Every `volatile` on plain state is gone
from spchrule and spchevnt; all 3 opacity fences in spchpick's `iSPCH_IterateChoice` are gone; the
2 `volatile` parameters in `iSPCH_ChooseSamples` are gone. No `&&label` V2 device existed in these
four files (spchinit.c carries the SPCH one; not in this assignment).

Sibling TUs re-gated unchanged: spchbank 8/8, spchinit 7/7, spchrand 4/4, spchrslv 1/1,
spchsamp 2/2. Whole-recon `build.py --skip-asm` clean.

---

## spchrule.c — 17 devices -> 0, 9/9 PASS

### D1. `iSPCH_GetRuleID` — 3 `volatile unsigned int` decode slots -> `unsigned int decode[3]`
Retail writes three never-read stack slots (0x10/0x14/0x18). A local **scratch ARRAY** is memory by
construction, so the dead stores survive DSE with no qualifier. **PASS 29/29.**
- FALSIFIED: plain (non-array, non-volatile) locals — the three stores vanish and the index chain
  re-colors (`addu v1,v0,zero` -> `addu a0,v0,zero`, `sll/addu` pair lost).
- Intermediate that also PASSed but was superseded by the array: plain locals + address-taken
  pointer slots (`unsigned int *idSlot = &id; *idSlot = ...`).

### D2. `iSPCH_RuleSet` — 3 volatile slots + 2 `*(volatile unsigned char *)(rd+1)` reads
Slots -> `decode[3]` (as D1). The two volatile READS existed because **retail loads `rd[1]` twice**
(0x8010B318 and 0x8010B328, both `0x1($s0)`). Replaced by the **INDEX FORM** `rd[i*2]` /
`rd[i*2+1]` (dropping the `rd += 2` walker): both loads survive AND keep retail's displacement.
**PASS 78/78.**
- FALSIFIED, plain `rd[1]` on the bumped pointer: **49 diffs / 81 insns** — loop.c strength-reduces
  `rd+1` into a second biv (`addiu s1,s4,1`) and the jump-table base falls into the loop.
- FALSIFIED, label+goto rewrite of the rule loop (catalog "goto-loop kills the giv anchor"):
  **51 diffs / 81 insns**.

### D3. `iSPCH_GetRuleSettings` — 4 volatile slots + 2 volatile reads -> `unsigned int decode[4]`
Retail's frame: 0x10/0x14/0x18 written (0x10 and 0x18 read back at 0x8010B4A8/AC), **0x1C reserved
and never written**, spills at 0x20/0x24. One 4-element array reproduces all of it, including the
slot ORDER. Reads -> index form off `ruleData` (the now-dead `p` walker deleted). **PASS 112/112.**
- FALSIFIED for the reads: plain `p[1]` = **132 diffs / 114 insns**.
- FALSIFIED for the unwritten 4th slot (with the reads already fixed): an addressable unused scalar
  (`unsigned int spare; unsigned int *spareSlot = &spare;`) = **10 diffs**, and an unused
  `unsigned int spare[1];` = **10 diffs** — neither gets a stack slot, so both reload spills land
  4 bytes low (28/32 ours vs 32/36 retail).
- FALSIFIED for slot ORDER: converting only `paramStore` to an address-taken scalar = **6 diffs**
  (its slot moves 0x14 -> 0x1C, because gcc assigns the slot where `&x` is *parsed*, not where the
  variable is declared — the array spelling is what pins the order).

### D4. 3 × `__asm__("<VA-suffixed symbol>")` labels on the static-helper declarations -> `#define`
`VoxSentence_GetNumPhrases` / `iSPCH_GetOffset8` / `iSPCH_GetOffset16` are per-TU statics that also
exist as spchdata exports, so the oracle namespace needs VA-suffixed spellings. Three `#define`s do
the rename with the preprocessor; the bodies still read with the retail names. Zero instructions
either way. `nm` confirms `t iSPCH_GetOffset16_8010B124` etc. **9/9 PASS.**
- FALSIFIED (why a rename is still required): dropping the labels entirely still shows 9/9 in
  `tugate` — but that is a FALSE pass. The object then exports the plain names, which match
  spchdata's oracles (identical bodies), and the three `_8010B1xx` oracles lose their symbol.

---

## spchevnt.c — 11 devices -> 5, 16/16 PASS

### D5. `iSPCH_InitEventQueue` — 4 `*(volatile short/int *)` header stores REMOVED
The qualifier only existed to stop loop.c anchoring the four queue-header stores on the inner
loop's giv (`addiu $a1,$a2,16` with -8/-6/-4/0 displacements). The honest fix is retail's own
shape, which the w32-a9 note already documented ("a label+goto double loop ... it never went
through loop.c"): the OUTER loop is now a **bare `outer: ... if (slot < end) goto outer;`** with no
`do`/`while` wrapper. **PASS 29/29.**
- FALSIFIED: plain (non-volatile) stores with the original `do{...}while(slot<end)` outer loop =
  **36 diffs / 31 insns** (the giv anchor returns).
- FALSIFIED: the goto-loop wrapped in `do{ ... }while(0)` (the catalog's ref-weighting recipe) =
  **36 diffs / 31 insns** — the wrapper still emits LOOP_BEG/LOOP_END notes, so loop.c re-forms
  the anchor. The wrapper must be absent here.

### D6. 2 × `extern ... __asm__("gVoxEvents")` view labels -> extra labels in the .bss block
`gVoxEventQueue` and `gVoxQueue` (the byte view and the typed `VoxSlot` view) are now plain
`.globl` + label lines inside the already-present file-scope `.bss` definition block, and their C
declarations are ordinary `extern T x[];`. Same address, zero instructions, no asm in the C decls.
`nm`: `0000001c B gVoxEvents / gVoxEventQueue / gVoxQueue`. **16/16 PASS.**
- ⚠ CAUGHT AND FIXED IN-WAVE: an intermediate state removed the decl labels **without** the .bss
  labels landing, leaving `U gVoxEventQueue` / `U gVoxQueue` in the object. `verify_asm`/`tugate`
  stayed 16/16 (they are reloc-name lenient) — this is exactly the *hidden phantom* class, and only
  the `nm` pass caught it. Any symbol-shape edit in this tree must be `nm`-audited, not gate-audited.

### D7 (KEEP). `iSPCH_InitEventQueue` — 2 opacity fences, RESTORED
`__asm__("" : : "r"(addr))` and `__asm__("" : "=r"(slot) : "0"(slot))` keep retail's two reg-reg
copies (`addu $a3,$v0,$zero`, `addu $a0,$a3,$zero`, 0x800E7020/24) alive. Without them cc1 fuses
`addr` with `slot`: **31 diffs at 28 insns vs retail's 29** (ours is one instruction SHORT).
FALSIFIED this wave, all at 28 insns / 31 diffs unless noted:
- `base` and/or `slot` from a 2nd/3rd textual evaluation of `(int)gVoxEvents` (3 combinations);
- `end` sourced from `addr`, from `base`, or from a 3rd evaluation;
- `*(int *)addr = 0` for the count store; the count store moved between the two copies;
- the `base+4` store hoisted above `slot = base` (**29 diffs**);
- depth-2 and depth-3 `do{}while(0)` ref inflators on either copy and on the `addr` definition;
- the two DISTINCT SYMBOL VIEWS for base/slot — **30 insns** (a second `lui/addiu` PAIR, i.e. +2,
  where retail needs +1 copy).
Mechanism unchanged from w47-a2: an address carries a `REG_EQUIV`, `update_equiv_regs` rewrites the
copy away, and there is no copy insn left for local-alloc's `combine_regs` to preserve. Discriminator
(a) of methodology §3.12 "ours-1-shorter" says this is permuter-multi-basin territory, not a floor —
left as the named next angle.

### D8 (KEEP). `SPCH_AddEvent` — 2 fences, RESTORED
`__asm__("" : : "r"(baseTmp))` (use fence, holds the `la` copy that `-fforce-addr` mints) and
`__asm__("" : "=r"(offTmp) : "0"(offTmp))` (keeps `off = offTmp` as retail's `addu $a1,$v0,$zero`
after the `slot*0x3c` chain). FALSIFIED this wave:
- drop the `off` fence only: **3 diffs / 81 insns** (ours `sll a1,v0,2`, retail `sll v0,v0,2` +
  `addu a1,v0,zero`);
- drop the `base` use fence only: **5 diffs / 81**;  drop both: **8 diffs / 80**;
- double evaluation `offTmp = slot*0x3c; off = slot*0x3c;`: 3; reversed order: 3;
- split multiply `offTmp = slot*15; off = offTmp*4;`: 3;
- `do{ off = offTmp; }while(0)` inflator: 3; arm-dup `off=offTmp; offTmp=off;`: 3;
- dead round-trip `off = slot*0x3c; offTmp = off; off = offTmp;`: 3.

### D9 (KEEP). the file-scope `.bss` DEFINITION block
Not a codegen device: it defines the four BSS objects of the 0x80148044 run with exact sizes,
order and the interior label `DAT_80148064`. C cannot express it — three of the four are <= `-G4`,
so a tentative definition lands them in `.sbss` as local symbols with gp-relative addressing, and
the oracle has zero `%gp_rel` sites for any of them (W65-A6 receipt). Byte-neutral.

---

## spchpick.c — 6 devices -> 2, 27/27 PASS

### D10. `iSPCH_ChooseSamples` — 2 `volatile int` PARAMETERS removed (inert)
`volatile int phraseTemplate, volatile int unused` -> plain `int`. **PASS 68/68 unchanged** — the
qualifier was doing nothing.
- FALSIFIED as a "replacement" (i.e. do NOT do this): the addressable spelling
  `int *ptSlot = &phraseTemplate;` used at the `iSPCH_MatchSample` call = **22 diffs / 72 insns**
  (it buys a frame pointer and the incoming home slots).
- `*&phraseTemplate` at the call site also PASSes but is pointless noise; plain is kept.

### D11. `iSPCH_IterateChoice` — 3 opacity fences -> one depth-2 `do{}while(0)`
The base qty needs >= 8 `REG_N_REFS` to beat the `n*6` mult chain for `$v0` (w47-a2's number).
The three `__asm__("" : "=r"(chBase) : "0"(chBase))` fences bought +2 refs each; the w49-a9 note
already recorded that a **nested `do{}while(0)` depth wrapper is an equivalent dial** but was barred
from that worker. It is not barred here. `do { do { chBase = (int)ispch_gChoice; } while (0); }
while (0);` — pure C, zero instructions. **PASS 44/44.**
- Measured basin: depth-2 **PASS**, depth-3 **PASS**, depth-1 **12 diffs**, no wrapper **12 diffs**
  — the same 6-to-8-ref step the fence basin showed.

### D12 (KEEP). `iSPCH_ConstantRuleSet` — `*(volatile unsigned short *)sentence`, RESTORED
This is the sched2 barrier that holds retail's issue order at 0x8010149C-0x801014B0
(`lui %hi(gSentenceRuleSet); lhu $a0,0($s6); lbu $a2,0x1C($v1); lw %lo(...); nop; jalr`). Without
it sched2 sinks the `lhu` into the `lw`'s load-delay shadow and retail's `nop` disappears.
FALSIFIED, all **3 diffs @ 82/83** unless noted:
- plain `*(unsigned short *)sentence`; `sentence[0]` with the cast; `(int)` cast without the
  `unsigned int`; a named `unsigned short` temp; a trailing `do{}while(0)` boundary; the read
  hoisted above `one = 1`;
- wrapping the read itself in a depth-1 or depth-2 `do{}while(0)`: **17 diffs @ 82/83** (rotates the
  callee-saved file instead);
- `callee = *setRule` moved above the shift: **9 @ 84/83**; dropping its phony loop: **14 @ 85/83**.

### D13 (KEEP). the file-scope `.bss` DEFINITION block — same class as D9 (W65-A6).

---

## spchdata.c — 1 device, KEPT (both non-asm alternatives falsified)

### D14 (KEEP). `__asm__(".globl X_<VA>\nX_<VA> = X")` co-equal alias block
Emits zero instructions; it exists because `VoxEvent_GetFilterLengthFlag` and `iSPCH_GetOffset16`
also exist as per-TU statics in spchevnt/spchrule, so the oracle namespace needs a VA-suffixed
spelling for spchdata's canonical exports.
- FALSIFIED: `__attribute__((alias("...")))`, both `extern` and plain forms — **ccpsx cc1
  (gcc-2.8.0) silently ignores it**: no diagnostic, the alias symbols are simply absent from the
  object (`nm`), and the gate drops **8/8 -> 6/6**.
- FALSIFIED: a `#define` rename (the spchrule fix) cannot serve — here the VA-suffixed name must be
  an ADDITIONAL symbol, not a rename, because spchpick.c calls both by their plain exported names.

---

## Method notes worth banking

1. **`unsigned int decode[N]` is the general replacement for a cluster of `volatile` dead-store
   decode slots.** A local array is memory by construction (store survives DSE), and — unlike an
   address-taken scalar — it fixes the *slot order*, because gcc assigns a scalar's stack slot at
   the point `&x` is parsed rather than at its declaration. An unwritten trailing element models a
   reserved-but-unused retail slot only if some element of the SAME array is used; a wholly unused
   array or an unused addressable scalar gets no slot at all.
2. **The INDEX FORM `p[i*k + d]` is the non-volatile way to keep a duplicated byte read on a
   walker.** It reproduces both loads with retail's `d($base)` displacement, where a bumped-pointer
   `p[d]` invites loop.c to strength-reduce `p+d` into a second induction register.
3. **A bare `label: ... goto label;` outer loop (NO `do{}while(0)` wrapper) is the non-volatile giv
   anchor kill.** The wrapper still emits LOOP_BEG/LOOP_END, so loop.c re-forms the anchor — the
   opposite of the catalog's ref-weighting recipe, which wants the wrapper. Decide per site.
4. **A depth-2 `do{}while(0)` is a 1:1 stand-in for a 3-fence ref-count dial** (`iSPCH_IterateChoice`,
   3 asm fences -> 1 wrapper).
5. **`__attribute__((alias))` is unavailable on this toolchain** (silently ignored by ccpsx
   gcc-2.8.0) — the file-scope `.globl`/equate asm is the only way to mint a co-equal symbol.
6. 🔴 **`verify_asm`/`tugate` cannot see a symbol-definition regression.** Removing an asm symbol
   label while its replacement fails to land leaves `U <sym>` in the object and the gate stays
   green. Every symbol-shape edit needs an `nm` pass on the produced `.o`.

## Files touched
- `recon/eaclib/psx/spchpsxz/spchevnt.c`, `spchpick.c`, `spchrule.c`, `spchdata.c`
- originals preserved at `scratchpad/w85/S9_bak/*.c.orig` (plus intermediate `se2/se3/sp0/sp1/sp2`
  snapshots and the throwaway probe drivers `S9_try*.py`, `S9_add*.py`, `S9_ieq.py`, `S9_pick.py`,
  `S9_iter.py`, `S9_crs*.py`).
