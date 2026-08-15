# W63 COMMON BRIEF (2026-08-15) — read AFTER the two mandatory memory reference files

Repo: C:\Temp\nfs4-decomp. Board 3325/3489 = 95.3% gate-truth; 164 non-100% fns remain.
Baselines: HEAD 10e1a01b. Board file: MATCH_PROGRESS.txt (VA / % / unit / mangled name).

## MANDATORY READ ORDER (every agent, FIRST, before ANY work)
1. C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_mips_isa_asm.md — FULL read.
2. C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_psx_cpp_reconstruction_methodology.md — FULL read.
3. C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_asm_pattern_catalog.md — FULL read; the 12/13/14-series IS your operating manual (allocator laws, scheduler laws, devices, certificates).
4. C:\Temp\nfs4-decomp\AGENT_GUIDE.md (repo root) — process rules incl. volatile-dial + hard-floor-basin rules.
5. This file.

🔴 The memory directory (C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\) is READ-ONLY for agents. NEVER edit/write ANY file there. Your findings go in your receipts dir; the orchestrator harvests to memory at close.

## THE GATE (testing lane)
- Per-fn: `python tools/verify_asm.py recon/<tu-rel> <MangledName>` ('-'=ours, '+'=oracle). Whole-TU: `python tools/tugate.py recon/<tu-rel>`.
- BASELINE FIRST: re-run the gate on every assigned fn BEFORE touching anything — stale board rows are epidemic (9/17 on one W62 belt). build/** is a moving target under concurrent belts: re-measure before acting, never trust leftover build objects.
- Gate 2× after every edit. ZERO PASS→FAIL tree-wide is ABSOLUTE. `python tools/tu_order_audit.py` must stay at 0.
- Do NOT touch these user-live TUs at all: recon/frontend/common/femenu.cpp, fetv.cpp, screenpost.cpp, screenusername.cpp (+ recon/lib/libfns.h, tools/bulkverify.py are dirty-by-user: leave alone).

## THE PRODUCTION LANE (user's standing toolchain rule)
maspsx+GNU-as = testing gate ONLY. Production truth for EA code (game/frontend/eaclib) = PsyQ 4.3.0 original GCC + ASPSX 2.77: `python tools/psyqproof.py <tu-rel> <fn> [-G<n>]`. DUAL-LANE SEAL = gate PASS + psyqproof REAL=0 — report both. syslib = Sony vendor-prebuilt: gate-parity matching only (psyqproof optional; ASPSX artifacts like _padInitDirSeq REAL=1 are certified vendor classes, don't chase).

## EDIT DISCIPLINE
- Source edits (recon/**, headers per HEADER-WISH discipline): yours to make + self-commit per TU AFTER gate 2× clean. Commit messages: prefix `w63aN:`.
- tools/build.py TEXT_MOVES / ver-splices / per-TU flags = ORCHESTRATOR-OWNED. You probe + emit a JSON spec (rel-key, fn, take/after/slot/drop_nop/drop_after rows with label-agnostic $L\d+ anchors, li lines need [^\n]* for hex comments) into your receipts dir + probe proof (before/after counts, 2× runs). Do NOT edit build.py.
- NO register-substitution pins, no byte patches, no blanket volatile. Fences/devices per the catalog; always gate the unlaundered control (identity-launder law).
- Oracle authority: raw asm oracle FIRST for args/returns/delay-slots/signedness (check INPUT ARGS vs oracle before believing Ghidra/m2c arity).
- Windows: ASPSX needs CRLF input; fetv-class files can mix LF and CRLF INSIDE one function — derive line endings PER ANCHOR; never pipe probe harnesses into head/sed (truncating-pipe hazard).

## INSTRUMENTS (all in tools/)
fast.py (per-PID instrumented cc1plus; -fno-exceptions -fno-rtti MANDATORY), qty272.py/reqdelta272.py/qty272_rule.py (272 lane), allocsim.py (ALLOCSIM_LANE=272 drops SIZE), vprobe.py, alpha.py (alpha-rename register-order compare), symblk.py, brdist.py (per-branch distance census — catches production bugs in gate-PASSing fns), width_census.py, dial.py. SYM oracle: nfs4-f-v3.txt frame maps / REG $N carriers. Instrumented cc1plus: C:\Temp\nfs4-instr-cc1.

## CORPORA (read-only; cite paths in receipts; idioms port, flags don't)
C:\Temp\ps1-decomp-refs\* — NOW 15 projects (UPDATED TODAY; new: lom-decomp, sotn-decomp [PsyQ SDK decomp!], ff8-decomp, chrono-cross-decomp, soul-re, rood-reverse, xenogears-decomp; fresh deltas in dw/ff7/pe1/pe2/silent-hill). PE2's DECOMPILATION_LEARNINGS.md = first stop. C:\Temp\rage-racer-decomp, C:\Temp\psyz (PSY-Q 4.0 libgpu/sys.c matched decomp).

## RECEIPTS
scratchpad/w63aN/ (N = your agent number): RECEIPTS.md (per-fn: baseline, angles tried WITH falsification evidence, laws used/discovered with gcc source citations file:line, final state), JSON specs for build.py rows, .bak of any file before heavy surgery. NO FLOORS: every fn ends PASS or a NEW named angle — "unreachable" verdicts need a falsified-angle map, never a terminal claim.
Final agent message = a compact structured summary (seals, drops, laws, specs pending, hazards), NOT prose.
