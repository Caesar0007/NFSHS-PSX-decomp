# W85 wave guide (2026-09-02) — read AFTER the two R0 memory files

## USER ORDER (verbatim)
"Dispatch 20xOpus-5 agents for matching and clear _asm_ (including asm pins)/
volatile run - from whole project. Don't leave breaked PASS in FAIL states.
Make all remaining functions in whole project are SYM-exact, source-level
PASS, using detailed verify_asm/vdiff as authoritative; preserve user edits,
use reference decomp idioms/macros where helpful, and do not reintroduce
post-compiler instruction moves or seals. Avoid using volatile and asm,
exception can be done only for cop0 and gte macro. FONT.c / LIBMCRD.c can be
edited, I'm not working on them.
rules: no post compilation moves, no editing of tools\*.py, only C source
level match without volatile and _asm_ (exception can be done only for
cop0, gte macro). volatile is allowed in MMIO functions."

## USEFUL TOOLS (user's list)
1. C:\Temp\gcc-2.8.1-src\ — gcc source (local-alloc.c qty_order/find_free_reg/
   QTY_CMP_PRI @~1582, global.c, sched.c, reorg.c, jump.c, regclass.c,
   caller-save.c, toplev.c, cp/).
2. C:\Temp\nfs4-instr-cc1\ — instrumented cc1 workspace (near-oracle traces).
3. C:\Temp\nfs4-decomp\scratch\gccbuild-ecoff\ — its build tree.
4. C:\Temp\nfs4-psx — decompiles per function.
5. C:\Temp\ps1-decomp-refs — PSX reference decomps (forks updated 2026-09-02).
6. SYM: C:\Temp\nfs4-psx decompiles\nfs4-psx-sym.txt
7. SYMDUMP pseudo-C: C:\Temp\nfs4-psx\nfs4-psx-symdump-disasm.txt
8. C:\temp\nfs4-clean\Binaries\NFS4-B-USA\c — m2c per fn (correct cop0/gte).
9. C:\Temp\windows-gcc-psx — retail-source gcc ladder.
10. syslib = 2.7.2 lane; older versions can also fit some TUs.
11. eaclib mainly 2.8.x; older versions can also fit some TUs.
12. Try rewriting floor-functions from RAW binary asm — sometimes it helps.
13. C:\Temp\PSYQ — official PsyQ versions 2.00-4.60 (4.10 cc1 = retail
    cygnus-2.7.2-970404 SN32; W84 measured it on the certificates — see
    scratchpad/w84/C1-C4 receipts before re-measuring anything).

## DEVICE CLASSIFICATION (the heart of this wave)
CLEAR (these are the targets — remove + re-crack to PASS source-only):
  - `register T x asm("$N")` PINS (22 known; census list in your prompt).
  - Output-less identity fences: `__asm__("" : "=r"(x) : "0"(x))`,
    `__asm__("")` CSE/sched boundaries, `__asm__ volatile("")`.
  - `&&label` address-taken V2 devices (`static void *X[1] = { &&lbl };`).
  - `volatile` on PLAIN STATE (non-MMIO, non-IRQ-shared): remove if PASS
    holds or can be re-cracked.
KEEP (sanctioned — do NOT touch):
  - cop0 / GTE macro blocks (mtc0/mfc0/rfe, mtc2/ctc2/lwc2/swc2/cop2 .word).
  - BIOS A0/B0/C0 thunks (`li $t2,0xB0; jr $t2; li $t1,N`) and libsn stubs.
  - DMPSX/tool-expanded fixed-reg templates (vramfxya/movf/fastmovf OT-link
    class, methodology §3.25-2) INCLUDING their `*(T *volatile*)&global`
    dummy-input operands — that volatile is part of the sanctioned template.
  - SLD-proven .ASM hand-transcriptions (savegp, libmath vendor asm, etc.).
  - MMIO volatile: pointers/lvalues at 0x1F80xxxx device addresses, BIOS
    kernel globals, and `volatile` state blocks the oracle PROVES re-read
    (store→reload idiom, §3.12 #13 — e.g. libcd `_cdr`). When in doubt
    whether a volatile is MMIO/IRQ-real vs a codegen crutch: remove it,
    gate; if PASS holds it was a crutch (delete), if it breaks and the
    oracle shows real re-reads it is semantic (restore + mark KEEP).

## THE IRON RULE
**Don't leave breaked PASS in FAIL states.** Before touching a file, record
its full per-fn gate state (`python tools/verify_asm.py <file> <fn,...>`).
After each removal, re-gate the WHOLE file. A removal that regresses any fn
and resists a source-level re-crack (try the catalog levers + permuter) is
RESTORED verbatim and receipted as KEEP-with-reason. End state per file:
every previously-PASS fn still PASS, devices strictly fewer or justified.

## PROHIBITIONS
- NO git operations. NO edits to tools/*.py, regiondiff/tools/*.py,
  MANIFEST/PROGRESS boards, .github/**, toolchain.zip, memory dir.
- FONT.c and LIBMCRD.c ARE editable this wave (user released them).
- Regional rows: candidates only under regiondiff/recon/; gate =
  regiondiff/tools/verify_region.py <REGION> <cand> <fns> --lane-as=recon/<unit>.<ext>.
- No new devices of any kind; no post-compile moves.

## RECEIPTS
scratchpad/w85/<ID>_receipt.md, banked incrementally: per-file before/after
gate tables, every device removed/kept with reason, every falsified angle
with numbers. Leave every file in its best-gated state.
