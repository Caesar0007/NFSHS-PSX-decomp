# W86 wave guide (2026-09-02) — read AFTER the two R0 memory files

## USER ORDER
20 Opus agents: (a) seal the remaining regional code rows (the audit_lo16
hidden-changed class + leftovers), (b) continue the asm/volatile clear with
the W85 breakthrough levers, (c) SYM/SLD-EXACT C code across the frontend
tree (the user's own game/common+game/psx SYM series is CLOSED — do not
redo it). Standing rules unchanged: SYM-exact source-level PASS,
verify_asm/vdiff authoritative, no post-compile moves, no tools/*.py or
regiondiff/tools/*.py edits, no volatile/asm except cop0+gte macros
(volatile allowed in MMIO functions), no pins, retail compilers only.
**The user's work is DONE — no user-live files exist; the whole tree is
workable. Preserve their landed edits (they are the SYM ground truth).**

## RESOURCES (as W85 + new)
gcc source C:\Temp\gcc-2.8.1-src\extracted\; instrumented cc1
C:\Temp\nfs4-instr-cc1; C:\Temp\nfs4-psx decompiles; ps1-decomp-refs;
SYM C:\Temp\nfs4-psx decompiles\nfs4-psx-sym.txt; SYMDUMP pseudo-C
C:\Temp\nfs4-psx\nfs4-psx-symdump-disasm.txt; per-fn m2c
C:\temp\nfs4-clean\Binaries\NFS4-B-USA\c; retail ladders
C:\Temp\windows-gcc-psx + C:\Temp\PSYQ; catalog rows 32A-33C (READ 33A/33B
FIRST — the W85 levers are this wave's standard kit).
NEW: regiondiff/AUDIT_LO16.txt = the per-word delta oracle for the
hidden-changed rows (exact base/region words per insn index);
regiondiff/oracles/<R>/symmap.tsv; regiondiff/data/<R>/*.delta.txt.

## ROW AGENTS (B1-B9)
Rows: scratchpad/w86/B<N>_rows.tsv. Pipeline contract =
regiondiff/README.md (read in full). Per row: candidate may already exist —
⚠️ NEVER overwrite; edit in place. Most rows are the retail string-table
+1 shift: AUDIT_LO16.txt names the exact instruction index and words —
apply the constant, gate. 🔴 THE 32B-5 TRAP: a per-jal constant audit
cannot see CSE-SHARED constants — when one `li` serves two semantic uses,
patching the found site breaks the other (compiles clean, +1 li, count
drifts). Recover the per-class ARG INDEX and re-scan (R02's recipe;
R02_plan.json has the femenudefs value map). Rows that are NOT a constant
shift (real logic deltas) get the normal measure-first treatment. Gate:
python regiondiff/tools/verify_region.py <REGION> <cand> <fns> --lane-as=recon/<unit>.<ext>
Re-gate every previously-SEALED fn of any candidate you touch (iron rule).

## DEVICE AGENTS (D1-D3): re-price the KEPT devices with the new levers
The W85 sweep kept ~100 devices with measured costs. Two W85 breakthroughs
re-open them: **33A-1 pure-C zero-insn REF INFLATOR** (idempotent op with a
VARIABLE operand: `v &= mask; v &= mask;`) and **dead-reassignment CSE
kill**; plus **33A-2(b)** the non-consecutive-double-set LICM shield and
**33A-3 combination pricing** (2^N subset sweeps — pairs can be jointly
removable). Per file: record full gate state FIRST, one device (or priced
combination) at a time, whole-TU re-gate, re-crack or RESTORE. The W85
receipts (scratchpad/w85/S*_receipt.md) list every kept device with its
cost — do not re-measure what they measured; apply the NEW levers only.
Skip devices with compiler-source impossibility proofs (stop_search_p,
reload_cse reg_values, assign_parms preference, loop.c insn_count) — those
are closed classes.

## SYM/SLD AGENTS (S1-S6): SYM-exact C across the FRONTEND tree
The user's own commit series made game/common + game/psx SYM-exact and
closed its declaration audit — the frontend tree got none of it. Task, per
assigned TU (methodology §0 rule 8 + §3.8b — read them):
1. For every function, pull its SYM `8c Function start` block
   (nfs4-psx-sym.txt; parser pattern in memory sym_v3.py or read directly):
   REGPARM param names, `Def class REG $N`/AUTO locals with types/scopes,
   STAT fn-statics, SLD line ranges.
2. Make the C match the SYM's variable structure: every SYM-named local is
   a real C variable of the right TYPE and SCOPE with the SYM's NAME;
   params named per REGPARM; compiler temps that have NO SYM record must
   NOT be materialized as named variables (fold them back into
   expressions where codegen-neutral); declaration ORDER per the SYM
   block. Struct field accesses through real named fields (MOS records),
   not raw offsets, where the shared types allow.
3. 🔴 IRON RULE: every previously-PASS fn stays PASS — whole-TU re-gate
   (tools/tugate.py) after each file; a reshape that regresses is reverted
   (renames alone are codegen-free; SCOPE/ORDER changes are NOT — §3.12
   #15 decl-scope is load-bearing; gate every one).
4. Receipt the per-TU before/after: fns audited, locals renamed, temps
   folded, mismatches that could NOT be applied (with the diff cost).
This is fidelity work, not matching work: the deliverable is C that reads
as the SYM says EA wrote it, at an unchanged 100% gate.

## PROHIBITIONS
No git operations; no tools/*.py, regiondiff/tools/*.py, boards, MANIFEST,
memory-dir edits; no new devices; never overwrite an existing regional
candidate; receipts scratchpad/w86/<ID>_receipt.md banked incrementally.
