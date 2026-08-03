# w47-a9 — NEAR-ORACLE FLAG FINGERPRINTING receipts

Agent a9, wave 47. Worktree `C:/Temp/nfs4-wt47-a9`, branch `w47-a9`, base `ba09f774`.
Instrument: the rebuilt near-oracle cc1 at `C:/Temp/nfs4-instr-cc1/` + the real PsyQ
`CC1PSX.EXE` + the stock gate. **No edits to `tools/build.py`** (all overrides are env hooks in
`scratch/w47_a9_verify.py`, a spliced copy of `tools/verify_asm.py`).

---

## 0. HEADLINE

| # | Result |
|---|---|
| **V** | **VALIDATION GATE PASSED.** The method re-derives `-G8` for all four known objects from measured fingerprints ALONE, with a strictly monotone ladder in every case: force **9/9 PASS @G8** (G4 36 diffs, G0 76), device **10/10 PASS @G8** (G4 28, G0 104), cario **7/11 @G8 319** (G4 445, G0 830), hud **46/62 @G8 907** (G4 1272, G0 3879). |
| **A** | **LAB FIDELITY = 195/208 eaclib functions (93.8%)** reproduce CC1PSX instruction-for-instruction under `-O2 -G4 -mgas -msplit-addresses -funsigned-char`. Proven EQUIVALENT AS A GATE SUBSTRATE: on nfile the near-oracle's whole-TU gate result is identical function-for-function to the real toolchain's on **26/27** fns — the one exception is exactly the one Mode-A flagged. |
| **B1** | 🔴 **eaclib HAS NO `-G8` OBJECT.** Full `-G0/-G4/-G8` ladder over **all 31 failing eaclib TUs**: `G4 ≡ G8` in *every* module (no eaclib symbol sits in the 5..8-byte band), `G0` equal-or-worse everywhere except one. The wave's `-G8` hypothesis does not extend from game/psx to eaclib. |
| **B2** | 🔴 **THE ONE `-G` LEAD (spchrule, `-G0/-G1/-G2`) IS FALSIFIED — it is a DECLARATION-SHAPE artifact, and the source fix LANDS.** Declaring `gSentenceRuleTest` as an UNSIZED ARRAY (§3.12 #5) reproduces the whole `-G≤2` win at the tree's **stock -G4**: `iSPCH_GetRuleSettings` 43 → **40 diffs, count-exact 112/112**, TU 57 → 54. No flag change needed. |
| **C** | 🔴 **540 flag×TU probes (30 modules × 18 flags), EXACTLY ONE improvement.** Everything else inert or worse. Independently corroborates a8's "29 of 31 show no flag identity". |
| **D** | **A BAR FOR A FLAG-IDENTITY CLAIM** (proposed): a true per-module flag lands the oracle's **exact instruction count** and converts FAILs to **PASS** (as `-G8` does: force 9/9, device 10/10). `smemman -fno-expensive-optimizations` does neither (48→41 diffs, 137→136 vs oracle **135**) ⇒ below the bar, a nudge not an identity. |
| **E** | 🔴 **`tools/build.py` GAP: `compile_c` ignores the `g_value` PER_TU key** — it is honoured only in `compile_cpp`. Any future eaclib/syslib `-G` finding would silently be a NO-OP. Patch snippet in §6. |

---

## 1. THE VALIDATION GATE (mode B, oracle-direction)

Method: gate the WHOLE TU under `-G0 / -G4 / -G8` with the stock normalizer, and ask which -G
minimises total diffs. Nothing about the four objects' known status is fed to the instrument.

```
python scratch/w47_a9_sweep.py recon/game/psx/force.cpp "$(python scratch/w47_a9_fnlist.py game/psx/force)"
```

| object | G0 | G4 | G8 | derived |
|---|---|---|---|---|
| game/psx/force  | 6/9 PASS, 76 diffs | 7/9, 36 | **9/9, 0** | **-G8** ✅ |
| game/psx/device | 6/10, 104 | 8/10, 28 | **10/10, 0** | **-G8** ✅ |
| game/psx/cario  | 1/11, 830 | 5/11, 445 | **7/11, 319** | **-G8** ✅ |
| game/psx/hud    | 23/62, 3879 | 39/62, 1272 | **46/62, 907** | **-G8** ✅ |

4/4, monotone, no false positives. Per-function ladders in `scratch/w47_a9/hud_G.txt` and the
sweep tables. **⇒ the method is trusted for its eaclib claims below.**

Read together with a10's **H2** (`MIPS_DEFAULT_GVALUE 8`; CC1PSX with no `-G` prints `-G value =
8`): these four objects are the ones whose module rule passed **no `-G` at all**. The fingerprint
cannot distinguish "explicit -G8" from "-G omitted" — and does not need to.

---

## 2. MODE A — LAB FIDELITY, and why it matters

`scratch/w47_a9_fp.py` compiles one `.i` with BOTH compilers and diffs the instruction stream
function by function (directives + `-g1` `LMnn:` line labels dropped, `$L` labels renumbered).
It reproduces w46's memcard baseline exactly: **19/20 IDENTICAL**.

| TU | ident/total | divergent functions |
|---|---|---|
| pad | 5/5 | — |
| nfile | 26/27 | iFILE_ExecCommand |
| stream | 31/32 | STREAM_cancelrequest |
| spchpick | 24/27 | iSPCH_ChooseSentence, iSPCH_ConstantRuleSet, iSPCH_SentenceGetChoices |
| spchevnt | 15/16 | iSPCH_ClearOldEvents |
| sst | 15/16 | iSNDstreamhotroddatachunks |
| spchrule | 8/9 | iSPCH_GetRuleSettings |
| salloc | 3/4 | iSNDallocchan |
| slib | 4/5 | iSNDserve |
| vramfxya | 2/3 | vramfxya |
| trnsmult | **0/1** | transmult |
| sbdload | **0/1** | iSNDdownloadbank |
| nsync 10/10 · sbhdrcpy 1/1 · sserver 6/6 · syncfile 8/8 · asinfunc 2/2 · spchbank 8/8 · spchinit 7/7 · resize 1/1 · setfont 1/1 · fileroot 9/9 · unref 2/2 · smemman 4/4 · sdmemman 3/3 | all identical | — |

**TOTAL 195/208 = 93.8 %.**

### 2b. The substrate-equivalence proof (why fidelity is the right certificate)
Running the near-oracle THROUGH THE GATE (`NFS4_A9_CC1=…/cc1-elf.exe`, near flags) on nfile:

```
                              real CC1PSX      near-oracle cc1
whole TU                      18/27 PASS,132   18/27 PASS,148
every function                 identical        identical
   except iFILE_ExecCommand         10               26
```

The ONLY function whose gate number differs is the ONLY function Mode A flagged. ⇒ **Mode-A
identity per function is a sound certificate that a lab measurement transfers to the real
toolchain**, and the divergent set is the method's exact limit.

### 2c. Flag-semantics faithfulness
`w47_a9_modea.py faithful '<flag>' <mod>` compares the SET of functions the real compiler changes
under a flag against the set the lab changes. Measured **FAITHFUL** (identical sets) for
`-fno-expensive-optimizations` on smemman and spchrule. ⇒ lab-side flag reasoning (incl.
`GCC_TRACE_ALLOC` traces) is admissible for those flags on Mode-A-identical functions.

### 2d. METHOD LIMIT — the SN-DIVERGENCE SET (the "1/20 memcard class"), and an honest correlation
The 13 functions above are where SN's patched CC1PSX diverges from stock gcc-2.8.1 codegen.
Their gate status: iSNDserve 69 · iSPCH_GetRuleSettings 43 · vramfxya 34 · transmult 31 ·
iSNDdownloadbank 23 · iFILE_ExecCommand 10 · iSPCH_ConstantRuleSet 10 · iSNDallocchan 4 ·
STREAM_cancelrequest 2 · iSPCH_SentenceGetChoices 1 · **PASS**: iSPCH_ChooseSentence,
iSPCH_ClearOldEvents, iSNDstreamhotroddatachunks.

⚠️ **FLOOR-HYGIENE / HONEST STATISTICS.** The raw enrichment (10/13 = 77 % fail vs an 11 % base
rate) is mostly a SIZE effect. Size-controlled over 157 functions of 10 TUs:

| stratum | n | fail | mean insns |
|---|---|---|---|
| all | 157 | 16.6 % | 41.9 |
| lab-DIVERGENT | 7 | 57.1 % | 111.1 |
| lab-IDENTICAL | 150 | 14.7 % | 38.7 |
| **size ≥ 60, DIVERGENT** | **7** | **57.1 %** | 111.1 |
| **size ≥ 60, IDENTICAL** | **35** | **31.4 %** | 84.0 |

⇒ within the size-matched band the enrichment is only **1.8×** on **n=7**. **NOT significant, NOT
a law.** Report it as: *divergence is a cheap flag that a residual may be SN-compiler-specific*,
never as a verdict. The USABLE half is the negative: a **Mode-A-IDENTICAL** function's residual is
**provably not** SN-compiler-specific — stock-gcc reasoning (allocsim/qtytrace/the lab traces)
applies to it in full.

---

## 3. MODE B — the -G census over ALL 31 failing eaclib TUs

`scratch/w47_a9/gladder_1.txt`, `gladder_2.txt`. Format `PASS/total/diffs`.

`G4 == G8` in **31/31**. `G0` strictly worse in 8 (nsync 29→57, spchevnt 28→30, nfile 132→171,
fileroot 0→69, unref 17→32, vramfxya 34→38, stream 8→24, spchpick 37→53, sdpacket 16→20), equal
in 22, **better in exactly one: spchrule 57→54** — §4.

**⇒ eaclib is `-G4`-or-`-G8` INDISTINGUISHABLE (no symbol in the 5..8 band) and definitely not
`-G0`. The `-G` axis is CLOSED for eaclib.** This is the cross-check a7's signature census needs.

---

## 4. 🔴 THE spchrule "-G0/-G2" LEAD — FALSIFIED, AND REPLACED BY A LANDING SOURCE FIX

a8 reported (and my ladder independently found) that spchrule's `iSPCH_GetRuleSettings` improves
43 → 40 with count landing exactly on the oracle (112/112) at `-G0/-G1/-G2`.

**Threshold located:** G0 = G1 = G2 = 40 diffs; G4 = G8 = 43. The whole delta is ONE symbol,
`gSentenceRuleTest` (4 bytes, `0x80137098`):

```
-G2 :  lui $2,%hi(gSentenceRuleTest) ... lw $2,%lo(gSentenceRuleTest)($2)   <- retail's form
-G4 :  lw  $2,gSentenceRuleTest                                             <- assembler macro
```
and the retail oracle has **`%hi(gSentenceRuleTest)`** — the split form.

**THE CONFOUND (and the answer).** In `recon/eaclib/psx/spchpsxz/spchrule.c`, the sibling symbol
`gSentenceRuleSet` is already declared as an **unsized array** and is ALREADY `%hi`-split at -G4,
while `gSentenceRuleTest` was declared as a **scalar** (`extern SentenceRuleTestFn
gSentenceRuleTest;`) — 4 bytes, small-data-eligible at -G4 ⇒ macro form. Same object, same -G,
two behaviours ⇒ the discriminator is the **DECLARATION SHAPE**, not the flag
(methodology §3.12 #5 / IDT R30xx Ch9: *"for external arrays either omit the size or give the
correct size"*).

**PROBE (applied, measured, reverted):**
```c
-extern SentenceRuleTestFn gSentenceRuleTest;
+extern SentenceRuleTestFn gSentenceRuleTest[];      /* + 3 uses -> gSentenceRuleTest[0] */
```
| config | TU diffs | iSPCH_GetRuleSettings |
|---|---|---|
| stock (scalar decl, -G4) | 57 | 43 (ours 113 / oracle 112) |
| scalar decl, -G2 | 54 | 40 (ours **112** / oracle 112) |
| **array decl, stock -G4** | **54** | **40 (ours 112 / oracle 112)** |
| array decl, -G2 | 54 | 40 |

**⇒ the array declaration reproduces the ENTIRE -G win at the tree's own -G4.** The `-G` lead is
retired; the fix is a 4-line source change in spchrule.c and belongs to whoever owns that TU
(a2). Residual 40 is then pure `$t0`↔`$a3` colouring + the frame-slot offset (28 vs 36) — a
normal allocator residual, and `iSPCH_GetRuleSettings` is in the SN-DIVERGENCE set (§2d), so
expect the lab's traces to be admissible only with care there.

🔑 **GENERALISATION (route to a7):** an oracle `%hi(SYM)` on a ≤4-byte symbol is **NOT** evidence
of `-G<4`. It is equally produced by an unsized/large-declared extern at any `-G`. **A `-G`
signature census MUST control for the recon's declaration shape before scoring a symbol**, or it
will manufacture false `-G0`/`-G2` objects.

---

## 5. MODE B — the flag sweep (independent of a8)

`scratch/w47_a9/flags_{1,2,3}.txt`, merged in `flags_all.txt`. 30 modules × 18 candidate flags
(a10's ranked list minus every proven no-op: `-funsigned-char`, `-mgpopt`, `-fno-defer-pop`,
`-mgas`, `-msplit-addresses`; `-mrnames` was never in the list — see a8's maspsx-corruption trap).
220 non-inert measurements.

**IMPROVEMENTS: 1 of 540.**

| module | flag | dDIFF | dPASS |
|---|---|---|---|
| sndpsxz/smemman | `-fno-expensive-optimizations` | **−7** | 0 |

Inert cluster-wide (30/30 modules): `-fwritable-strings`, `-fshort-enums`, `-freg-struct-return`,
`-fno-common`, `-fno-builtin`; 29/30 `-fno-caller-saves`; 27/30 `-fsigned-char`; 26/30 `-mmemcpy`.
Uniformly WORSE everywhere: `-fno-omit-frame-pointer`, `-fno-delayed-branch`,
`-fno-schedule-insns`, `-fno-schedule-insns2`, `-finline-functions`, `-mno-split-addresses`
(outside pad.c, which already carries it).

**⇒ a10's ranks 2 (`-fsigned-char`) and 5 (`-fno-omit-frame-pointer`) are FALSIFIED for eaclib**,
as are `-O3`/`-finline-functions`, `-mmemcpy`, `-freg-struct-return`, `-fshort-enums`,
`-fno-common`, `-fwritable-strings`, `-funroll-loops`, `-fno-strength-reduce` (outside sbdload,
which already carries it).

### 5b. The smemman lead, corroborated and bounded
| flags | iSNDmalloc |
|---|---|
| stock | 48 diffs, ours **137** / oracle 135 |
| `-fno-expensive-optimizations` | 41 diffs, ours **136** / oracle 135 |
| `+ -fno-cse-follow-jumps` | 41, 136 |
| `+ -fno-rerun-cse-after-loop` | 41, 136 |

Exactly a8's numbers, reached independently. Blast radius = **1 function**, and the lab is
**FAITHFUL** on that flag/TU (§2c) so a `GCC_TRACE_ALLOC` mechanism trace is admissible. But no
CSE flag closes the last instruction and no function converts to PASS ⇒ **below the flag-identity
bar (§0 D)**. Treat as a 1-insn source-shape problem with a CSE-flavoured symptom, not as
smemman's build identity.

### 5c. a3's iSNDfreechan exhibit (requested fingerprint)
`iSNDfreechan` is **Mode-A IDENTICAL** (salloc 3/4; the divergent one is `iSNDallocchan`) ⇒ the
lab reproduces CC1PSX on it exactly and can be traced. Its oracle carries `3× %hi(sndgs)` +
`2× %hi(D_801478F4)` for `1× %lo(D_801478F4)` — i.e. a *rematerialised* second `%hi`. Note the
shape family: `sndgs` is already an unsized array (split form, matches), while `DAT_801478f4` is
declared a **4-byte scalar** — the *same* scalar-vs-array discriminator that produced the false
`-G` signal on spchrule (§4). a3 records the `DAT_801478f4_v[0]` array view as already tried and
neutral in that basin, so this is a *shape* note, not a new claim; but the per-SITE mix a3
describes is **not reachable from any whole-TU flag** (`-mno-split-addresses` is per-TU and a3
measured it at 123 diffs), which is consistent.

---

## 6. `tools/build.py` GAP (report-only; consolidator wires it)

`compile_cpp` honours `PER_TU_FLAGS["…"]["g_value"]`; **`compile_c` does not** — it uses the
global `G_VALUE` for both the cc1 `-G` and the maspsx `-G`. Every eaclib/syslib TU is the C lane,
so a `-G` finding there would silently do nothing. (My probes bypass this via
`NFS4_A9_GVALUE`, which patches `bld.G_VALUE` + `bld.CC1_FLAGS` + the per-TU key.)

```python
 def compile_c(src: Path, skip_asm: bool) -> Path:
     rel = src.relative_to(ROOT)
     tu_flags = per_tu_flags(src)
+    tu_g_value = str(tu_flags.get("g_value", G_VALUE))
     ...
-    cc1_flags = list(CC1_FLAGS)
+    cc1_flags = [f for f in CC1_FLAGS if not f.startswith("-G")] + ["-G" + tu_g_value]
     ...
-                  *AS_ARCH, f"-G{G_VALUE}", "-I", ROOT / "include",
+                  *AS_ARCH, f"-G{tu_g_value}", "-I", ROOT / "include",
```
⚠️ Nothing in the tree needs it TODAY (§3: eaclib has no `-G` object), so landing it is a
no-op-safe hygiene fix, not a codegen change.

---

## 7. TOOLS (committed, `w47_a9_` prefixed)

| tool | what |
|---|---|
| `w47_a9_fp.py` | MODE A: near-oracle vs real CC1PSX, fn-by-fn instruction-stream compare |
| `w47_a9_modea.py` | batch fidelity + flag-semantics FAITHFULNESS |
| `w47_a9_verify.py` | `tools/verify_asm.py` + `NFS4_A9_GVALUE` / `NFS4_A9_CC1FLAGS` / `NFS4_A9_CC1` hooks. Same normalizer ⇒ its numbers ARE gate numbers |
| `w47_a9_sweep.py` | MODE B whole-TU gate under N configs (`--cfg 'LABEL:G:EXTRA:CC1PATH'`) |
| `w47_a9_gladder.py` | the -G0/-G4/-G8 ladder over many modules |
| `w47_a9_flagsweep.py` | MODE B flag sweep, a10's ranked list minus the no-ops |
| `w47_a9_fnlist.py` | gateable fn list for a TU (from `src/**` INCLUDE_ASM) |

### Gotchas paid for this wave (add to the standing list)
* **`-g1` emits `LMnn:` debug line labels.** Any cc1-vs-cc1 stream compare that does not drop
  them scores EVERY function as `d2`. (This alone hid the 19/20 baseline at first.)
* A copy of `verify_asm.py` outside `tools/` must `sys.path.insert(0, ROOT/'tools')` or
  `build.py`'s `import fix_symsizes` explodes.
* `expected/` does not exist in a fresh worktree ⇒ derive fn lists from `src/**` INCLUDE_ASM,
  not from expected-object symbol tables.
* Bash `nohup … & nohup … &` on one line: only the first redirect target's directory is
  guaranteed to exist at parse time — launch background batches one statement at a time.
* **C: hit 100 % full mid-wave** (a3 saw it too). It killed my first `git worktree add`
  half-way; the partial tree had to be removed and the branch re-created. All numbers in this
  file were measured AFTER recovery, and the memcard 19/20 baseline reproduces the w46 receipt
  exactly, which is the end-to-end check that nothing was truncated.

---

## 8. CROSS-CHECK — a10's `-fverbose-asm` probe confirms the near-oracle flag set EXACTLY

a10's 0.2 s probe makes each compiler print its OWN "options enabled" set. Run on both:

```
CC1PSX  -O2 -G4                                       -fverbose-asm
cc1-elf -O2 -G4 -mgas -msplit-addresses -funsigned-char -fverbose-asm
```

| | |
|---|---|
| flags CC1PSX enables that the lab does not | **`-msoft-float`, `-mcpu=R3000`** (both cosmetic: the lab prints `-mcpu=3000` and its target is soft-float by construction) |
| flags the lab enables that CC1PSX does not | **`-mcpu=3000`** (the same flag, spelled differently) |
| identical `-f` flags | **25 / 25** |

⇒ **`-mgas -msplit-addresses -funsigned-char` reproduces CC1PSX's enabled-option state exactly**
— an independent, codegen-free confirmation of w46's near-oracle flag discovery, and the reason
the 19/20 memcard identity holds. Any remaining lab-vs-CC1PSX divergence (§2d) is therefore
**not** a flag difference: it is SN's patch to the compiler itself.
