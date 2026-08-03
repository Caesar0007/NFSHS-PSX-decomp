# w47-a10 — GCC LANE ROUND 3 receipts

Agent a10, wave 47. Worktree `C:/Temp/nfs4-wt47-a10`, branch `w47-a10`, base `ba09f774`.

**STATUS: §1 THE OPTION LIST — COMPLETE and EMPIRICALLY VERIFIED. a7/a8/a9 read §1.**

---

## 0. HEADLINE — read this before sweeping anything

Six results that change what the flag axis should sweep. All are *measured on the real
CC1PSX*, not read off gcc source:

| # | Finding | Consequence for a7/a8/a9 |
|---|---|---|
| **H1** | CC1PSX self-identifies as **`GNU C version 2.8.0 SN32 Build 4.0.0007 (SonyPlayStation)`** and its `f_options[]` string table is **byte-for-byte identical in content and order to stock gcc-2.8.1 `toplev.c`** | The gcc-2.8.1 source IS the option authority for this compiler. §1 list is complete. |
| **H2** | **`-G` DEFAULTS TO 8.** `MIPS_DEFAULT_GVALUE 8`; CC1PSX with no `-G` prints `# -G value = 8` | 🔴 **The four "-G8 objects" are the objects whose makefile passed NO `-G` at all.** -G8 is not a deliberate choice, it is an *omission*. That is far more plausible as 1998-EA per-module variation than a deliberate `-G8`, and it predicts the -G8 set is *arbitrary* (whatever TUs were built by a rule that dropped the flag), not semantically clustered. |
| **H3** | **`char` is UNSIGNED by default in CC1PSX** (`lbu` with no flags; `-funsigned-char` is a NO-OP; `-fsigned-char` flips it to `lb`) | 🔴 The briefing's suspect `-funsigned-char` is **the wrong direction**. The per-module lever is **`-fsigned-char`**. This is the answer to the standing `charactertbl signed-char` question — if a TU needs signed char, sweep `-fsigned-char`. |
| **H4** | **`-msplit-addresses` and `-mgas` are CC1PSX DEFAULTS**, printed in "options enabled" at every -O level | Confirms w46: the *rebuilt stock* cc1 needed them added because stock mips.h has `TARGET_DEFAULT 0`. They are **not** per-module levers in the retail build — the lever is the negation `-mno-split-addresses` (already a `PER_TU_FLAGS` key). |
| **H5** | **`-mno-gpopt` is a NO-OP at any `-O>=1`.** `override_options()` does `if (threshold<=0) &= ~MASK_GPOPT; else if (optimize) \|= MASK_GPOPT;` — the `-O` re-enable runs *after* the switch | 🔴 Drop `-mgpopt`/`-mno-gpopt` from the sweep. **Only `-G0` turns gp-opt off.** Verified empirically: `-mno-gpopt` alone produced byte-identical asm to the default. |
| **H6** | The **ccpsx driver forwards `-m...` and `-f...` VERBATIM** (`-m... machine specific option`, `-f... compiler option/optimisation` in its help), and offers `-ON` with "O0=none, O3=max" | Every flag in §1 is reachable from a module makefile's CFLAGS. No driver filtering to worry about. |

### 🆕 SN-ONLY FLAG DISCOVERED
`-funroll-max=N` exists in CC1PSX's option-string table (sitting exactly where stock 2.8.1
parses `-dumpbase` / `-ffixed-` / `-fcall-used-` / `-fcall-saved-`) and **is NOT in gcc-2.8.1
source**. It is an SN Systems addition, presumably a cap on `-funroll-loops` unrolling.
Measured effect on a loop TU with `-funroll-max=1` alone: **0** (needs `-funroll-loops` to
matter). Low prior, but it is real and it is spellable.

---

## 1. THE COMPLETE OPTION LIST FOR CC1PSX (gcc 2.8.0 SN32 4.0.0007)

### 1a. `-f` optimisation flags — the exact `f_options[]` table
Verified present in CC1PSX's string table, in this exact order (= gcc-2.8.1 `toplev.c:643`).
"Dflt@-O2" is the state with `-O2` and nothing else, read off CC1PSX's own
`-fverbose-asm` "options enabled" line (empirical, not inferred).

| flag | Dflt @-O2 | Set by | Pass / mechanism | Expected asm symptom if flipped |
|---|---|---|---|---|
| `-ffloat-store` | off | — | expr.c; forces FP through memory | none on PSX (soft-float) |
| `-fvolatile` | off | — | all pointer derefs volatile | every deref re-loaded, no CSE |
| `-fvolatile-global` | off | — | global derefs volatile | globals re-loaded each use |
| `-fdefer-pop` | **ON** | -O1 | calls.c stack pop deferral | 🚫 **inert on MIPS** — `ACCUMULATE_OUTGOING_ARGS` is defined in mips.h, there are no pushes to defer. Measured `-fno-defer-pop` delta = **0**. Drop from sweep. |
| `-fomit-frame-pointer` | **ON** | -O1 (via `CAN_DEBUG_WITHOUT_FP`) | function.c / prologue | 🔴 **big** (86 diff lines): `-fno-omit-frame-pointer` makes every fn set up `$fp`/`$30`, save it, `.frame $fp`. **Census-able in one grep of the oracle**: if NO retail fn frames on `$30`, no module used it. |
| `-fcse-follow-jumps` | **ON** | -O2 | cse.c | CSE across branches lost |
| `-fcse-skip-blocks` | **ON** | -O2 | cse.c | CSE across empty blocks lost |
| `-fexpensive-optimizations` | **ON** | -O2 | cse/combine/loop | measured 0 on probe; shape-dependent |
| `-fthread-jumps` | **ON** | -O1 | jump.c | redundant branch chains survive |
| `-fstrength-reduce` | **ON** | -O2 | loop.c biv/giv | 🔴 **big** (77): induction vars not strength-reduced → `mult`/`sll` index math inside loops instead of a walking pointer |
| `-funroll-loops` | off | — | unroll.c (known-count loops) | 🟠 (30) duplicated loop bodies |
| `-funroll-all-loops` | off | — | unroll.c (all loops) | as above, more |
| `-fwritable-strings` | off | — | varasm.c section choice | 🟢 (2) string literals land in **`.data` not `.rdata`** — *directly checkable against the retail image's literal placement* |
| `-fno-peephole` | (peephole ON) | default | final.c `peephole()` | measured 0 on probe; mips.md has few peepholes |
| `-fforce-mem` | **ON** | -O2 | expr.c: force mem operands to regs | shape-dependent |
| `-fforce-addr` | off | — | expr.c: force address constants to regs | measured 0 on probe; would add explicit addr materialization |
| `-fno-function-cse` | (function-cse ON) | default | calls.c: fn addr in reg | measured 0 (direct `jal` either way) |
| `-finline-functions` | off | **-O3** | integrate.c | 🔴 **biggest** (123): static/small fns inlined at call sites. **A TU whose oracle has NO call to a small static helper that your recon does call = -O3 suspect.** |
| `-fkeep-inline-functions` | off | — | emit out-of-line copy too | extra dead fn body in obj |
| `-fno-inline` | (inline ON @-O1+) | -O1 | integrate.c | measured 0 on probe |
| `-fkeep-static-consts` | **ON** | default | varasm.c | unreferenced `static const` kept |
| `-fsyntax-only` | off | — | — | (no output) |
| `-fshared-data` | off | — | varasm.c | n/a on PSX |
| `-fcaller-saves` | **ON** | -O2 | caller-save.c | measured 0 on probe (allocator preferred `$s` regs); on register-pressure TUs it decides *save-around-call vs use-callee-saved*. Keep in sweep for high-pressure fns only. |
| `-fpcc-struct-return` | **ON** | `DEFAULT_PCC_STRUCT_RETURN 1` | calls.c/function.c | `-freg-struct-return`: small structs returned in `$v0/$v1` instead of via hidden pointer. Measured 0 on probe (no struct returns). **High value on any TU with struct-returning fns.** |
| `-freg-struct-return` | off | — | (inverse of above) | see above |
| `-fdelayed-branch` | **ON** | -O1 (`DELAY_SLOTS`) | reorg.c `dbr_schedule` | 🔴 **big** (49): all delay slots become `nop`. Instantly visible — a module with unfilled slots. |
| `-frerun-cse-after-loop` | **ON** | -O2 | cse.c 2nd run | measured 0 on probe |
| `-fpretend-float` | off | — | host FP emulation | none |
| `-fschedule-insns` | **ON** | -O2 (`INSN_SCHEDULING`) | sched.c pre-reload | 🔴 **big** (68): instruction order (esp. load/use separation) changes throughout |
| `-fschedule-insns2` | **ON** | -O2 | sched.c post-reload | 🟠 (22) post-RA reordering |
| `-fpic` / `-fPIC` | off | — | — | n/a (also disables gp-opt) |
| `-fexceptions` | (=2 auto) | — | except.c | C lane: no effect |
| `-fsjlj-exceptions` | off | — | except.c | C lane: no effect |
| `-fasynchronous-exceptions` | off | — | except.c | C lane: no effect |
| `-fprofile-arcs` | off | — | profile.c | counter code emitted |
| `-ftest-coverage` | off | — | profile.c | `.bb`/`.bbg` output |
| `-fbranch-probabilities` | off | — | needs `.da` | n/a |
| `-ffast-math` | off | — | — | none on PSX |
| `-fno-common` | (common ON) | default | varasm.c | 🟠 uninit globals emitted as **`.sdata`/`.data` + label + `.space`** instead of `.comm`. **Changes the LINKED LAYOUT** (defined-in-section vs common) — a real, checkable per-object signature. Verified. |
| `-finhibit-size-directive` | off | — | final.c | `.size` suppressed |
| `-ffunction-sections` | off | — | varasm.c | per-fn sections |
| `-fverbose-asm` | off | — | final.c | the comment header (our probe tool) |
| `-fgnu-linker` | **ON** | default | (already in build.py; redundant) | ctor/dtor emission |
| `-fpack-struct` | off | — | stor-layout.c | 🔴 all struct fields byte-packed. Measured 0 on probe but would be *catastrophic* on struct-heavy TUs. Low prior for EA. |
| `-fstack-check` | off | — | explicit stack probes | extra insns per prologue |
| `-fbytecode` | off | — | — | n/a |
| `-fcheck-memory-usage` | off | — | — | n/a |
| `-fprefix-function-name` | off | — | — | n/a |

### 1b. `-f` LANGUAGE flags (`lang_options[]`, also present verbatim in CC1PSX)
`-ansi` · `-fallow-single-precision` · `-f[no-][un]signed-bitfields` · `-f[no-][un]signed-char`
· `-f[no-]traditional` · `-f[no-]asm` · `-f[no-]builtin` · `-f[no-]hosted` · `-f[no-]freestanding`
· `-f[no-]cond-mismatch` · `-f[no-]dollars-in-identifiers` · `-f[no-]ident` · `-f[no-]short-double`
· `-f[no-]short-enums`

| flag | Dflt | Symptom |
|---|---|---|
| **`-fsigned-char`** | **char is UNSIGNED by default** | 🔴 `lb` instead of `lbu` on every `char` load; changes compare/extend shapes. **THE top language-flag lever.** |
| `-funsigned-char` | (already default) | NO-OP — do not sweep it |
| `-fshort-enums` | off | 🟢 verified: `.comm ge,4` → `.comm ge,1`, `lw` → `lbu`. Enum globals shrink; enum params/fields change width. Checkable from the oracle's enum-global sizes. |
| `-fsigned-bitfields` | on (ISO) | bitfield extract `sra` vs `srl` |
| `-fno-builtin` | off | `memcpy`/`strlen` etc. not expanded inline |
| `-fshort-double` | off | n/a (soft-float) |

### 1c. `-m` machine flags — the exact `TARGET_SWITCHES` table
CC1PSX's table is identical to gcc-2.8.1 `config/mips/mips.h:383`. **Bold = CC1PSX default.**

`-mint64` · `-mlong64` · **`-msplit-addresses`**/`-mno-split-addresses` · `-mmips-as`/**`-mgas`** ·
`-mrnames`/`-mno-rnames` · **`-mgpOPT`**/**`-mgpopt`**/`-mno-gpOPT`/`-mno-gpopt` · `-mstats`/`-mno-stats` ·
`-mmemcpy`/`-mno-memcpy` · `-mmips-tfile`/`-mno-mips-tfile` · **`-msoft-float`**/`-mhard-float` ·
`-mfp64`/`-mfp32` · `-mgp64`/`-mgp32` · `-mabicalls`/`-mno-abicalls` · `-mhalf-pic`/`-mno-half-pic` ·
`-mlong-calls`/`-mno-long-calls` · `-membedded-pic`/`-mno-embedded-pic` · `-membedded-data`/`-mno-embedded-data` ·
`-meb`/`-mel` · `-msingle-float`/`-mdouble-float` · `-mmad`/`-mno-mad` · `-mfix4300`/`-mno-fix4300` ·
`-m4650` · `-m3900` · `-mdebug` `-mdebuga`..`-mdebugi` · **`-mcpu=R3000`** · `-mips<N>`

Plus `-G N` (driver-level; `-G SIZE  set variable size for gp register optimisation : 0=none`).

| flag | Dflt | Mechanism (pass) | Symptom | Plausibility |
|---|---|---|---|---|
| **`-G N`** | **8** (`MIPS_DEFAULT_GVALUE`), build.py passes 4 | `override_options` → `mips_section_threshold`; then `varasm` section choice + `mips_move_1word` addressing | objects `<= N` bytes go `.sdata`/`.sbss` and are reached in **one gp-rel insn**; `> N` get `lui %hi`/`%lo`. **Also: at `-G0` the `.comm` block is emitted AFTER `.text` instead of before** (the `TARGET_GP_OPT` `asm_out_data_file` file-switching diversion) — a whole-object structural tell independent of any single access. | 🥇 **HIGHEST** — proven 6x already, and H2 makes -G8 the *default*, i.e. the natural omission |
| `-mno-split-addresses` | split ON | `mips_split_addresses` in `override_options` (needs `TARGET_GAS && optimize && !flag_pic`) | verified: `lui %hi;addiu %lo` pair → **`la $r,sym`**, and index form → **`lw $3,arr($2)`** which ASPSX/maspsx expand to `lui $at; addu $at,$at,$idx; lw %lo(sym)($at)`. 🔑 **`$at` used for address materialization inside a fn body is the fingerprint** (per methodology: `$at` only appears from an ASSEMBLER macro). | 🥈 already a `PER_TU_FLAGS` key (w33-a10); census `$at` in the oracle |
| `-mmemcpy` | off | `expand_block_move` in mips.c | verified (63): struct/array copy → **`jal memcpy`** instead of the inline unrolled `lw/sw` x4 block | 🥉 plausible (a size-optimised module); trivially checkable — does the oracle obj call `memcpy` where you inline? |
| `-mgpopt`/`-mno-gpopt` | ON | see H5 | 🚫 **NO-OP at -O>=1**. verified byte-identical. | ❌ **drop** |
| `-mno-gas` (`-mmips-as`) | gas ON | changes `.set`/macro emission + `TARGET_FILE_SWITCHING` | would also disable split-addresses (which requires `TARGET_GAS`). Very disruptive. | ❌ SN's asm is gas-flavoured; retail is clearly `-mgas` |
| `-mrnames` | off | `print_operand` reg naming | `$a0` vs `$4` in `.s` only — **invisible after assembly** | ❌ unobservable |
| `-mlong-calls` | off | calls.c/mips.md | all calls become `jalr` through a reg | ❌ retail has direct `jal` |
| `-membedded-data` | off | varasm section choice | read-only data preferred over RAM | 🟡 low prior, but observable in section placement |
| `-mstats` | off | stderr only | none | ❌ |
| `-mdebuga` | off | `GO_IF_LEGITIMATE_ADDRESS` | disallows `label($reg)` addresses — *overlaps the split-addresses symptom* | 🟡 undocumented; unlikely in a makefile but note the symptom collision |
| `-mdebugc`/`-mdebugd`/`-mdebugf` | off | suppress `seq` expansion / `define_split`s / load-nop suppression | codegen-visible | ❌ undocumented debug switches |
| `-mips1` / `-mcpu=R3000` | default | ISA level | already correct | ❌ |
| 64-bit / FP / PIC / abicalls / mad / 4650 / 3900 / eb | off | — | wrong-hardware; would not assemble/link | ❌ |

### 1d. `-O` level
Empirically confirmed on CC1PSX (options-enabled set diffs):
- `-O1` = `-O0` + `-fdefer-pop -fdelayed-branch -finline -fomit-frame-pointer -fthread-jumps`
- `-O2` = `-O1` + `-fcaller-saves -fcse-follow-jumps -fcse-skip-blocks -fexpensive-optimizations -fforce-mem -frerun-cse-after-loop -fschedule-insns -fschedule-insns2 -fstrength-reduce`
- `-O3` = `-O2` + `-finline-functions` **(and NOTHING else — verified, no flags lost)**

⇒ **`-O3` on a module is exactly and only `-O2 -finline-functions`.** Sweeping `-O3` and
sweeping `-finline-functions` are the same experiment; prefer the explicit flag.
⇒ `-O1` on a module is a *large* delta (loses scheduling + all CSE/strength-reduction);
it is easy to falsify from a single function.

### 1e. Current project baseline (for reference)
`tools/build.py` `CC1_FLAGS = ["-quiet","-O2","-G4","-g1","-mgpOPT","-fgnu-linker"]`.
Note `-mgpOPT` and `-fgnu-linker` are **already the defaults** (harmless no-ops); the only
real content is `-O2 -G4 -g1`.

---

## 2. RANKED PLAUSIBILITY FOR PER-MODULE VARIATION IN A 1998 EA BUILD

What a *module makefile* would realistically override, ranked. (Rank = prior x observability.)

| Rank | Flag | Why a 1998 module makefile would differ | Cheapest discriminator |
|---|---|---|---|
| 1 | **`-G` (absent ⇒ 8, or 0/2/4)** | Per-directory `CFLAGS` that forgot the project-wide `-G4`, or a lib built by its own makefile. **-G8 = the omission case.** | a7's threshold census; plus the `.comm`-after-`.text` tell for `-G0` |
| 2 | **`-fsigned-char`** | A module ported from a signed-char host (PC/Watcom!) that needed `char` to stay signed. EA had a PC codebase — **this is the single most historically plausible language-flag divergence.** | `lb` vs `lbu` on any `char` global/field load in the oracle |
| 3 | **`-mno-split-addresses`** | Already proven per-TU (w33-a10). | `$at` used for addressing inside a fn body |
| 4 | **`-finline-functions` (`-O3`)** | A perf-critical module bumped to `-O3`. | oracle lacks a call your recon makes to a small static |
| 5 | **`-fno-omit-frame-pointer`** | A module built with `-g`-style debug settings left in. | any retail fn framing on `$30` |
| 6 | **`-mmemcpy`** | A size-conscious module. | oracle `jal memcpy` where you inline a block move |
| 7 | **`-freg-struct-return`** | Divergent ABI choice in a lib. | only on struct-returning fns |
| 8 | **`-fno-common`** | Some makefiles carried it for link hygiene. | defined-in-`.sdata` vs common in the link map |
| 9 | **`-fno-schedule-insns` / `-fno-schedule-insns2`** | A workaround for a scheduler bug (period-typical!). | gross instruction-order divergence with correct register colouring |
| 10 | **`-fno-delayed-branch`** | Same (delay-slot bug workaround). | unfilled `nop` delay slots throughout the object |
| 11 | **`-fshort-enums`** | A module sharing structs with size-constrained data. | enum globals sized 1/2 in the oracle |
| 12 | **`-fwritable-strings`** | Legacy K&R code that writes into literals. | literals in `.data` not `.rdata` |
| 13 | **`-funroll-loops` / SN `-funroll-max=N`** | Perf module. | duplicated loop bodies |
| 14 | **`-fno-strength-reduce`** | Bug workaround (very common in 1998 — the famous gcc SR bugs). | index `mult`/`sll` inside loops instead of walking pointers |
| 15 | **`-O1`** | A module that miscompiled at -O2. | massive, obvious |
| — | `-mgpopt`, `-funsigned-char`, `-fno-defer-pop`, `-mgas`, `-msplit-addresses`, `-mrnames` | **NO-OPS / already default** | ❌ **DO NOT SWEEP** |

**Note on flags 9/10/14:** in 1998 "compiler bug workaround" flags were routinely added to a
single module's rule and never removed. They have *large, unmistakable* signatures, so they
are cheap to falsify even at low prior — a TU that resists everything else is worth one
`-fno-schedule-insns` / `-fno-delayed-branch` / `-fno-strength-reduce` probe each.

---

## 3. HOW TO REPRODUCE ANY OF §1 IN 0.2s (the probe recipe)

`-fverbose-asm` makes CC1PSX print its own `-G` value, version banner, and the complete
"options enabled" set. This is the ground-truth oracle for "what is the default":

```sh
cd <scratch>
printf 'int g4[1];\nchar c8[8];\nint big[64];\nint f(void){return g4[0]+c8[0]+big[0];}\n' > probe.i
C:/Temp/psq43/COMPILER/CC1PSX.EXE -O2 -fverbose-asm -quiet probe.i -o probe.s
head -20 probe.s
```
yields
```
 # -G value = 8, Cpu = R3000, ISA = 1
 # GNU C version 2.8.0 SN32 Build 4.0.0007 (SonyPlayStation) compiled by CC.
 # options passed:  -O2 -fverbose-asm
 # options enabled:  -fdefer-pop -fomit-frame-pointer -fcse-follow-jumps
 # -fcse-skip-blocks -fexpensive-optimizations -fthread-jumps
 # -fstrength-reduce -fpeephole -fforce-mem -ffunction-cse -finline
 # -fkeep-static-consts -fcaller-saves -fpcc-struct-return -fdelayed-branch
 # -frerun-cse-after-loop -fschedule-insns -fschedule-insns2 -fcommon
 # -fverbose-asm -fgnu-linker -msplit-addresses -mgas -mgpOPT -mgpopt
 # -msoft-float -mcpu=R3000
```
⚠️ `-funsigned-char`/`-fsigned-char` are **not** in `f_options[]`, so they never appear in
that line — test char signedness with `int f(char*p){return *p;}` → `lbu` (unsigned) vs `lb`.

### The -G threshold signature, ready to paste (a7)
Same `probe.i`, `-G0` / `-G4` / `-G8`:
```
-G0 : lui %hi(g4) + lw %lo(g4)  | lui %hi(c8) + lbu %lo(c8) | lui %hi(big)...   AND .comm block AFTER .text
-G4 : lw $2,g4  (gp-rel)        | lui %hi(c8) + lbu %lo(c8) | lui %hi(big)...   .comm block BEFORE .text
-G8 : lw $2,g4  (gp-rel)        | lbu $4,c8   (gp-rel)      | lui %hi(big)...   .comm block BEFORE .text
```

Artefacts committed alongside this file: `probe1.i`, `pO{0,1,2,3}.s` (per-`-O` option sets),
`pg{0,4,8}.s` (-G signatures), `pc.s`/`pcu.s`/`pcs.s` (char signedness),
`base2.i`+`b_*.s` and `base3.i`+`c_*.s` (the two measured flag sweeps),
`cc1psx_strings.txt` / `ccpsx_strings.txt` (the option-table string dumps).

---

## 4. MEASURED FLAG DELTAS (raw numbers behind §1)

Whole-TU asm diff lines vs the unflagged `-O2` baseline. **0 does not mean "inert" — it
means "no observable effect on THIS probe shape"**; the mechanism column in §1 says what
shape is needed.

Probe `base2.i` (globals, struct copy, string literal, enum, extern calls):
```
-fno-delayed-branch 49   -fno-schedule-insns 68   -mmemcpy 63
-mno-split-addresses 11  -fshort-enums 4          -fwritable-strings 2
-fforce-addr 0  -fno-caller-saves 0  -fno-defer-pop 0  -fno-function-cse 0  -fno-peephole 0
```
Probe `base3.i` (loop + 5 live vars across 8 calls + static helper):
```
-finline-functions 123   -fno-omit-frame-pointer 86   -fno-strength-reduce 77
-funroll-loops 30        -fno-schedule-insns2 22
0 on this shape: -fno-caller-saves, -fforce-addr, -fno-function-cse, -fno-peephole,
-fno-expensive-optimizations, -fno-cse-follow-jumps, -fno-cse-skip-blocks,
-fno-rerun-cse-after-loop, -fno-inline, -fno-thread-jumps, -fno-force-mem, -ffloat-store,
-fvolatile, -fvolatile-global, -funroll-max=1, -freg-struct-return, -fpack-struct,
-fno-defer-pop
```

---

## 5. RECEIPTS SERVED TO a1-a6
(none requested yet — a10 polls the a1..a6 worktree scratch dirs; post a request as
`C:/Temp/nfs4-wt47-aN/scratch/REQ_a10_*.txt` or name the fn in your report and I will run
allocsim / reqdelta / qtyprio / qtytrace on it.)

## 6. ICE-STUB TRACE DEBT (drawc/hud, w46 §6.4) — **CLOSED**

### 6.1 🏆 THE ICE ROOT CAUSE — it is `reorg.c`, and the fix costs NOTHING

w46 recorded the instrumented `cc1plus-ecoff` ICE'ing at `drawc.cpp:2102` / `hud.cpp:2473`
and called it "a 2.8.1-vs-2.8.0 C++ front-end regression". **It is not a front-end bug and
the stub-and-slice recipe is not needed.** Bisected by flag on an isolated `DrawC_PrimMenu`:

```
-O2 -G4 ...                                     ICE
-O1 -G4                                         ICE
-O0 -G4                                         OK
-O2 -G4 -fno-schedule-insns -fno-schedule-insns2 ICE
-O2 -G4 -fno-caller-saves / -fno-strength-reduce /
        -fno-cse-follow-jumps / -fno-expensive-optimizations  ICE
-O2 -G4 -fno-delayed-branch                     ✅ OK
```

⇒ **the ICE is in `reorg.c` `dbr_schedule` (the delay-slot filler).**

🔑 **Why this is free:** `dbr_schedule` is the LAST pass in `rest_of_compilation`
(`toplev.c:3572`, `if (optimize > 0 && flag_delayed_branch)`) — it runs **after**
`local_alloc`, `global_alloc` and `reload`. Every trace point we care about
(`[qty_sugg_order]`, `[qty_combine]`, `[find_free_reg]`, `[allocno_compare]`, `[find_reg]`)
has already fired. **Adding `-fno-delayed-branch` changes ZERO allocator decisions** — it only
leaves the delay slots as `nop`s in the final `.s`.

**Fidelity is still checkable**, because the real CC1PLPSX accepts the same flag: build the
reference with `CC1PLPSX -quiet -O2 -G<n> -fno-delayed-branch` and `cmp_fns.py` against it.
(CC1PLPSX compiles all 20 drawc / 62 hud functions with it — the ICE is purely our rebuild's.)

### 6.2 THE NEW RECIPE (supersedes w46 §6.4)
```sh
python tools/rtl_dump.py recon/game/psx/drawc.cpp -dg -dl        # real CC1PLPSX dumps
cp scratch/rtl/drawc.i mydir/tr.i                                # cc1 names dumps after input!
export TMPDIR='C:\...\mydir\tmp\' TMP="$TMPDIR" TEMP="$TMPDIR"
# reference (real compiler, SAME flag):
cp scratch/rtl/drawc.i mydir/ref.i
C:/Temp/psq43/COMPILER/CC1PLPSX.EXE -quiet -O2 -G4 -fno-delayed-branch ref.i -o ref.s
# traced:
GCC_TRACE_ALLOC=1 C:/Temp/nfs4-instr-cc1/cc1plus-ecoff.exe -quiet -O2 -G4 \
   -mgas -msplit-addresses -funsigned-char -fno-exceptions -fno-rtti \
   -fno-delayed-branch tr.i -o tr.s 2> trace.txt
python C:/Temp/nfs4-instr-cc1/cmp_fns.py A/ref.s B/tr.s        # needs dir-style paths
python tools/qtytrace.py trace.txt <fn> [--steps|--blocked]
```
⚠️ `cmp_fns.py` crashes on paths without a parent directory component
(`p.split('/')[-2]`) — put each `.s` in its own subdir.

`scratch/a10ice/stubloop.py` (committed) automates the residual stubbing for any TU that
still ICEs after `-fno-delayed-branch`: it reads the ICE'ing function out of cc1's own
`In function \`X':` line, stubs its body, and re-runs until clean.

### 6.3 drawc.cpp — RESULT
`-fno-delayed-branch` alone took the traced TU from **10/20 → 14/20** functions emitted with
**no stubbing at all**, and `cmp_fns.py` vs `CC1PLPSX -fno-delayed-branch` gives:

| function | fidelity | trace is a receipt? |
|---|---|---|
| **`DrawC_PrimMenu`** | **SAME** | 🏆 **YES** |
| `DrawC_DividePrim`, `DrawC_PrimStart`, `DrawC_PrimStop`, `DrawC_NightHeadlight`, `DrawC_MenuColorData`, `ChangeTPage`, `DrawC_ReadeMapData`, `DrawC_BuildRenderingData`, `DrawC_KillRenderingData`, `DrawC_SetEnviroment` | SAME | YES |
| `DrawC_Prim` | d405 | no — laboratory only |
| `DrawC_PrimClip` | d762 | no — laboratory only |
| `DrawC_ReadLightingData` | d126 | no |
| `DrawC_PrimHalo` + the 5 Shadow/Spot/Showroom fns | still ICE (a SECOND, distinct bug in `PrimHalo`) | — |

`11 / 20 IDENTICAL`. Artefacts: `scratch/a10ice/{trace.txt,tr.s,ref_ndb.s,pm_qty.txt}`.

### 6.4 🎯 **THE ANSWER a3 ASKED FOR — the Prim-route conflict set**

a3's parked NEXT ANGLE on `DrawC_PrimMenu` was:
> *"count the QTYs in the envmap join block from `-dl`. If it is a <=3-qty block,
> local-alloc.c:1588's hand-rolled comparator applies and the dial is BIRTH ORDER /
> crossing the 3-to-4 qty boundary, not refs."*

🔴 **ANSWER: NO — the `<=3-qty` law does not apply. The envmap uv value is not a local qty
at all; it is GLOBAL ALLOCNO 30.**

From the fidelity-clean trace (`[allocno_compare]` + `[find_reg]`):
```
[allocno_compare] ... 30/205:24/14/0/1=68571 ...
[find_reg] allocno 30 pseudo 205 refs 24 live 14 calls 0 size 1 alt 0 ccl 0 retry 0 -> reg 2
```
`p205` is a3's **merged uv temp** (`(set (reg/v:QI 205) (mem:QI (plus (reg 146/147/148) (const_int 214))))`
— reused at all three vertices, which is exactly why the merge made it one high-refs allocno).
It is **rank #2 of 42** at `pri 6.8571`, and takes `$v0`.

`allocsim` on the REAL dumps reproduces the whole function **42/42, order IDENTICAL**, and
confirms a3's landed 3-cycle fix is exactly reproduced:
```
10: p144  a1  refs=29 live=64   1.8125   <- overlayFlag  ✅ retail $a1
24: p148  a2  refs=22 live=103  0.8543   <- id2          ✅ retail $a2
25: p147  t1  refs=20 live=100  0.8000   <- id1          ✅ retail $t1
26: p146  t2  refs=18 live=95   0.7578   <- id0          ✅ retail $t2
```
**No allocno in our PrimMenu reaches `$t4`–`$t7` at all** (highest caller-saved in use: `$t3`
= p142, then `$t8`/`$t9`). Retail's uv group living in `$t4`–`$t7` therefore requires MORE
simultaneously-live global allocnos across the envmap region — i.e. a **second** uv pseudo,
not a re-ranking of the merged one.

`reqdelta --want p205=t4` returns **no single-dial delta**, and the reason is structural:
`p205`'s live window is only **14 insns**, so regs `$v0..$t3` (10 registers) can never all be
busy across it, whatever its priority. ⇒ **a3's stated bar is confirmed and sharpened:**
the second uv value must be a GLOBAL allocno with a LONG live range (a3's `live >= 48` at
refs 12 stands), and *shortening the merged temp's refs is provably the wrong dial*.
Do not spend more budget on re-spelling the merged temp.

### 6.5 `DrawC_Prim` / `DrawC_PrimClip` — allocno tables ARE valid receipts
Their *traces* are not (d405 / d762), but `allocsim` consumes the **real** compiler's
`.greg`/`.lreg` and reproduces both exactly:
```
DrawC_Prim      MATCH  90/90   (order-vs-dump: IDENTICAL)
DrawC_PrimClip  MATCH 102/102  (order-vs-dump: IDENTICAL)
```
Committed: `scratch/a10ice/prim_allocno.txt`, `scratch/a10ice/primclip_allocno.txt`.
Both open with the same signature a3 predicted — five (Prim) / four (PrimClip) identical
`refs=8 live=4 pri=6.0000` `$v1` allocnos followed by the matching `refs=8 live=5 pri=4.8000`
band: **the per-vertex envmap group, equal refs, ascending lives, ascending registers** —
the same shape as PrimMenu's id triple, so the PrimMenu transcription carries over.

### 6.6 hud.cpp — RESULT
`-fno-delayed-branch` took hud from truncated-at-`Hud_BuildCdPlayer` to **38/62**; three
further functions carry their own distinct ICEs and were stubbed by `stubloop.py`
(**`Hud_BuildCdPlayer`, `Hud_RenderMapView`, `Hud_RenderHudView`**), after which the TU
compiles **clean: 61 functions, 0 ICE, 46/62 IDENTICAL** vs `CC1PLPSX -O2 -G8 -fno-delayed-branch`.

**Fidelity-clean ⇒ the trace IS a receipt for:**
`Hud_BuildReplay` · `Hud_BuildNumbers` · `Hud_BuildTach` · `Hud_Render321Go` ·
`Hud_RenderPauseBox` · `Hud_WingmanFlash` · `Hud_InitMap*` · `Hud_InitTables` · `Hud_Kill` ·
`uppercase` (+ 36 more).

**NOT receipts** (laboratory only): `Hud_Render` (d204) · `Hud_RenderTacView` (d50) ·
`Hud_BuildNumbers0` (d502) · `Hud_Init` (d388) · the three stubbed fns.

Artefacts: `scratch/a10ice/{hudf.i,hudf_trace.txt,hudf.s,hud_qty_receipts.txt}`.
Qty tables for the five clean targets are in `hud_qty_receipts.txt`.

⚠️ Note for a8: **`Hud_BuildNumbers` is fidelity-clean but `Hud_BuildNumbers0` is not** —
the w45 §5 plan to use the instrument on both is only half-supported. For `BuildNumbers0`
use `allocsim` on the real dumps instead.

### 6.7 RESIDUAL / RESUME
* `DrawC_PrimHalo` carries a second, distinct ICE that `-fno-delayed-branch` does not clear
  and that no single `-fno-*` in the -O2 set clears. Not chased (out of budget). Route:
  run `stubloop.py` on drawc to stub `PrimHalo` and recover `ShadowPrim*`/`SpotPrims`/
  `ShowroomPrims` traces, then bisect PrimHalo's body for the offending construct.
* The 3 hud ICEs likewise remain uncharacterised (only worked around).
* Worth doing once: these are bugs in OUR rebuild, so the real fix is a `reorg.c` patch in
  `C:/Temp/nfs4-instr-cc1` sources — that would restore full-`.s` fidelity checking too.
