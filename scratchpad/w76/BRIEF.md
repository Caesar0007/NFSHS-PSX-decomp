# W76 SHARED BELT BRIEF (2026-08-23, 20×Fable-5 wave; orchestrator = main session)

## STEP 0 — MANDATORY READS (in this order, before touching any file)
1. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_mips_isa_asm.md` — FULL read.
2. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_psx_cpp_reconstruction_methodology.md` — FULL read.
3. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_asm_pattern_catalog.md` — at minimum §§20–24 (§24 = last wave's harvest: MEM_IN_STRUCT_P two-axis law, reload_cse family complete, cse flush kludge, spill-pool law, sched/reorg laws, process traps). Memory dir is READ-ONLY.
4. 🔴 **YOUR PREDECESSOR'S W75 RECEIPT** — `scratchpad/w75/<your belt id>_report.md` (your prompt names it) plus the `/* W75-* */` receipt blocks in your target TUs. W75 falsified hundreds of cells; do NOT re-run any angle a receipt already killed. Every residual you inherit has a NAMED next angle — start there.

## GATE CONTRACT (unchanged, absolute)
- Repo `C:\Temp\nfs4-decomp`. Per-fn: `python tools/verify_asm.py <tu> <Fn[,Fn...]>` (mangled names for C++, plain for extern "C"). Whole-TU: `python tools/tugate.py <tu>`. Count-exact residuals: price with `python tools/posmis.py` (LCS diff counts are noise there).
- BASELINE FIRST (whole TU), re-gate after EVERY edit, gate the TU TWICE before declaring anything. **ZERO PASS→FAIL tree-wide.** Cross-verify structure vs the m2c corpus + raw oracle before sealing (methodology §0 rules 6–8).
- On any seal via RAW40/272/asm devices: run `python tools/slotcheck.py` on the TU's object (the zero-insn-asm-in-jal-slot UB is gate-invisible — §24F).

## 🔴 POLICY (user order 2026-08-23, supersedes prior rules)
1. **NO after-compile modifications. NONE.** Do not add PER_FN_TEXT_MOVES / RA_SINK / SLOT_UNFILL / BRANCH_RETARGET or any new mechanism that edits compiler output post-hoc. Compiler-INPUT lanes stay allowed: PER_FN_CC1_VER_SPLICE (real alternate cc1), PER_FN_FLAG_SPLICE, PER_TU_FLAGS, PER_FN_RAW40_SPLICE (whole-fn PsyQ-4.0-cc1 lane, scope rule in PADSEQD.c) — these swap the compiler, they don't rewrite its output.
2. **ASM pins and asm insertions are now permitted — LAST RESORT ONLY.** Order of attack is mandatory: (a) predecessor receipt's named angle → (b) catalog §20–24 ladder → (c) sibling-corpus idiom search (below) → (d) established zero-insn device families → (e) ONLY THEN a `register T x asm("rN")` pin or a minimal `__asm__` insertion. A pin/insertion landing MUST: carry a loud comment block listing the falsified alternatives (the receipt that justifies "last resort"), be counted separately in your report as **PIN-SEALED** (not a clean seal), pass slotcheck, and use the PsyQ notations (clobbers ABI-no-$, asm text numeric regs — methodology "GUARDED-ASM gotchas"). A pin that merely saves you search time is NOT last resort — it will be reverted.
3. Existing wired build.py rows stay. `tools/build.py` still holds the USER's uncommitted edits — re-read immediately before any edit, preserve every foreign hunk, `ast.parse` after.

## 🔍 SIBLING-CORPUS MINING (user-emphasized this wave — do it EARLY, not as a last check)
`C:\Temp\ps1-decomp-refs\` — 34 retail-PSX decomp repos. For every residual: grep for the SAME construct (the PsyQ call, the GTE macro cluster, the loop/clamp/abs/fixed-point idiom, the struct-walk shape) and read how the matched source spelled it:
- `sotn-decomp` (biggest, full PSYQ), `silent-hill-decomp` (gcc-2.8.1+aspsx — closest toolchain; grep `@hack|for match|to match`), `soul-re`, `parasite-eve-2-decomp` (READ its `DECOMPILATION_LEARNINGS.md` once), `chrono-cross-decomp`, `mgs_reversing`, `xenogears-decomp`, CTR/ff7/ff8/tomb3/TOMB5/WIPESRC etc.
- Plus outside that dir: `C:\Temp\rage-racer-decomp` (100% byte-exact PSYQ corpus) and `C:\Temp\psyz` (PSY-Q 4.0 / gcc-2.7.2 matched libgpu/libcd/libapi — direct comparandum for syslib).
A community-matched spelling of the same idiom beats hours of dial probing. Verify any borrowed form in OUR lane (their compilers differ) — the gate decides.

## RESOURCES (unchanged from W75, all verified)
m2c corpus `C:\Temp\nfs4-clean\Binaries\NFS4-B-USA\c\func_<VA>.c` · vendor blobs `C:\Temp\nfs4-clean\psyq43\extracted` · gcc source `C:\Temp\gcc-2.8.1-src\extracted` (cite file:line for every allocator/scheduler claim) · instrumented cc1 `C:\Temp\nfs4-instr-cc1` + build tree `scratch/gccbuild-ecoff` (Windows TMPDIR/TMP/TEMP mandatory; per-function AND per-basin fidelity check before quoting any trace; [reload_pick] via env GCC_TRACE_RELOAD_PICK — 2.8.x lanes only, 272-lane fidelity is 1/26) · `scratchpad/w75/vprobe_flag.py` (per-fn flag splice, no build.py edit) · `tools/psyqproof.py` (rebuild TU between edit and proof).

## PROCESS RULES
- SHARED CLONE: the user's own session works here concurrently. **Fleet rule (W75 A5/A6): never sweep spellings on the shared TU — copy the fn into an UNTRACKED temp sibling TU built from a `git show HEAD:<path>` snapshot, probe there, DELETE it (a leftover probe TU in recon/** is a duplicate-symbol hazard), then apply only proven winners surgically to the real file, re-reading it immediately before the write.**
- Mixed line endings are real (bare-LF lines inside CRLF TUs) — anchor with `\r?\n`, write byte-mode preserving endings.
- rtl_dump.py writes a fixed path — copy dumps to protected names. Redirect long tool runs to files, NEVER pipe through head (two W75 receipts died to truncating pipes). reqdelta buffers everything — a timeout yields nothing; prefer allocsim what-if sweeps.
- No git commit/push/stage. No memory-dir writes. Report: `scratchpad/w76/<belt-id>_report.md` (baseline→final per fn, every edit+gate, new laws with citations, falsified angles named, PIN-SEALED items listed separately).
