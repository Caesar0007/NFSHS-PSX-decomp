# NFS4-PSX Matching Decomp — Agent Working Guide

Self-contained onboarding for any agent joining the campaign. Read this fully,
then the three reference documents below, before touching a single function.

**Repo:** `C:\Temp\nfs4-decomp` · **Board:** 3075/3496 fns byte-matched (88.0%),
see `MATCH_PROGRESS.txt` (percentages go stale — never trust a row, re-gate).
**Goal:** byte-exact recompilation of NFS4 High Stakes PSX (`nfs4-f.exe`) from
reconstructed C/C++, function by function, with zero hand-asm pins.

---

## 1. MANDATORY READS (in this order, in full)

1. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_mips_isa_asm.md`
   — the MIPS-I/R3000 ISA + GAS reference (delay slots, %hi/%lo signed pair,
   signed-divide codegen, what is NOT on R3000).
2. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_psx_cpp_reconstruction_methodology.md`
   — the living methodology (seal criteria, source-authority hierarchy, §3.x
   technique library, §5 permuter discipline).
3. **THE LEVERS CATALOG** —
   `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_asm_pattern_catalog.md`
   — SYMPTOM-FIRST index: "I see THIS diff → try lever Y". The tail carries the
   newest law blocks (04U–04Z compiler-identity laws, 05A–05J, 06A–06F,
   07A–07F). **This is the single highest-leverage document in the project.**
   The memory dir is READ-ONLY for agents; report catalog candidates in your
   final report, the orchestrator harvests them.

---

## 2. THE GATE (sole authority)

```bash
python tools/verify_asm.py <recon-file> <SymbolName>
```

- Run from repo root. Gate **`recon/`** paths ONLY — the `src/**/*.c` stubs
  are `INCLUDE_ASM` scaffolding and gate VACUOUSLY (oracle vs itself).
- **Diff polarity: `-` = OURS, `+` = ORACLE.** (Misreading this has burned
  multiple agents.)
- Re-gate every baseline yourself before working a fn. `MATCH_PROGRESS.txt`
  and briefing numbers are stale in both directions, always.
- **Stale-object hazard:** if a *shared header* changed since the last build,
  the first gate may reuse a stale `.o`. Rebuild and gate twice before
  trusting a baseline.
- `verify_asm` is blind to intra-fn branch *targets* (normalized) and to
  unlinkable call targets (reloc-name leniency). For the latter run the
  **nm phantom check**: undefined symbols in your TU's `.o` that are not in
  `configs/symbol_addrs.txt` (especially `...__Fe` variadic manglings from
  `(...)`-typed extern decls) are real link bugs your gate will never show.

Per-diff source attribution: `python tools/diffsrc.py` (and see §4.1 SLD).

---

## 3. COMPILER IDENTITY MAP (settled laws — do not re-litigate)

| cluster | compiler | route |
|---|---|---|
| game/frontend C++ (`.cpp`) | CC1PLPSX (gcc 2.8.0) | maspsx + GNU as |
| eaclib (`.c`) | gcc 2.8.0 (proven bit-identical) | maspsx + GNU as |
| — exception: `eacpsxz/nsync.c` | gcc **2.8.1** | `cc1_ver` lane |
| syslib (most) | gcc **2.7.2** (PsyQ 4.0 CC1PSX ≡ FSF 2.7.2) | `cc1_272` lane: macro cc1 + direct GNU-as reorder, NO maspsx |
| syslib per-TU rungs | 2.6.3 / 2.7.2-970404 / 2.8.0 / 2.8.1 / 2.91.66 / 2.95.2 | `cc1_alt` lane (272 recipe, swapped binary) |
| `libgpu/SYS.c` | 2.8.1 + `-mno-split-addresses` (frame-size proven) | `cc1_alt` |
| libmath | Sony PREBUILT vendor object (no source ever existed) | per-TU rungs, all measured |

- Per-TU wiring lives in `tools/build.py` `PER_TU_FLAGS` — **orchestrator-owned;
  never edit `tools/*.py`**. Recommend wirings with whole-TU evidence.
- Ladder probe (dev box): `NFS4_FORCE_CC1_ALT=<ver> python tools/verify_asm.py …`
  Rungs live in `C:\Temp\windows-gcc-psx\gcc-<ver>-psx\cc1.exe`.
- **04Z LAW: rung tables are BASIN-RELATIVE.** Re-ladder after every structural
  landing; never wire a rung off a pre-lever table. (Confirmed 8+ times; after
  one wave 3 of 5 wired rungs were wrong.)
- The C++ lane has **no version axis** (no cc1plus ladder exists on disk).

---

## 4. PROVEN INSTRUMENTS (use in this order)

### 4.1 THE SLD — Law 05A: "the SLD IS the statement order"
The SYM's per-instruction source-line tags, grouped by line number, ARE
retail's statement list *and statement extent*. This sealed functions that had
resisted five waves of blind position search. Group the oracle's insns by SLD
line FIRST on every SYM-covered fn. Caveat: the SLD *identifies* the statement;
it does not always *enforce* it — pick the enforcement device afterwards.
Helpers exist in session scratchpads (`sldmap.py`, `sldview.py`, `w54a6_sld.py`
variants) — trivially re-derivable from `tools/diffsrc.py`.

#### SLD source coordinates — user authorization 2026-10-20

Use one per-function `#line N "C:/nfs4/.../FILE.CPP"` anchor with the exact
retail source identity. `N` applies to the following source line: when the
compiler records the opening brace as the function header, anchor the preceding
signature one line earlier. Derive both values from retail SYM, never guess.
Restore in-body SLD with ordinary statement placement, spacing and comments;
do not add executable placeholders. This supersedes earlier blanket advice
against line-coordinate anchors/padding for this explicitly authorized purpose.
Do not manufacture a full-source restoration claim from coordinate equality.

Re-gate each TU: normal and full-debug bytes/layout, all functions and branch
distances, native declaration owners and empty regions, and every SLD tag,
block line and function end. Check absolute header/end/filename coordinates
separately: the existing SLD comparator primarily checks header-relative tags.
Keep all previous PASS/EXACT seals; never change references or weaken comparison.
Do not insert per-statement `#line` overrides to conceal unresolved source
grouping or ownership. Original literal source text and missing/extra source
objects remain separate review obligations, even after every debug tag agrees.

Freshness warning (2026-10-20): not every symloop run regenerates the broad
`build/psyq_g/sldtree_report.json`. Check its inputs/timestamp before combining
it with current declaration results. Regenerate that derived comparison with
`tools/psyq_pipe/sldtree_cmp.py` against the current native dump and unchanged
retail dump; never refresh retail references to hide a difference. The source
review inventory does not certify whole-tree source freshness, and its legacy
EXTRA worklist can collapse duplicate local names. Use complete owner-aware
declaration tuples when counting source objects or claiming a local fix.

### 4.2 THE SYM 8c BLOCK — Law 06A: "the local list is the allocation budget"
Trusted SYM: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`.
Every fn's `8c Function start` block gives named locals + their `REG $N`/`AUTO`
homes + `fsize` + `mask`. A Ghidra-invented local the SYM does not list costs a
callee-saved register + frame bytes; the `mask` word alone tells you retail's
saved-reg count. Whole-fn "rule-8 rewrites" from the SYM local set have been
the single most productive instrument on game/frontend code (straight-to-PASS
from 100+ diffs, repeatedly). A `symblk.py` dumper (mangled name → 8c block)
exists in scratchpads; promote-worthy.

### 4.3 allocsim + reqdelta — the priced register dial
```bash
python tools/allocsim.py …    # replicate global_alloc's handout from .greg
python tools/reqdelta.py --want "p<NN>=<reg>" …
```
**The recipe (proven transferable, both lanes):**
1. `allocsim` must report an exact MATCH for the fn — that validates the model.
2. `reqdelta --want <retail handout>` prices the minimal dial (refs N→M or
   live N→M across a `floor_log2` step).
3. Buy refs with a read-only fence `__asm__("" : : "r"(x)[, "r"(x)])` placed
   **after the value's last real use** (before it costs a nop). Each operand =
   +1 ref ×loop_depth (out-of-loop +1, in-loop +2). An under-dialed fence
   is NOT inert — it regresses exactly as the model predicts.
**Limits:** both tools model *global* allocnos only. Local-alloc QTY handouts
and sched1-driven liveness are outside the model (see §4.6).

### 4.4 The fence toolkit (catalog 06B/07B — read the full rows)
Zero-insn devices, all pin-free:
- **read-only fence** `("" : : "r"(x))` = +refs (DEMOTE others / promote x);
- **identity fence** `("" : "=r"(x) : "0"(x))` = cse-opaque launder / PROMOTE;
- **void-tail fence** `("" : : "i"(0))` = scheduling barrier (implicitly
  volatile), the standard cure for "sched2 hoisted my store into a load slot";
- **volatile-on-the-TEST-read** = forces a fresh re-read AND shortens live
  range (cse never records a volatile MEM);
- **parm-spill pin** = void fence BEFORE the first statement keeps
  assign_parms' stores in the prologue group.
**Placement is a separate dial from choice** (same fence: decl = +3 diffs,
before-consumer = PASS). **Flavour matters** (`__volatile__` = barrier, plain =
schedulable — A/B both). **Boundary:** any asm stops reorg's backward
delay-slot scan — a top-of-fn fence and a prologue-store slot fill are
mutually exclusive. A mechanical fence-position sweeper exists
(`w55a9_fencesweep.py` in scratchpad) — one run replaces days of hand probing.

**THE COMPLETE `__asm__` POLICY** (what is allowed vs banned):

| use | verdict |
|---|---|
| zero-insn fences above (empty template, no reg names) | ✅ standard instruments |
| GTE/COP2 compute ops (`mtc2/.word 0x4A…/mfc2`) | ✅ the only faithful form — see methodology §3.4 + the gte_* macro reference |
| PROVEN hand-asm fns (trapping opcodes / oracle-proven non-compiler: BIOS thunks, crt0, DecDCTvlc, _patch_gte, RotMatrix…) | ✅ file-scope `__asm__` transcription IS the reconstruction |
| EA expander-template sites (§3.25 fixed-`$t4-$t7` census positive) | ✅ the documented inline-asm template recipe, never C spellings |
| non-builtin alias (`extern void *_memcpy() __asm__("memcpy")`) | ✅ established device (defeats builtin inlining / symbol aliasing) |
| `register T x asm("$N")` PINS | ❌ BANNED — the project is pin-free; fence dials replace every pin (incl. those in Rage Racer sources you port) |
| hard-register CLOBBER fences (`__asm__("" : : : "$4")`) | ⛔ pin-adjacent — needs explicit USER sign-off (one such case is parked on that decision) |
| `asm` with a non-empty template to "help" codegen of a normal fn | ❌ that is hand-asm smuggling; find the source shape or file the named angle |

### 4.5 build.py per-fn mechanisms (orchestrator wires; you SPEC)
`PER_FN_NO_DELAYED_BRANCH` (dual-compile splice), `PER_FN_FORCE_ADDR`,
`PER_FN_NO_THREAD_JUMPS`, `PER_FN_RA_SINK`, `PER_FN_PROLOGUE_UNSINK`,
`PER_FN_EPILOGUE_UNFILL` (+ `_272`, + `_ALT28`), `PER_FN_FLAG_SPLICE_272`
(per-fn extra cc1 flag), `PER_FN_CC1_VER_SPLICE_272` (per-fn cc1 binary),
and `PER_FN_CC1_VER_SPLICE` (per-fn cc1 binary).  Authentic syslib per-object
compiler-version identities are allowed and remain active in the source-only
gate.  `PER_FN_TEXT_MOVES` and equivalent post-cc1 instruction relocation or
rewrite mechanisms are FORBIDDEN: a pure line-order residual must be solved by
source shape or by identifying the authentic compiler/object identity.  The CI
source-policy audit requires the compatibility table to remain empty.

### 4.6 qtytrace — THE MISSING INSTRUMENT (to be built; highest leverage)
The **06E gap**: gcc-2.8's `local-alloc.c` QTY handouts and sched1-driven
liveness windows are invisible to allocsim/reqdelta. This single gap now
blocks 10+ near-miss fns across five independent scopes (drv.c's 8×3 residual
— sched1 hoists a format-string set so $a0 is live across the chain qtys;
Weather_DoWeather; R3DCar MenuII; the non-propagated reg-reg copy class ×4;
SubmitRequest's copy-preference override). **Plan:** instrument a cc1 build
(print `qty_birth/qty_death`, `reg_qty`, `qty_phys_reg` + `QTY_CMP_PRI` inputs,
and sched1 ready-list picks) → `tools/qtytrace.py` renders the handout and
answers "which source change moves value V to register R at the QTY layer".
Until it exists, DE-PRIORITIZE residuals classified as local-alloc swaps —
they are receipted, not floors, and spelling sweeps there are wasted budget.

### 4.7 Reference corpora (the triangle + twin)
- **Canonical PsyQ 4.3 documentation** `C:\Temp\PSYQ\psyq-430-doc` — primary
  semantic authority for SDK API names, signatures, structures, macros, and
  intended use.  Start with `Devrefs\Libref.pdf` for library APIs and
  `Devrefs\Inlinref.pdf` for GTE/DMPSX inline names, macro composition, and
  pipeline rules.  Documentation establishes source semantics; extracted
  objects and the retail oracle remain the byte/codegen authority.
- **Canonical PsyQ 4.3 kit** `C:\Temp\nfs4-clean\psyq43` — headers and tools;
  use `COFF\INCLUDE\INLINE_C.H` to settle exact GTE macro spellings.
- **Rage Racer** `C:\Temp\rage-racer-decomp` — 100% byte-exact PSX corpus.
  `src/main/PAL/lib/libcd`, `libgpu` = matched Sony-lib C (the proven lever
  goldmine: port the SHAPES, drop their register-asm pins — we are pin-free).
  Block ORDER does not always transfer; inner idioms do.
- **psyz** `C:\Temp\psyz\decomp\src` — matched PSY-Q 4.0 C under gcc 2.7.2
  (libgpu/sys.c near-complete; libcd partial; libmath stubbed).
- **windows-gcc-psx** `C:\Temp\windows-gcc-psx` — the compiler ladder itself.
- **PC twin** `C:\Temp\nfs4-clean\nfs4-pc.c` + map
  `C:\Temp\nfs4-clean\pcmap\CONSOLIDATED.txt` — floatized logic oracle for
  mapped game/common fns (branch structure and constants only, never codegen).

---

### 4.8 RE2 GCC/GDB observers (user-authorized helper, 2026-10-20)

Reference tools live in `C:/Temp/re2-clean/tools/gcc_gdb_probe.py`,
`build_gcc_debug_host.ps1`, and `gcc970404_gdb_probe.py`. Reuse their read-only
breakpoint/phase-snapshot method, not RE2's compiler identity or build flags.
NFS4's stock CC1PLPSX lacks debugger symbols; an alternate symbol-bearing GCC
is diagnostic only. Keep its executable, rebuilt debug objects and outputs in
an isolated ignored build directory, preserving all shared source/build tools.
Require observed/unobserved output equality, record the exact executable and
input hashes, and independently confirm relevant findings on the selected
stock compiler (its RTL dump flags are useful). A near compiler's trace is not
a native byte/SYM acceptance certificate. Never assign compiler state/RTL in
GDB or rewrite generated instructions/debug records.

Example receipt: `build/nc12/aispeeds_layout_20261020/gdb-host/report.json`.
It identifies traffic RNG source-line transfer in combine, not the scheduler;
stock RTL independently confirms it. The alternate compiler uses a different
address pseudo, explicitly recorded rather than silently declared identical.
The follow-up source repair computes the complete two-bit index before its
lookup, instead of capturing a word still masked at use. This seals29/29
AISPEEDS absolute SLD contracts with unchanged code. The selected immutable
index's spelling/type/qualification remain explicit source-review items;
do not generalize this into a rule to add const aliases merely to hide rows.
Final receipt: `build/nc12/aispeeds_rng_index_20261020/final-proof.json`.

AISCRIPT follow-up: the alternate host can fail outside GDB. Preserve that
failure and do not call its standalone observer check validated. A separate
GDB-only control/probe comparison, with both raw target bodies independently
equal to selected stock CC1PLPSX, bounds the diagnostic observation; it does
not replace stock source/native acceptance. Receipt:
`build/nc12/aiscript_table_source_20261020/gdb-only-proof.json`.
That investigation exposed a first-scheduling/constant-availability interaction.
Removing a table alias or literal carriers individually failed, but removing
all four together preserved the complete normal ELF and native CPE. The
one-iteration do then became removable too. Real bounds/flag/test stages and
ordinary layout seal8/8 AISCRIPT function contracts. Do not turn earlier
single-carrier failures into exemptions, or manufacture replacement objects.

Frame-observation follow-up (2026-10-21):
`build/nc12/audiocmn_partial_source_20261021/texture-frame/frame-observer-proof.json`
adds an isolated DWARF `function.c` object to the diagnostic host. Its read-only
`assign_stack_local` observer records mode/size/alignment, before/after frame
offsets and caller frames. Texture_Vramf's explicit deadfrm allocation is16bytes
from expand_decl; a separate4-byte alter_reg/reload spill is a diagnostic-host
effect. The host emits109words versus selected stock107. Both standalone
controls fail with ICE/exit33, while debugger control/probe output agrees.
Record those failures and do not treat this as standalone or stock-equivalent
validation. Selected-stock isolated/full-TU target equality is checked separately.
Canonical shapetbl member records are exact; the tested narrowing casts do not
recover the missing source frame producer. No padding/type/output workaround
is adopted. Use this observer to locate allocation origins, not to infer that
an absent retail object must exist or that the artificial frame is a floor.

R3DCAR owner-preservation receipt (2026-10-21):
`build/nc12/r3dcar_carriers_20261021/final-proof.json`. A direct lower-clamp
conditional removes limit with unchanged whole ELF/native CPE, every prior
correct owner tuple and all region boundaries. A mask/shift bit argument removes
lightOff byte-identically but loses supplied empty regions and disrupts nine
correct owner tuples; it is NOT adopted. The natural high-half field shift was
initially rejected by region count, but the case-scope follow-up below proves
those four removed regions non-retail and adopts it. Inspect complete ordered
owner paths and empty regions after each source removal, not just names/homes
or normal bytes. A formerly dirty function can still contain correct evidence
that must not be discarded. Its partial line map remains explicitly open.

R3DCAR matrix follow-up (2026-10-21):
`build/nc12/r3dcar_matrix_source_20261021/final-proof.json`. Real nested
matrix-work and visible-object ownership restores nine more complete local
tuples (25->34/43), while all43 supplied names/types/homes/depths/starts/paths
agree. Only nine case endpoints remain different. Five one-iteration priority
loops, fourteen gotos and two matrix labels are removed with unchanged whole
ELF/native CPE. An ordinary if/else plus duplicate real default call merges to
the retail tail; the switch supplies its own redundant outer range test.
Both flat and scoped loop-removal controls pass: attribute the owner repair to
the real scopes, not an unsupported claim that they alone unlocked the loops.
All prior correct owner/region tuples survive; exact region tuples27->40.
This is partial source restoration, not a complete target SLD/text certificate.

R3DCAR case endpoint/correction receipt (2026-10-21):
`build/nc12/r3dcar_case_scopes_20261021/final-proof.json` and
`scheduler-notes-proof.json`. Put switch-level break AFTER the case's local
declaration block. Stock RTL shows the end note before the branch instead of
after its barrier; first scheduling prepends it to the relevant basic block
(sched.c unlink_notes/note_list). This restores all nine remaining endpoints,
making43/43 supplied complete local tuples exact with unchanged code.
An identity audit also shows positionStep's four regions are unexpected, not
supplied; canonical z>>16 removes that carrier/raw halfword view safely. All43
remaining native region tuples match retail; eight retail regions are missing.
Compare complete paths/ranges, not cardinality: the earlier count-only rejection
was wrong. Keep lightOff's genuine regions and all correct prior evidence.
Four EXTRA objects and full line attribution remain open; do not call this a
complete function source/SYM seal or insert padding to manufacture missing scopes.

R3DCAR Boolean/source-funnel follow-up (2026-10-21):
`build/nc12/r3dcar_remaining_source_20261021/final-proof.json` and
`boolean-origin-proof.json`. Ordinary if/else1/0 cop_flag assignment removes
copIndex: stock .rtl gives an anonymous condition reg, allocated v0, whereas
direct assignment makes the subtraction use the cop_flag/s6 user-variable
pseudo. Same comparison, different source construct; the temporary machine
quantity is not proof of a distinct source object. An inverted outer guard in
the second visibility loop keeps its brake arm out of line and removes that
lightFlags plus three gotos/labels. All43 supplied tuples and all43 native region
tuples remain exact/unchanged; only lightOff and the first lightFlags remain
EXTRA (the earlier four-object checkpoint is superseded). Eight retail regions
and full line attribution remain open. Legacy EXTRA counts collapse repeated
local names: use full owner tuples, not issue-row deltas, to count removals.

CARS scope follow-up (2026-10-21):
`build/nc12/cars_tire_scopes_20261021/final-proof.json`. Combining each real
splash short-circuit guard and removing each redundant leaf-effect declaration
brace pair restores20 complete local owner tuples. All43 supplied tire-effect
local tuples and37 region tuples now equal retail; twelve unexpected regions
disappear, with whole normal ELF/native CPE unchanged. Do not move same-name
vectors to root scope or infer ownership from register/stack home alone.
All33 CARS function headers/filenames also have retail-derived per-function
anchors;14 prior relative seals now have absolute word/file/block/end proofs.
Their relative seal count did not increase. Existing visibility/skid one-shot
loops and full tire-effect statement-line/macro spelling remain unresolved:
direct/ordinary-if/joint controls fail and are not adopted. No new fence,
qualifier, fake use or artificial region is introduced.

CARS post-collision follow-up (2026-10-21):
`build/nc12/cars_postcollision_source_20261021/final-proof.json`.
Height-before-bodyRoll-copy order removes absRoll and rideOffsetVal jointly.
Repricing direct division and the bound-first upper-clamp conditional on that
basin then removes roundedGV and clampCond. Earlier isolated failures did not
prove original objects. Structured short-path return also removes two gotos.
All154 words, whole ELF/native CPE, real locals/owners and all region tuples
are preserved. CARS now33/33 declaration-owner PASS. Ordinary anchored source
layout restores all target block/end lines and reduces word-tag differences
149->7, NOT zero. The value-producing height block has actual recorded work,
not a dummy scope; original macro/expression spelling remains review work.
Selected-stock stock-line-proof.json shows outer1720 before inner1717/18/19
in initial RTL, with no subsequent1720 restore. Investigate frontend location
handling before blaming assembler scheduling; preserve all seven residuals
and do not rewrite generated debug records. Real-variable/field staging and
clamp-only value-block controls fail and are not retained.

BWORLD RNG follow-up (2026-10-21):
`build/nc12/bworld_rng_source_20261021/final-proof.json`. Bound-first maximum
`rand() * (2 > numLaps ? 2 : numLaps) /32768` removes sceneStartRandom with
whole normal ELF/native CPE unchanged. Nine ordinary factor/staging/call/divisor
controls calibrate against stock; the other spellings fail. Do not generalize
the earlier value-first181/187 failure into a source-object requirement.
PsyQ4.3 RAND_MAX32767 bounds the multiplication-by2 equivalence; all32768
outputs are checked and the n>=2 product remains the same. AudioScene and all
prior correct owner/region tuples survive.21 source anchors add six absolute
certificates for already-relative-exact functions, not six new relative seals.
The initializer's full SLD/original macro spelling and Onyx's carrier/fence
remain open; the broader board is not a whole-source completion certificate.

BWORLD initializer SLD seal (2026-10-21):
`build/nc12/bworld_init_sld_20261021/final-proof.json`. After the real RNG
carrier is removed, ordinary anchored layout seals every187 instruction tag,
absolute filename/header, block line and function end, with unchanged tokens,
literals, whole ELF/native CPE and supplied owner tuples. Nested Time/Weather
conditions really share1338; the actual return is1379, not1378. The common
track-loader call inherits the final source arm1345 after GCC tail merging.
Do not replace this with per-statement directives, new scopes/objects, fake
uses or generated-note changes. Blank gaps restore known source coordinates,
not unknown original comments. This is one new strict/absolute function
contract; literal macro text and the rest of the module/project remain open.

BWORLD fog fence/type-preservation follow-up (2026-10-21):
`build/nc12/bworld_fog_source_20261021/final-proof.json`. Actual INT-to-u_short
field value casts remove the old empty assembly fence at193/193, with whole
ELF/native CPE and every prior owner/region/type-tag multiset unchanged. Pointer-
free versions ALSO pass code/locals, but lose seven supplied typedef copies;
they are NOT adopted. type-regression-proof.json records the exact loss and
unchanged negative-control CPE. Keep the unresolved real-type producer visible,
not as a source-object exemption, and do not insert dummy typedefs/objects or
weaken the type guard. The accepted result retains trackSpec while removing
the fence and two byte-punning reads; no original-object removal is claimed.
BWORLD has20/21 owner and21/21 region PASS, not a whole-source seal. Source
cast/load shape can make a formerly required fence unnecessary, but metadata
must be checked beyond the newly clean function-local report.

Shared track-type producer correction (2026-10-21):
`build/nc12/bworld_typedef_source_20261021/checkpoint-proof.json` supersedes
the fog round's retained-pointer workaround. Seven shared plain structs lacked
their retained completed-type typedef declarations. Forward-only aliases do
not emit the missing copies; `typedef struct Name { members } Name;` does.
The same deficit across11 consumer TUs establishes the shared producer:70
missing retail record copies are recovered, all77 full named type bodies/
tag/typedef contracts agree, every prior correct type record survives and two
unprovided duplicates disappear. No member/layout/storage change is involved.
Onyx can then lose trackSpec at193/193 with every supplied local/scope/type
preserved. Do not infer a distinct source object merely because its use emits
otherwise missing type records; investigate the common header/type producer.
Both full build routes and489 detailed/branch gates pass; all21 normal ELFs/
native CPE and prior145 strict/109 absolute contracts survive.145 includes24
existing seals in newly checked units, not24 new source restorations. Onyx's
full SLD/literal text and the rest of the main goal remain open.

BWORLD Onyx absolute SLD follow-up (2026-10-21):
`build/nc12/bworld_onyx_sld_20261021/final-proof.json` supersedes the preceding
Onyx line-map backlog, not its original-literal-text uncertainty. One function
anchor905/brace906 and ordinary layout restore193/193 line/file tags, all20
block records and end1055. The spike loop has initial condition987 and real
increment/backedge991. A while inside the existing counter-owned work region
recovers those distinct tags; the old for header left four on987 even after
moving its increment. No new object or fake region is involved. Positive line
guard removes NO_LINES/goto; nested custom guards recover their separate lines.
All11 supplied local tuples, all489 selected local/region/frame tuples, other488
complete SLD maps, global type records and seven shared headers are preserved.
Fresh run-5qrekzpl,489 detailed/branch PASS, all21 whole normal ELFs/native CPE
unchanged; all prior145strict/109absolute survive, now146/110. Tests105,
vtable1366, policy/relink/canonical/raw299819/299819/overlap/foreign checks pass.
No per-statement #line, asm, volatile, fake use, new name or output rewrite.
GAME/COMMON broad strict418/1247 and BWORLD8/21 are partial-project snapshots,
not literal-original-source or whole-tree completion certificates.

## 5. HARD RULES

Data-loader count/source/SLD receipt (2026-10-22):
`build/nc12/r3dcar_data_loaders_sld_20261021/final-proof.json` and phase-proof.json.
Keep original ScaneData/base pointer roles and names. Real env for init901
seals46. Track count=selected index+1, while(i--!=0) consumes actual inclusive
rows, sealing58; no dummy identity/name is added. Stock initial RTL lowers
entry jump932 to bottom consumption; jump optimization clones test at932,
CSE folds count/consumption, combine retains final addition's932. All code
unchanged. Fused-for four-tag regression was reverted. Risk parser is SYM
FCN INT, not M2C's caller-inferred s8. All104 tags/four blocks/eight locals
match, all489 gates/21 ELFs/CPE and prior167strict/133absolute survive;
now169/135. No extra object, qualifier, scope/use, device, flag or output rewrite.
Literal loop syntax and the wider source-restoration goal remain unproved.

Car-list VLA/source/SLD receipt (2026-10-21):
`build/nc12/r3dcar_list_sld_20261021/final-proof.json` and phase-proof.json.
Preserve two distinct runtime sort arrays, FP30/frame64, all shadowing local
owners and implicit void fallthrough. M2C collapses the VLA stack addresses;
do NOT unify buffers or add a return/cleanup region. ClockLast3430 before
Clock3431 restores source order; first scheduling reverses stores with tags
retained. Stock RTL has two initial dynamic-stack subtractions; later counts
also include the fixed prologue. Raw SetSp reads only a0, not M2C's stale
matrix constant in a1. All301 tags/34 blocks/14 locals match, all489 code/
branch gates/21 ELFs/CPE and prior166strict/132absolute survive; now167/133.
No new object, qualifier, scope/use, device, flag or output rewrite. Literal
macro text and the wider original-source restoration remain unproved/open.

MenuFacetII brightness/empty-transfer/source receipt (2026-10-21):
`build/nc12/r3dcar_menu_facet2_sld_20261021/final-proof.json` and phase-proof.json.
Remove the invented label/two jumps into no-op arms; no supplied region is lost.
Actual two-arm lightAvg assignment tags half3290/copy3291 while leaving the
INT input parameter unchanged. Stock first scheduling hoists copy3291 toward
the prologue; it was not proof of entry-time source initialization. Ordinary
real guard grouping/layout seals266 tags,26 blocks,18 locals and end3395.
Preserve SYM INT locals, not M2C's narrowed flag temps. All489 code/branch
gates,21 ELFs/CPE and prior165strict/131absolute survive, now166/132. No new
object, qualifier, fake scope/use, device, flag or output rewrite. Original
literal syntax and the full source-restoration goal remain open.

FacetII light-role/guard/source receipt (2026-10-21):
`build/nc12/r3dcar_facet2_source_20261021/final-proof.json` and phase-proof.json.
Ordinary wet-road guards remove the invented label/two gotos. Isolated later
light reuse fails; coupling real callback-to-field/mask phases with the actual
later RGB read into provided light preserves the entire ELF. REG:$2 alone
never proved that light belonged to the earlier callback quantity. Stock RTL
has two early field writes, combine reduces them to one, and the real later
read is3135. Dump .s equals native compile. No hidden temp, cast disguise,
qualifier or fence is needed. Actual source/guard layout seals379 tags,24 blocks,
25 locals and end3270. All489 code/branch gates,21 ELFs/CPE and prior164strict/
130absolute survive; now165/131. Native-clean ownership is not unique original
text: retire the earlier phase-role claim, preserve full wider-goal review.

Visibility ordinary-return/source/SLD receipt (2026-10-21):
`build/nc12/r3dcar_visibility_sld_20261021/final-proof.json` and phase-proof.json.
Six return controls and16 guard/order combinations preserve the whole ELF;
remove the invented rejection label and two gotos, not rename them. True
car/flag1423 and inCar/mode1425/1431 groups plus zoom/zero and corner-store
source ordering restore all234 tags, four blocks,12 supplied locals and
end1511. Stock RTL shows nine real detail stores through sched2, five after
jump2/delay fill: ordinary returns recover the shared tail without a device.
The real x/z work region optimizes to+720..+720; don't fabricate an empty
block from that address. All489 code/branch gates,21 ELFs/CPE and prior163
strict/129absolute survive, now164/130. No new object/qualifier/asm, fake use,
scope, flag or output rewrite. Native CLEAN/SLD equality does not establish
literal original text or complete the wider source-restoration goal.

Geometry loader source/SLD receipt (2026-10-21):
`build/nc12/r3dcar_geometry_sld_20261021/final-proof.json` and phase-proof.json.
ReadInCarData322 restores late offset648 WITH actual for(i=0)650 and real
vt.vz sum814/shift815. Offset alone fails; paired initialization and vector
phases preserve the whole ELF/CPE. All322 tags,18 blocks and20 supplied local
tuples match. Stock initial RTL through combine keeps offset after locatebig;
first scheduling hoists it before the call, retaining source648. Dump .s is
byte-identical to native compile. Do not sort source by execution order or
invent an early carrier/fence. Canonical LIBGTE.H confirms two VectorNormalS
arguments; M2C's extra geometry temps are not parameters or original locals.
All489 code/branch gates and prior162strict/128absolute survive, now163/129.
No new object, qualifier, scope, device, flag or output rewrite; literal macro
syntax and the wider source-restoration goal remain open.

Palette/menu cleanup source-order receipt (2026-10-21):
`build/nc12/r3dcar_palette_sld_20261021/final-proof.json` and phase-proof.json.
ChangeTrafficColor58 is whitespace-only. Menu cleanup80 restores actual source
newCarType1085 BEFORE currentCarType1086, while retaining the binary's opposite
store order. Stock initial RTL/combine preserve source order; first scheduling
reverses it. Dump-flag .s equals native compile exactly; no output rewrite.
Async condition1089/opening brace1090 independently supply instruction/owner
notes; same for success1100/open1101. All14 block records/tags/locals match.
Do not manufacture backwards statement anchors or a new scope. All489 code/
branch gates,21 ELFs/CPE and prior160strict/126absolute survive, now162/128.
M2C's second purgememadr argument is stale a1, not a real parameter. No new
object, qualifier, device or flag; literal source text/full goal remain open.

Renderer startup-group SLD seals (2026-10-21):
`build/nc12/r3dcar_startup_sld_20261021/final-proof.json`. Whitespace-only
layout under existing anchors seals StartUp52, PostStartUp57, Restart30 and
CleanUp90:229 words,183 tag differences removed. Complete local/region/frame/
type facts and other485 SLD maps survive; all489 code/branch gates,21 ELFs/CPE
and prior156strict/122absolute survive, now160/126. Preserve real loop/guard
source phases rather than arranging statements by execution order. StartUp's
real name-array region optimizes to+108/450; don't fabricate an empty scope.
M2C's fourth reservememadr argument is stale a3=-1 from loop setup; raw fresh
arguments and the three-parameter allocator settle arity. No new object,
scope, device, qualifier, compiler flag or output rewrite. Literal original
macro/comment text and the wider goal remain unproved/open, not exempted.

Menu texture full SLD follow-up (2026-10-21):
`build/nc12/r3dcar_menu_sld_20261021/final-proof.json`. After the real array/
cursor correction, whitespace-only layout under the existing anchor seals all
211 word/file tags, eight block records, twelve local tuples and end2342.
Outer condition2222 and opening brace2223 independently supply instruction
and owner coordinates. The real locate loop shares2263; first read/post-call
increment2288, optional2291 and final2295 preserve correct source phases.
U-offset stores inherit later conditional-slot tags, not their textual lines.
Keep token/literal identity, not per-statement anchors or manufactured work.
All489 code/branch gates,21 ELFs/CPE and prior155strict/121absolute survive;
now156/122. No original macro/comment text claim follows from tag equality.
The wider module's three dirty functions and full project obligations remain.

Menu texture array/cursor source correction (2026-10-21):
`build/nc12/r3dcar_menu_array_source_20261021/final-proof.json`. Restore actual
shpfiles[index] and keep carType a car type, removing its integer-address reuse.
Initialize the cursor before the first read but increment AFTER the call;
argument postincrement was near, with the wrong argument/slot timing. Six
ordinary after-increment controls preserve the whole ELF;56 other controls
fail. Slots remain[0,1] or[0,1,2]. All211 words, complete locals/regions/frame,
489 code/branch gates,21 ELFs/CPE and155strict/121absolute seals survive.
No source object/count removal is claimed: this fixes a value role/pointer pun.
SLD remains190/211different, end2274vs2342. Shared hard-register reuse does not
prove an original source-variable reuse. No new object/qualifier/asm, fake use,
scope, compiler flag or output rewrite; literal original spelling remains open.

Headlights/loader SLD follow-up (2026-10-21):
`build/nc12/r3dcar_lights_sld_20261021/final-proof.json`. Whitespace-only source
seals HeadLightOn24 and Off21, now155strict/121absolute, with489 code/branch
PASS, all21 ELFs/CPE and complete prior local/scope/type contracts unchanged.
LoadFileAdr improves15->2tag differences, NOT exact. Stock initial RTL already
tags filesize/reserve both1138 (retail1137/1138); -dr output is byte-identical
to native compile .s. The real inner value-block control preserves code but
adds a non-retail region and five wrong tags; reverted, not a source remedy.
Do not add a size dummy or statement anchor to conceal that producer question.
M2C drops filesize's real incoming name argument; raw a0 is forwarded, so keep
the correct one-arg source. No new device, object, qualifier or output rewrite.

Three small renderer SLD seals (2026-10-21):
`build/nc12/r3dcar_small_sld_20261021/final-proof.json`. Whitespace-only layout
under existing per-function anchors seals DeInstantiate3DCar15words (1047/48),
MATRIX3DT_Copy10words (all1541) and Showroom20words (3405/06). Full-TU token
proof includes literals/directives; all489 code/branch gates,21 ELFs/CPE,
complete local/region/frame/type facts and prior150strict/116absolute survive;
now153/119. No literal original macro/comment claim follows from shared tags.
Updated M2C's s32-pointer +=4 is double-scaled relative to raw addiu4 BYTES;
keep typed +1, not a blindly copied decompiler stride. No new object/fence,
qualifier, per-statement anchor, fake scope or generated-output rewrite.

Constructor real-array/cursor follow-up (2026-10-21):
`build/nc12/r3dcar_shape_source_20261021/final-proof.json`. Zero-based first
consumption shpfiles[index++] plus the actual color-setting carObj arguments
remove shape and shpfile without a substitute object/pun. Plain typed indexing
alone reverses two adds; integer-address forms disturb scheduling. The real
cursor source shape preserves the whole ELF/CPE and all520 words. Native locals
22->20 with every other complete tuple intact, supplied17; legacy EXTRA464->462.
All489 code/branch gates and150strict/116absolute seals survive. One previously
incorrect block-end line changes215->218 at+1608 (retail180); disclose it, not a
constructor SLD seal. Other488 maps/regions/types and seven headers survive.
Old color references/identity are repriced and still unresolved, not exemptions.
No fake use, new name/qualifier, asm/volatile or generated-output rewrite.

Constructor acquisition-argument source receipt (2026-10-21):
`build/nc12/r3dcar_instantiate_source_20261021/final-proof.json` and
phase-proof.json. Directly nesting locatebig AFTER a separate color store is
not equivalent to the old source phases for codegen. Put the real color store
in the real carObj argument while passing the nested acquisition as data:
selected stock emits acquisition -> color store -> texture load, all520 words
and the whole normal ELF unchanged, without textureData. Both argument values
and the assignment are real program work: no dummy operand, zero identity,
source alias or scope is added. Stock RTL/calls.c and the MIPS argument area
provide the bounded explanation; do not generalize a C++ argument-order rule.
All489 code/branch gates,21 whole ELFs/native CPE, native local/scope/type facts,
previously correct target tags and150strict/116absolute seals survive. The
removed variable was debug-elided, so legacy EXTRA counts do not decrease.
Four generic carrier labels are retired/replaced with explicit unresolved
producer work; the color aliases/fences/identity are not proved original by
failed direct controls and remain visible. No whole-constructor seal is claimed.

R3DCAR dimensions full SLD receipt (2026-10-21):
`build/nc12/r3dcar_dimensions_sld_20261021/final-proof.json`. Ordinary layout
under anchor956/header958 seals330 absolute word/file tags, ten block records,
end1041 and twelve complete provided local tuples, with every executable token
unchanged. Both vertex passes, min/max source phases, wheel fields and radii
have separate retail lines; respect source phases rather than scheduled opcode
order or delay-slot tags. No fake declaration, scope, use, qualifier or output
rewrite is required. Literal original macro/comment text remains unproved.
Updated M2C adds stale arg3/second sqrt arguments and mis-types a full pointer
as s16. Raw/SYM and actual one-input fixedsqrt settle that; halfword DATA loads
do not imply a halfword POINTER. Keep correct source arity/types, not artifacts.
All489 detailed/branch gates,21 whole ELFs/native CPE and prior149strict/
115absolute contracts survive; now150/116, R3DCAR3/27 strict. Remaining native
differences/captures are not hidden by this function's seal. Full goal stays open.

R3DCAR anchor-calibration receipt (2026-10-21):
`build/nc12/r3dcar_anchors_20261021/final-proof.json` and anchors.json. Derive
the signature-to-native-header distance from the actual source/current native
record before anchoring it to retail. This unit has25 distance2 definitions,
one split pointer return at distance3, and one one-line definition at distance0.
A universal header-minus-one rule is wrong.27 source anchors recover27 exact
filenames/headers with unchanged code/literals/body layout and relative SLD.
Two EXISTING relative contracts (GetFileName23words, InsertCarFacetZ8words)
gain full absolute certificates:113->115; strict selection stays149. The other
25 internal SLD maps are not sealed. Fourteen old unqualified SLD-VERIFIED
labels are replaced by a comparison requirement, not by new green claims.
All489 code/branch gates,21 whole normal ELFs/native CPE, prior local/scope/
type contracts and seals survive. M2C omits unchanged incoming/forwarded args
in both small bodies; raw/SYM/callee use settles arity, not that omission.
The same round's13 cop-name source controls fail and are not adopted; neither
an early predicate nor duplicate calls proves a replacement original object.
Keep copIdx and the other producer questions explicitly unresolved, no floor.

Chunk-list ownership and remaining producer receipt (2026-10-21):
`build/nc12/bworld_buildlist_sld_20261021/final-proof.json`. A for within the
old manual viewInd block adds an unwanted level; removing that manual block
and letting the for own viewInd preserves all203 words and eleven provided
local tuples. Its body ends824 before increment825, restoring all six block
records. Split genuine cull phases and move chunkPtr's source assignment to
750 before translation work; typed build-array stores need no redundant cast.
SLD improves191differences->one, not zero. The remaining +4 HIGH tag is688
versus677. Read-only calibrated GDB snapshots and independent selected-stock
RTL show its source785 address hoisted by loop optimization to688, not a
scheduler defect. Standalone/control/observed outputs agree, and this target's
diagnostic instruction stream equals stock; do not generalize that to a whole-
compiler identity or rewrite output. No unproven early alias is added.
All489 code/branch gates,21 whole normal ELFs/native CPE, prior149strict/113
absolute seals and all local/scope/type contracts survive. No target strict
seal is claimed. chunkViewList's source-object producer remains explicit review.
The glare round's same-count while/work-expression candidate is a negative
control: it preserves bytes/locals but shifts genuine region addresses. It was
reverted exactly and re-gated before further work. Record full identity, not
just count, before accepting object removal. BWORLD remains11/21 strict.

BWORLD matrix source/SLD receipt (2026-10-21):
`build/nc12/bworld_matrices_sld_20261021/final-proof.json`. Reprice the old
asymmetric-load-order claim: three night/cop loads followed by three stores,
using the existing provided t1/t2/t3, preserve the entire stock normal ELF.
Ordinary per-function-anchored layout seals181 word/file tags,28 block records,
all21 provided local tuples and end575. FOR owner515 versus initialization516
requires independent statement attribution: cp/parse.y4023 explicitly supports
compound for initialization. Its real `i=-1` statement supplies that note
without a new object or debug region. Merely splitting the expression header
keeps its init on515; moving all of it to516 moves one block record. Neither
partial layout is a full seal. Literal original macro/syntax remains unproved.
Read-only RE2-style GDB control/observed and standalone outputs agree; the
alternate host target differs from stock and is not the byte/SYM authority.
Selected-stock isolated target independently equals full-TU instructions after
diagnostic-only private-symbol serial normalization; no output is rewritten.
All489 detailed/branch gates,21 whole ELFs/native CPE, prior148strict/112absolute
seals and all local/region/type contracts survive; now149/113, BWORLD11/21.
Tests105/vtable1368/link/raw299819/299819 remain green. No fake use/scope,
new name/qualifier, asm/volatile, compiler flag or post-compile rewrite.

BWORLD phase-order/layout follow-up (2026-10-21):
`build/nc12/bworld_source_followup_20261021/final-proof.json`. InitSpikeBelt's
zero stores precede its minimum initializers in retail source order, despite
the compiler hoisting constants earlier in execution. Keep the original for-
owned counter: a separate declaring block creates an extra native region even
with identical bytes, and while controls misplace/add regions. Ordinary layout
then seals43 tags/six block records/end348 with all owners preserved.
OpenContext's unchanged switch tokens seal46 tags/two block records/end1221;
the first break must share1205 with its last store. All489 detailed/branch
gates pass, all21 whole normal ELFs/native CPE and previous146strict/110absolute
contracts survive, now148/112. BWORLD10/21 strict; the full goal stays open.
The same round's eleven allocator-return and24 visibility-index controls are
negative, not source-object exemptions. Ten return forms keep bytes but lose
the exact call/return tag split or region contract; direct punctuation changes
move both groups (cp/parse.y RETURN expr action emits the completed-statement
line before expanding the return). No visibility control keeps the full stream.
No failed experiment lands, no original carrier necessity is proved, and no
literal-original-text claim follows from the two new SLD certificates.

1. **NO register-asm pins** (`register … asm("$N")`) — fence dials replace them.
   A hard-reg *clobber* fence is pin-adjacent and needs user sign-off.
2. **NO FLOORS.** Every fn ends PASS or a NEW named angle with receipts.
   Falsified levers are receipted in-source with their diff counts so nobody
   re-fights them. Read a fn's existing receipts BEFORE working it.
3. **Zero PASS→FAIL.** Re-gate your whole TU (and TU-mates for wiring changes)
   after every landing.
4. Avoid `volatile` and `do{}while` by default — a measured win with falsified
   alternatives receipted may override (several catalog laws are exactly this).
   Treat `volatile` as a high-cost diagnostic dial: it can freeze CSE, alias,
   liveness, and scheduling decisions that later steps need for further diff
   reduction. Do not retain it merely for a local score decrease; re-test the
   surrounding reduction path without it and keep it only when the final
   authoritative result requires it.
5. **Never** edit: `tools/*.py`, shared maspsx, the memory dir, or the user's
   live session files (`recon/frontend/common/fedialog_externs.h`,
   `femenudefs.cpp`, `femenuextended_externs.h`, `screenusername_externs.h`,
   `recon/nfs4_types.h`, `scratch_*.diff`). Needed changes there → report the
   exact diff.
6. **No git commits / stash / checkout outside your scope.** The orchestrator
   re-gates and commits. Keep per-file backups in your scratchpad after every
   landing (a mid-wave `git stash` incident once wiped four agents' work).
7. Keep `/* @0xVA */` breadcrumbs and in-source `MATCH:` receipt blocks.
8. Think like a 1998 programmer (EA for game/frontend/eaclib, Sony/SN for
   syslib). "Natural 1998 source" rewrites beat dialing, repeatedly.
9. **Hard-floor basin rule:** a deliberate, measured step may temporarily
   increase the authoritative diff when it unlocks a different allocation or
   scheduling basin. Receipt every intermediate score, complete the paired
   follow-up steps before judging the path, and only land the branch when its
   final verified result beats the previous authoritative best; otherwise
   unwind it cleanly.

### Source-exit and real-tail note provenance (2026-10-22)

Do not infer a missing named temporary solely from split SLD tags. TrackSpec_Read
already had its end200 note in stock initial RTL, but first scheduling dropped
it. A real return after successful work on184 preserves it through the final
epilogue while all three block ends remain184. A top-level return200 had extended
the root block incorrectly. No new object or scope is needed. Receipt:
`build/nc12/trackspec_loader_exit_20261022/phase-proof.json`; all63 words and
complete covered local/region/absolute-SLD facts match. trk's source-object/name
remains unresolved despite this seal; direct read controls still change bytes.

Render_Render's load483 versus jump/filled-argument489 likewise needs no view
capture: genuine per-arm HUD/debug/frame-stop work plus its early return489
is merged by stock jump2 into the one surviving tail. Calls remain duplicated
through sched2, then become one each. The normal ELF/CPE, all80 instructions,
parameter/regions and complete native non-SLD record stream are unchanged;
all retail SLD tags now agree. Return488 is a byte-identical negative line
control. Receipt: `build/nc12/render_pause_tail_20261022/phase-proof.json`.
No added runtime work, new variable, fake use/scope, fence or output rewrite.
Erased-copy literal coordinates/spelling are NOT uniquely proved by that seal.
All489 selected detailed/branch checks and prior contracts survive; this is
not a whole-project source-restoration certificate or a universal source idiom.

Sampling-expression/source-note receipt (2026-10-22):
`build/nc12/hrz_stars_layout_20261022/phase-proof.json`. Sky_InitStars already
had the right seven locals/address scopes. Separate `latAngle=random();` and
`latAngle&=0xffff;` preserved code but left its optimized block-end marker before
source198 (relative11). One genuine `latAngle=random()&0xffff;` puts the198 note
before that SAME marker (relative14), matching retail without a new block,
temporary, qualifier or fake operation. All122 words and full covered SYM/SLD
facts match. A cast variant also matches, so literal spelling is not uniquely
proved; don't turn this into a universal fusion rule. Stock .s/owner/raw-record
receipts are authoritative. The ANDI in the next RNG call's delay slot still
uses the previous call's result. Never copy optimized debug endpoints into
impossible C lexical lifetimes or invent aliases outside an artificial scope.

## 6. HAZARDS (all have fired; all cost real time)

- **Heredoc backslash collapse**: bash heredocs (even quoted) collapse `\\`,
  planting raw control bytes / NULs that compile and gate silently. Use the
  Write/Edit tools or numerically-built bytes for ANY escape-bearing content.
  After scripted edits: scan for control bytes, check CRLF/LF unchanged.
- **`pathlib.write_text` truncation** (encoding error → 0-byte file) and CRLF
  conversion: byte-mode temp + size-grew assert + `os.replace`, ASCII-only.
- **Comment receipts** containing `*/` or `/256*/256` close the host comment.
- **Fn-region slicing by forward declaration** truncates the file — anchor on
  `sig + CRLF CRLF {`, assert header count preserved.
- **build.py concurrency**: a half-written table hard-fails every gate
  tree-wide. `ast.parse` it before relying on gate output; probe on copies.
- **Mixed line endings per file** — probe harnesses must try both anchors.

## 7. CURRENT BEST TARGETS (post-W55, re-gate before starting)

1. Build the **qtytrace lane** (§4.6) — unblocks 10+ receipted near-misses.
2. **Phantom-signature sweep**: `(...)`-typed decls in ~24 externs headers emit
   wrong `__Fe` manglings at every call site (real link bugs, gate-invisible;
   `nm`-check finds them; correct typed forms often already exist in sibling
   headers). Two headers are user files — report, don't touch.
3. Remaining heavies, all SYM-structured coloring grinds now: physics
   DoBarrierCheck 214 / CalculateCarAcceleration 217, aih_cop trio, audiocmn
   SoundCar 169 / SFX 134 / Reset 126, PrimClip 552, kCtrlSkidmark 303,
   BuildNumbers 208, username DrawBackground 255, screens far set.
4. Near-seal belt: dozens of 2–10-diff fns with named angles in-source.
5. USER-blocked: `$4`-clobber policy; `nfs4_types.h` signed-char fields +
   `fNumRacers` as int + `AIHigh_BasicCop` dtor.

## 8. REPORT FORMAT (end of your run)

Per-fn ledger (re-gated baseline → final, lever + receipt), falsification list
with basins, catalog-row candidates, exact orchestrator actions (wiring specs
with whole-TU evidence), files touched, backup locations, hazards encountered.
Numbers you did not re-gate yourself do not go in the ledger.
