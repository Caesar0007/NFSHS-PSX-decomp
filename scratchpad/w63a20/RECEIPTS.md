# W63-A20 RECEIPTS — production-lane engineer

Agent: **W63-A20**. Repo `C:\Temp\nfs4-decomp`. HEAD at start `10e1a01b`
(orchestrator advanced it to `56471eb9` mid-run — the brdist vacuity fix).
Landed commit: **`b1aa1e8b`** (`tools/psyqproof.py` only).

Files I modified in the tracked tree: **`tools/psyqproof.py`** and nothing else.
`tools/build.py`, `tools/maspsx`, `C:/Temp/maspsx-master`, `recon/**`,
`configs/**`, `src/**` and the memory dir were NOT touched. Backups:
`scratchpad/w63a20/psyqproof.py.orig.bak` and `psyqproof.py.bak.20260815_135004`.

## 0. Mandatory reads

1. `reference_mips_isa_asm.md` — full.
2. `reference_psx_cpp_reconstruction_methodology.md` — full (1018 lines, paged).
3. `reference_asm_pattern_catalog.md` — §A–§I in full + the W52–W62 harvest tail
   (12A–12K, 13A–13F, **14A–14E**, the row this mission derives from).
4. `AGENT_GUIDE.md`, `scratchpad/w63/BRIEF.md` — full.
5. `scratchpad/w62a20/PRODUCTION_LEDGER.md` + `RECEIPTS.md`,
   `scratchpad/w62a18/SYMBOL_LEDGER.md` §1.2, `tools/psyqproof.py`.

---

## 1. MISSION 1 — the GNU→ASPSX dialect shim  ✅ LANDED (`b1aa1e8b`)

### 1.1 Method: probe the real assembler, don't infer

Two construct tables were run against the actual `C:/Temp/psq43/PSSN/ASPSX.EXE`
2.77 (`aspsxprobe.py` 19 cases, `aspsxprobe2.py` 23 cases). Verdicts:

* **ACCEPT** — numeric regs, `%hi/%lo`, `.set noat/at/reorder/noreorder/`
  `macro/nomacro/volatile/mips1`, `beqz/bnez`, `.L`/`$L` labels, `lwl/swl`,
  `mfc2`, `.word`, `move`, `li`, `la`, `.ent/.end`, `.frame`, trapping `sub`,
  2-operand `div/divu/mult/multu`, **two labels at the same address**.
* **REJECT** — ABI register NAMES (`Destination must be a register`);
  `.set push` / `.set pop` (`Unrecognised .set option`); **every** symbol-
  assignment form: `a = b` and `a equ b` (`Op-code not recognised`), `.set a,b`
  (`Unrecognised .set option`), `.equ a,b` (`Expression must evaluate`);
  `.type` / `.size` / `.weak` (`Expression must evaluate` / `Op-code`);
  3-operand `div`/`divu`/`rem` with `$0` dest **under `.set noat`**
  (`Assembler does not have AT register available`); 2-operand `rem`/`remu`;
  3-operand `mult $0,...`.

### 1.2 The five rules (all general, no per-fn cases)

Implemented as one line-scanning transform in `to_aspsx_dialect()`:

1. ABI reg NAMES → numeric, **skipping `.ascii/.asciz/.string`** so a literal
   `"$a0"` inside string data can never be rewritten (the W62 cut was
   whole-text).
2. `.set push`/`.set pop` → a **tracked** save/restore of the three axes
   (`at`, `reorder`, `macro`), re-emitting only the axes that actually changed.
   The W62 cut emitted a blanket `.set reorder; .set at` on every pop, which is
   wrong whenever the enclosing state was already `noreorder`.
3. `sym2 = sym` → the assignment line is deleted and **`sym2:` is inserted
   immediately after `sym:`**. Chains (alias-of-alias) resolve by iteration; an
   alias whose target label is not found is **left verbatim** so ASPSX errors
   visibly — it is never silently appended at the wrong address.
4. 3-operand `div`/`divu` with a `$0` destination → the 2-operand raw form,
   **inside `#APP…#NO_APP` only**.
5. `.type`/`.size`/`.weak` dropped.

CRLF discipline: the transform detects `\r\n` and re-joins with it (cc1 output
is uniformly CRLF and ASPSX requires it); inserted lines inherit the same EOL.

### 1.3 🔴 The load-bearing finding (rule 4 must stay `#APP`-scoped)

`divu $0,$4,$5` assembles to **different byte counts** in the two assemblers:

```
GNU-as  : 0085001b                                    (raw op, no guard)
ASPSX   : 0085001b a0140200 00000000 0d000700         (raw op + a ÷0 guard)
```

and `div $0,$4,$5` under ASPSX expands to **8 words** (÷0 *and* the −1×INT_MIN
overflow check). Under `.set noat` ASPSX refuses it outright, which is how the
class was found. Consequences:

* our **hand-asm** `divu $zero,rs,rt` (the GNU spelling for "raw divide", used in
  `fixddiv.c` and `fixdinv.c` — the only two sites in `recon/**`) must be
  rewritten to the 2-operand form or the production object gains 4 stray words;
* **compiler-emitted** `div $0,rs,rt` must NOT be rewritten — that assembler-side
  guard expansion is exactly what retail carries, and is what
  `maspsx --expand-div` reproduces on the gate lane (methodology §3.20). A
  whole-file rewrite would have silently deleted the ÷0 guard from every
  compiler divide in the production build — a *correctness* regression that no
  gate would show.

### 1.4 The alias mechanism is proven, not assumed

`aliascheck.py` compiles the five alias-bearing TUs through the shipped prover's
own pipeline and reads the ASPSX object's symbol table: **25/25 co-equal XDEFs
sit at the canonical symbol's exact `(section, offset)`** —
`nullfunc` 20/20 @sect2+0x0, `fixddiv` 1/1, `fixdinv` 1/1, `sinfunc` 1/1,
`isqrttbl` 2/2 @sect2+0x28.

### 1.5 Acceptance

* The 7 rows that were `TU_BUILD_FAIL` in W62 all prove **REAL=0 RELOP=0** now:
  `rdiv` 42w, `fixedinverse` 14w, `setclipwindow` 2w, `intcos` 1w, `intsin` 26w,
  `decodeshiftjis` 26w, `remapshiftjiscode`.
* The full GNU-dialect set (29 TUs / **260 rows**) → **255 REAL=0 (98.1 %)**;
  the 5 non-zero rows are all pre-existing SHIM_MASKED entries
  (`nfile::FILE_completeop` 6+2, `nfile::iFILE_ExecCommand` 1+2,
  `drawc::DrawC_NightHeadlight` 3+3, `draww::DrawW_DrawQuad` 303+7,
  `draww::DrawObjectSimple` 160+24). **Zero new ledger entries.**
  Full table: `dialect_tus.out` and §2.3 of the ledger.
* Certified controls re-run after **every** write to `tools/psyqproof.py`
  (`ast.parse` before each write, `.bak` first):
  `iSND100hzserver` REAL=0 RELOP=0 reloc=12 · `Night_KillNightDriving__Fv`
  REAL=0 RELOP=0 reloc=18. Unchanged throughout.

### 1.6 Open source-fidelity item (NOT closed by the shim)

The shim makes 25 TUs *provable*, not *portable*. Their `__asm__` blocks are
still GNU-as dialect and the original toolchain cannot assemble them as written.
A source pass would fix that permanently: numeric registers,
`.set noreorder`/`.set reorder` instead of `.set push/pop`, a real second label
instead of `sym2 = sym`, the 2-operand raw divide, and drop `.type`/`.size`
(they exist only so objdiff sizes hand-asm symbols on the gate lane). Reported,
not done — it touches 25 recon TUs and several are near other belts.

---

## 2. MISSION 2 — the maspsx `.lcomm` guard  ⛔ PATCH + PROOF ONLY (as instructed)

The fix lives in `maspsx/__init__.py`, which is **agent-off-limits** (AGENT_GUIDE
hard rule 5, and the W62-A18 spec says the same). So: exact patch + a probe, and
stop.

* **Patch:** `scratchpad/w63a20/lcomm_guard.patch` (unified diff, 1 code line +
  comment). Apply to **both** `C:/Temp/maspsx-master/maspsx/__init__.py` (the
  live one — `build.py` `MASPSX = _env("NFS4_MASPSX", "C:/Temp/maspsx-master/
  maspsx.py")`) and the `tools/maspsx` mirror; the two files are byte-identical
  today. Applier: `apply_lcomm_guard.py` (byte-mode I/O + `ast.parse` +
  line-ending assert — `write_text` would flip the file to CRLF and make the
  diff whole-file).
* **What it changes:** `if section == "bss":` → `if section == "bss" and symbol
  in self.comm_symbols:` — i.e. only a `.comm` (true tentative definition) gets
  a `.globl`; a `.lcomm` (file static) stays local, matching GNU as.

### 2.1 Probe results (`lcomm_probe.py`, `gatecmp_lcomm.py`, `lcomm_census.py`)

Both assemblers run side by side on the **same** cc1 `.s` under `build/`, with
build.py's exact maspsx argv; objects go to a private temp dir.

* **Population** (`lcomm_census.py`): **26 TUs / 54 file-statics** are globalized
  (a `.lcomm SYM,N` only reaches the bss arm when `N > -G`; frontend/common at
  `-G0` sends everything there). Includes 5 `gSwapFileName` copies + 4 syslib
  TUs (`libgpu/SYS.c`, `libmcrd/{LIBMCRD,USERFUNC}.c`, `libpad/{PADMAIN,
  PADPORTD}.c`).
* **Binding**: `gSwapFileName` goes **`B` → `b`** in all five static TUs, while
  the genuinely global copy in `screentrophyroom.cpp` stays `D` (it is
  initialized data, never affected). Global `.bss` symbols across the 26 TUs:
  **57 → 3** (the 3 survivors are real `.comm` globals and correctly stay `B`).
* 🔶 **The guard is NOT byte-inert** — 16 of 26 TUs change `.text` bytes. Not a
  defect: with the symbol LOCAL, GNU as emits the reference as
  `R_MIPS_HI16/LO16 .bss` + the symbol's offset folded **into the instruction's
  immediate** (`addiu s0,s0,66`), instead of a named reloc with a 0 addend. Same
  address after link; this is exactly the methodology §3.12 "base+offset FUSION
  artifact" class that `verify_asm` already normalises (LO16-relocated
  displacement → 0, reloc-name lenient).
* **Gate neutrality, MEASURED not assumed** (`gatecmp_lcomm.py`, the 12H
  anti-drift pattern — loads `verify_asm.py`'s own source, substitutes only the
  output dir, one fresh subprocess per TU): all **26 affected TUs / 554 fns**
  gated **twice**, stock vs guarded → **0 verdict moves**, PASS counts identical
  per TU.

### 2.2 Recommendation to the orchestrator

Land the patch on both maspsx copies, then re-run `tugate` tree-wide (the
554-fn sample is already green) and regenerate the link model — the guard is the
prerequisite for the W62-A18 `gSwapFileName` M2 row and removes 24 latent
name-collision hazards from the symbol table.

---

## 3. MISSION 3 — the re-sweep + the tree-wide branch-distance census

### 3.1 psyqproof re-sweep

Deliverable: **`scratchpad/w63a20/PRODUCTION_LEDGER.md`** (+ `.csv`, 2972 rows)
— the W62 one is left untouched. Headline: **2916/2972 = 98.12 % REAL=0**
(98.45 % of the 2962 provable rows), **`HARNESS_GAP` 7 → 0**,
**`LANE_DIVERGENT` 5 → 0**, and every remaining non-zero row (46) is
`SHIM_MASKED`. W62→W63 regression diff over the 2955 common rows: **0 worse**,
5 better, 7 status recoveries.

Harness: `jobgen.py` (row enumeration + shim/lane map, `assert len(ea100)==2972`)
→ `pqbatch2.py` (imports `tools/psyqproof.py` verbatim) → `merge.py` →
`analyze.py` → `mkledger.py`. Equivalence receipt: the batch and the shipped
prover give identical REAL/RELOP/reloc on `iSND100hzserver`,
`Night_KillNightDriving`, `rdiv`, `setclipwindow`.

### 3.2 Tree-wide brdist census — 🔴 TWO MORE VACUITY/FALSE-POSITIVE DEFECTS

Run per the orchestrator's mid-wave directive, on the **current** (w63-a15
vacuity-fixed) `tools/brdist.py`, over **458 TUs / 3500 fns** — the first
tree-wide branch-distance census. Harness `brdist_tree.py` + `_brdistrun.py`:
loads the shipped `brdist.py` at run time, substitutes only the object output
dir (private, so `build/**` is neither read nor polluted while 17 belts churn),
one fresh subprocess per TU.

**Raw first pass: 129 divergent fns, 25 of them on 100.00 % board rows** — which
would have read as 25 PulloverCam-class production bugs. It is not: 21 of those
25 are `psyqproof` **REAL=0 RELOP=0** — byte-identical to retail — so a branch
distance divergence there is *arithmetically impossible*. That contradiction is
the tell.

**Defect 1 — a spimdisasm `.word` IS an instruction.**
`oracle_branches()` skips every line starting with `.`, but spimdisasm renders
every unrecognised instruction — i.e. **every GTE/COP2 op** — as
`.word 0x4A480012`. Each is a real 4-byte instruction occupying an index slot,
so the oracle's instruction index under-counts and every branch whose target
label lies past a `.word` reports a bogus distance. All 25 false hits are in the
GTE-heavy render TUs (`drawc`, `draww`, `flare`, `hrzsku`, `sfx`, `trsproj`,
`weather`). Worked example: `TrsProj_TransPtN16` — oracle has
`beqz $a2,.L800E1CD8` at `800E1C60` (true distance 30) and one
`.word 0x4A480012 /* mvmva */` in between; brdist reported 29.
**It also HID a real hit** (`_padInitSioMode`, `BRANCH COUNT 20 vs 21`).

**Defect 2 — case-insensitive oracle lookup.**
`oracle_branches()` opens `asm/nonmatchings/main/<fn>.s` directly, and
`Path.exists()` is case-insensitive on this NTFS checkout: `cd_read` resolved to
the unrelated **`CD_Read.s`** (163 retail words of a different function) →
`BRANCH COUNT 0 vs 17`. With the correct oracle (`func_800F9984.s`) both sides
have exactly 5 branches. `tools/verify_asm.py` already carries the guard
(`_exists_exact` + a `symbol_addrs` VA fallback) and its docstring names both
in-tree pairs (`cd_read`/`CD_Read`, `CD_init`/`CD_Init`); brdist and psyqproof
did not. **psyqproof is fixed and landed** (`a4fa16b5`); brdist is `tools/*.py`
→ patch + proof only.

**Patch:** `scratchpad/w63a20/brdist_guard.patch` (both fixes, `git apply
--check` clean; verified by applying to a copy and re-running: `cd_read`'s false
hit disappears, `iso9660.c` 3 → 2 divergent, the 2 survivors being the genuine
near-misses `CD_newmedia` 98.18 % and `CdSearchFile` 90.31 %).

**THE HONEST CENSUS (both fixes applied, full tree):**

| | fns | divergent | on 100.00 % board rows |
|---|---:|---:|---:|
| brdist as shipped | 3500 | 129 | 25 |
| + `.word` fix | 3500 | 104 | 1 |
| + case fix | 3500 | 103 | **0** |

⇒ **No PulloverCam-class production bug remains behind a green gate anywhere in
the tree.** All 103 surviving hits are on known non-100 % near-misses, where a
branch-distance divergence is expected and carries no new information
(`brdist_analyze_wordfix.out` lists them with their board %). Cross-validation
with the production prover is exact in both directions: after the fixes,
"brdist hit AND psyqproof REAL>0" = 0 and "brdist hit BUT psyqproof REAL=0" = 0
on gate-PASSing rows.

⚠️ Consequence for the wave: **every pre-w63 brdist result is unaudited in TWO
ways, not one** — the a15 unpadded-target bug (branches in the first 4 KiB
skipped) *and* these two. Any "clean" or "dirty" verdict from a GTE-heavy TU
before this patch should be re-run.

---

## 4. HAZARDS HIT (all documented ones fired again)

1. **Heredoc `\\` collapse (#15)** — a quoted bash heredoc carrying a Python
   patch with `f"\t.globl {symbol}"` collapsed the `\\t` and the anchor match
   returned 0. Everything escape-bearing after that went through the Write tool.
2. **`pathlib.write_text` CRLF conversion** — patching the maspsx copy with
   `write_text` flipped the whole file LF→CRLF and made `diff -u` emit a
   1366-line whole-file diff. Fixed with byte-mode I/O + a line-ending assert.
3. 🔴 **A new vacuity instance (12H family): a `\r` in a shell-expanded TU list.**
   `gatecmp_lcomm.py` was fed TU paths from a python-written `.out` file; on
   Windows those lines carry `\r`, `verify_asm` could not open
   `recon/...cpp\r`, printed **nothing**, and every TU read
   `PASS=0 / verdict moves=0` — a clean-looking "no regressions" that was
   entirely fake. Only the last line (no `\r`) was real, which is what exposed
   it. Cure: `rel.strip()` + **treat an empty verdict set as a failure, never as
   agreement**.
4. **Concurrent-belt `build/**` churn** — `draww.cpp.i` was rewritten mid-sweep
   and cc1 read a half-written file (`parse error at end of input`). Re-run
   alone: 26/26 OK. A single TU failure under live belts is a concurrency
   artifact until re-run in isolation.
5. **Repeated `exec` of `verify_asm.py` in one interpreter** silently produced no
   verdicts from the 2nd TU onward — every gate comparison now runs in a fresh
   subprocess.
6. **`git apply --directory=. --include=<path>`** silently applies NOTHING (the
   `--directory` prefix makes the include filter miss) and still exits 0 — the
   "patched" copy was byte-identical to the original and the proof run reported
   the bug as unfixed. Always `grep` the patched artefact for the new text
   before believing a patch landed.

---

## 5. FILES

| file | what |
|---|---|
| `PRODUCTION_LEDGER.md` / `.csv` / `per_tu_table.md` | the W63 deliverable |
| `final.jsonl`, `final_classified.json`, `full.jsonl`, `draww.jsonl` | raw sweep data |
| `jobgen.py`, `pqbatch2.py`, `merge.py`, `analyze.py`, `mkledger.py` | sweep harness |
| `aspsxprobe.py`, `aspsxprobe2.py` | real-ASPSX construct tables |
| `aliascheck.py` | 25/25 co-equal XDEF offset proof |
| `dialect_tus.out` | per-TU acceptance table for the 29 dialect TUs |
| `lcomm_guard.patch`, `apply_lcomm_guard.py` | mission-2 patch + applier |
| `lcomm_census.py/.out`, `lcomm_probe.py/.out`, `lcomm_secdiff.py`, `lcomm_textdiff.py` | mission-2 probes |
| `gatecmp_lcomm.py`, `_gaterun.py`, `gatecmp_lcomm.out` | 554-fn double gate |
| `brdist_tree.py`, `_brdistrun.py`, `brdist_tree.txt/.log`, `brdist_analyze.py/.out` | the tree-wide branch-distance census |
| `psyqproof.py.orig.bak`, `psyqproof.py.bak.*` | pre-edit backups |
