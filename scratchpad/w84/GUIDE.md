# W84 wave guide (2026-09-02) — read AFTER the two R0 memory files

## USER ORDER (verbatim)
"Make all remaining functions in whole project are SYM-exact, source-level
PASS, using detailed verify_asm/vdiff as authoritative; preserve user edits,
use reference decomp idioms/macros where helpful, and do not reintroduce
post-compiler instruction moves or seals. Avoid using volatile and asm,
exception can be done only for cop0 and gte macro.
rules: no post compilation moves, no editing of tools\*.py, only C source
level match without volatile and _asm_ (exception can be done only for
cop0, gte macro)."

## USEFUL TOOLS (user's list, verbatim)
1. C:\Temp\gcc-2.8.1-src\ — the gcc source itself (extracted\): local-alloc.c
   (qty_order, find_free_reg, QTY_CMP_PRI @~1582), global.c, sched.c, reorg.c,
   jump.c, regclass.c, caller-save.c, toplev.c, cp/ front end.
2. C:\Temp\nfs4-instr-cc1\ — instrumented-cc1 workspace (build_cc1.sh,
   apply_traces.py, cc1-ecoff.exe / cc1-elf.exe / cc1plus-ecoff.exe —
   near-oracle [qty_order]/[find_free_reg] traces; receipts, not a byte oracle).
3. C:\Temp\nfs4-decomp\scratch\gccbuild-ecoff\ — the build tree for those.
4. C:\Temp\nfs4-psx — decompiles per function.
5. C:\Temp\ps1-decomp-refs — PSX reference code (forks updated 2026-09-02).
6. SYM: C:\Temp\nfs4-psx decompiles\nfs4-psx-sym.txt
7. SYMDUMP pseudo-C: C:\Temp\nfs4-psx\nfs4-psx-symdump-disasm.txt
8. C:\temp\nfs4-clean\Binaries\NFS4-B-USA\c — M2C decompile with correct
   cop0/gte macro support, per function.
9. C:\Temp\windows-gcc-psx — other RETAIL compiler versions (norcse-style
   self-built rungs are BANNED — retail compilers only).
10. syslib is 2.7.2-compiled, but older versions can also be used for some TUs.
11. eaclib mainly PASSes under 2.8.x, but older versions can also be used for some TUs.
12. Try rewriting from RAW — sometimes it helps.

## HARD PROHIBITIONS (any violation = the work is discarded)
- NO git commit / push / stash / checkout — the orchestrator consolidates.
- NO edits to: tools/*.py, regiondiff/tools/*.py, MANIFEST.tsv,
  REGION_PROGRESS.txt, MATCH_PROGRESS.txt, .github/**, toolchain.zip,
  and NOTHING under C:\Users\Vyacheslav\.claude\projects\**\memory\.
- USER-LIVE FILES — NEVER edit in place:
  recon/syslib/psx/libgpu/FONT.c and recon/syslib/psx/libmcrd/LIBMCRD.c
  (uncommitted user probes in the working tree). Work on a COPY under
  scratchpad/w84/ and gate the copy; the user joins work later.
- Regional agents: do NOT edit the base tree (recon/**, src/**, asm/**,
  configs/**, include/**) at all — regional candidates live ONLY under
  regiondiff/recon/. Do NOT run update_region_progress.py (expensive,
  collides across agents).
- No `register ... asm("$N")` pins; no volatile; no __asm__ except cop0/gte
  macro blocks; no post-compile instruction moves; no verify-tool edits.

## REGIONAL PIPELINE (agents R01-R16)
Read C:\Temp\nfs4-decomp\regiondiff\README.md in full — it is the pipeline
contract. Summary:
- Your rows: scratchpad/w84/<ID>_rows.tsv (function, class, repr_region,
  region_va, words, unit, candidate). Work ONLY your rows' candidate files.
- Seed: CHANGED -> copy recon/<unit>.<ext> verbatim to the candidate path
  (mkdir -p the dirs). REGION-ONLY -> new standalone TU from
  regiondiff/m2c/<REGION>/<fn>.c (self-contained externs; keep func_<va>
  names; no invented semantic names — mechanical RDAT_<reprVA> for
  unidentified region-layout globals + [INFERRED] comments).
- MEASURE FIRST: gate the unedited seed — the diff IS the regional change.
  Read it beside regiondiff/m2c/<REGION>/<fn>.c and sibling regions' slices.
- Gate (authoritative for regional rows):
  python regiondiff/tools/verify_region.py <REGION> <candidate> <fn[,fns]> --lane-as=recon/<unit>.<ext>
  REGION-PASS = sealed for this pipeline (stream + non-reloc immediates;
  documented layout-mask soundness gap — do not chase masked address fields).
- TRAP: regional VAs are the REGION's memory layout. NEVER resolve a
  regional address through configs/symbol_addrs.txt (base layout). Identify
  globals via callers/strings/oracles INDEX.tsv/cross-region compare.
- A worked seal (AIState pair) is in regiondiff/README.md — the down-count
  p[i]=0 strength-reduction shape; catalog levers apply unchanged.
- CHANGED fns are the same source + retail deltas: usually a small guard /
  extra call / table clear on top of the base body. Do not rewrite what
  already matches.

## RECEIPTS + CRASH PROTOCOL
- Receipt file: scratchpad/w84/<ID>_receipt.md — for EVERY row: final
  status (REGION-PASS / FAIL n / blocked), the regional delta in one line,
  falsified angles with numbers. BANK FINDINGS AS YOU GO (write the receipt
  incrementally BEFORE long experiments — session kills happen).
- Leave every candidate file in its best-gated state; report exact gate
  command lines used.
