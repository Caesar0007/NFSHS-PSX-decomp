# W75 SHARED BELT BRIEF (2026-08-23, 20-Opus wave; orchestrator = main session)

## STEP 0 — MANDATORY READS (do these FIRST, fully, before touching any file)
1. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_mips_isa_asm.md` — FULL read.
2. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_psx_cpp_reconstruction_methodology.md` — FULL read (it is long; read all of it).
3. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_asm_pattern_catalog.md` — at MINIMUM the tail sections §18–§23 (the 20B family, compiler-source laws, CELL pricing, refutation-wave laws). Grep earlier sections symptom-first while matching. These memory files are READ-ONLY for you — never edit anything under the memory directory.
4. Your target functions' existing receipts: the `/* W.. */` comment blocks in their recon TU(s) + `git log --oneline -- <tu>` if needed. Do NOT re-run angles a receipt already falsified — find a NEW named angle (NO-FLOORS rule: every fn = PASS or a NEW named angle; a floor doc is a receipt of falsified angles, never a terminal verdict).

## GATE CONTRACT (absolute)
- Repo: `C:\Temp\nfs4-decomp`. Per-function gate: `python tools/verify_asm.py <recon-tu-path> <Fn[,Fn...]>` — C++ fns need the GCC-MANGLED name (as in the board / `asm/nonmatchings/**`), extern-"C" fns the plain name. Whole-TU: `python tools/tugate.py <tu>`.
- BASELINE FIRST: gate every target (and every other fn in the TU) BEFORE any edit; record counts. Re-gate after EVERY edit. Gate the whole TU TWICE before declaring a seal.
- **ZERO PASS→FAIL anywhere, ever.** If an edit regresses any fn, revert it.
- 🔴 NO ASM pins, NO `register ... asm("$N")` value pins (hard rule). `__asm__` allowed only for the established device classes (zero-insn clobbers/fences per catalog 20B/§21-23, GTE/cop blocks, EA expander templates) — and always re-test DEVICE REMOVAL after a real lever lands (20B-as-basin-opener; two W74 seals came from REMOVING devices).
- Verify args/structure vs the m2c corpus + raw oracle before and after (methodology §0 rules 6-7).

## RESOURCE STACK (all verified present)
- m2c per-function corpus (correct, incl. GTE): `C:\Temp\nfs4-clean\Binaries\NFS4-B-USA\c\func_<VA>.c`.
- Retail-PSX idiom corpus: `C:\Temp\ps1-decomp-refs\` (34 repos — sotn-decomp = full PSYQ decomp, silent-hill-decomp, soul-re, CTR, ff7, mgs, parasite-eve-2-decomp incl. `DECOMPILATION_LEARNINGS.md` — READ that guide for transferable levers; NO ASM pins even where PE2/others used them). Plus `C:\Temp\rage-racer-decomp` (100% byte-exact PSYQ corpus) and `C:\Temp\psyz` (PSY-Q 4.0 gcc-2.7.2 lane libgpu/libcd).
- Vendor lib ground truth: `C:\Temp\nfs4-clean\psyq43\extracted` (per-fn named blobs; byte-identity receipts for syslib).
- 🔬 THE COMPILER'S OWN SOURCE: `C:\Temp\gcc-2.8.1-src\extracted\` — local-alloc.c (qty_order/find_free_reg/QTY_CMP_PRI, alloca'd qty_order table ~line 1582), global.c, sched.c, reorg.c, jump.c, regclass.c, caller-save.c, toplev.c (reload_cse_regs :3501), loop.c, fold-const.c, combine.c, cp/. Cite file:line for every allocator/scheduler claim — W72/W74 turned probing into PROVING this way.
- 🔬 INSTRUMENTED cc1: `C:\Temp\nfs4-instr-cc1\` (cc1-ecoff.exe / cc1plus-ecoff.exe with [qty_order]/[find_free_reg] traces; build_cc1.sh, apply_traces.py; build tree `C:\Temp\nfs4-decomp\scratch\gccbuild-ecoff\`). RULES: set Windows-style TMPDIR/TMP/TEMP env before running any 1996-vintage or instrumented cc1 (else `\/ctaNNNNN` failure + repo-root cta* litter); a post-alloc segfault does NOT invalidate alloc traces; traces are receipts, NOT a byte oracle — check lab fidelity PER-FUNCTION AND PER-BASIN before quoting; you may extend instrumentation (e.g. the named [reload_pick] ask) if your basin needs it.
- build.py device tables (PER_FN_TEXT_MOVES / FLAG_SPLICE_272 / CC1_VER_SPLICE / RAW40_SPLICE / PER_TU_FLAGS): rows must be probe-verified (pre-flight: the diff must be a line-multiset permutation, no .set/label/branch moving; numeric-register anchors only; after-lookahead must not reference taken lines). ⚠️ `tools/build.py` currently carries an UNCOMMITTED foreign edit (removal of the stale psxcontroller InGame_ResetPSXController rows) — PRESERVE it; never revert or re-add those rows; re-read build.py immediately before any edit.
- psyqproof dual-lane prover: `tools/psyqproof.py` — REBUILD the TU between your edit and the proof (it reads the build .i).

## PROCESS RULES
- SHARED WORKING COPY: a concurrent human session works in this same clone. Re-read any file immediately before writing it; if a file changed under you, merge, don't clobber. Scratch/backup files: UNTRACKED names only, under `scratchpad/w75/` or the session scratchpad.
- rtl_dump.py writes a FIXED path — copy every dump you rely on to a protected name under scratchpad/w75/ BEFORE running another dump.
- Do NOT `git commit`, `git push`, or stage anything. Orchestrator consolidates.
- Do NOT edit files under `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\`.
- sbs.py output must be redirected to a file, not piped. read_text/write_text: preserve CRLF (pass newline='') — some TUs are CRLF.
- posmis (positional mismatch) is the honest metric on count-exact fns; LCS diff counts are noise there.

## REPORT (final message + file)
Write `scratchpad/w75/<belt-id>_report.md` with: per-fn baseline → final counts, every edit + its gate result, every NEW law/lever with compiler-source citation, falsified angles (named), and any build.py rows added (with the probe evidence). Final chat message = a compressed version of the same. State plainly which fns SEALED (gated twice) and which reduced, with numbers.
