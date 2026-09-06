# P879 AudioTrk raw branch audit

## Follow-up: one-line source candidate now fully verified

The later bounded compiler-source diagnostic resolved the edge in an isolated
candidate. **Parent has not yet landed it; production audiotrk.cpp remains
untouched by this agent.** Apply candidate.patch after independent checks.

Replace the unsigned-subtraction range test with the direct native byte interval:

```cpp
if (((u_char)se->type >= 4) && ((u_char)se->type < 36)) {
```

rangecheck.cpp is **6/6 PASS**, target **413/413**, exact -g twin, **zero branch
divergences**, and **1,004/1,004 linked text words match raw retail**. Its thirteen
rodata bytes and four sdata bytes remain exact. Every relocation entry is
unchanged (.rel.text896 bytes, .rel.pdr48 bytes); frame, register-mask and ABI
sections are unchanged. The only object text change is offset0x5A8,
08000178 -> 08000177, correcting the jump target. No compiler flags changed.

### Exact compiler mechanism

Stock PsyQ .jump2 retains jump UID826 -> label864 BEFORE reload UID867.
Stock .dbr changes this to a fresh label1317 AFTER reload867. Both prior load813
and reload867 have exactly the same pattern:

```
(set (reg:SI 3 v1)
     (zero_extend:SI (mem/s:QI (plus:SI (reg/v:SI 20 s4) (const_int 20)))))
```

GDB on the instrumented diagnostic compiler confirms redundant_insn(reload867,
filled-jump-sequence1254,0) returns prior813, followed by reorg_redirect_jump
(jump826,new-label1308). This is the redundant-target-instruction path in
reorg.c relax_delay_slots() at4122-4143, inlined into dbr_schedule in this build.
The neighboring conditional jump837 returns no redundant prior and is not
redirected. Both positive and negative outcomes are captured in gdb_baseline.txt.

The direct interval spelling instead preserves a QImode load through reorg:

```
(set (reg:QI 3 v1)
     (mem/s:QI (plus:SI (reg/v:SI 20 s4) (const_int 20))))
```

This is stock reload UID868, pattern movqi_internal2. It emits the SAME lbu but
is not RTL-equal to the earlier SI zero-extension. The candidate GDB trace
returns no redundant prior for the filled jump and performs no redirect.
Thus source-level byte comparisons preserve the original edge without adding
a barrier, instruction rewrite, asm, volatile, helper, or invented variable.

Native SYM record1b6d5b identifies AudioElem::type as CHAR at+0x14. SLD keeps the
type interval test on retail line279, separately from the azimuth arm on272.
The candidate changes one expression on that same source statement and preserves
all scopes. SYM does not preserve the exact original operator spelling; this is
an evidence-backed source candidate, not a claim that debug data stored >=/<.

The instrumented compiler defaults to signed char: explicit -funsigned-char is
essential to reproduce the stock PsyQ pattern. Without it the differing LB/LBU
patterns suppress the optimization for the wrong reason. It was used ONLY for
diagnostic call stacks and return values; all PASS/raw proof uses stock PsyQ.

New durable receipts: reorg_receipts.json, candidate.patch, gdb_baseline.txt,
gdb_candidate.txt, reorg_return_trace.gdb, reorg_candidate_trace.gdb and
debug_candidate.py. Stock pre/post RTL dumps are build/p879/rtl_stock.jump2,
rtl_stock.dbr, and rtl_rangecheck.jump2/dbr (regenerable with -dRJd).

## Earlier audit and unsuccessful first probes (historical baseline)

No production source, header, or tool changes retained. The baseline remains
6/6 normalized PASS, with AddCustomObject at 413/413 instructions. Its -g twin
is exact. One genuine branch-target mismatch remains; this is not a checker
false positive and is not fixed by whole-TU no-thread-jumps.

## Raw and relocation proof

All 413 target oracle comment words equal rom/nfs4-f.exe. Linking the untouched
whole TU at its native 0x8007C614 text base with canonical external symbol VAs,
gp=0x8013C54C, native rodata and AudioTrk_g storage leaves exactly **1 mismatch
among 1,004 text words**. Thus the other 1,003 words, including resolved call,
global, and internal-jump relocations, agree with retail. The diagnostic uses
ordinary GNU ld, not emitted-instruction rewriting.

- At 0x8007CBBC retail is `0801F2FC`, targeting 0x8007CBF0.
- Our linked word is `0801F2FD`, targeting 0x8007CBF4 instead.
- Retail re-reads se->type via lbu v1,20(s4) at 0x8007CBF0; our type==3 arm
  bypasses that load and lands on its nop. Branch distances are 13 versus14.
- The 13-byte rodata string at0x80055864 and four-byte AudioTrk_g cell at
  0x8013C754 match raw bytes exactly.

All four whole-TU compiler combinations (2.8.0/2.8.1, default/no-thread-jumps,
each -O2 -G4) emit byte-identical ELF objects: SHA256
46e2cdcd2d4c4fad36382a429b588ecbd60ccfdc74d500a9283b8747885469d1.
This includes every section, symbol and relocation. No flag change is justified.

## Native source evidence and bounded probes

Native function block1beb14: frame200, maskC0FF0000; se=s4, dst=s7, c=s2,
n=s6. The type==3 azimuth statement is retail line272; fresh volume type test
is line279. The present source retains both source accesses but the compiler
bypasses the second on one edge.

| Isolated source probe | Target normalized differences | Branch result |
| --- | ---: | --- |
| Reversed if nesting |12| Different local branch skeleton |
| switch over type |15| Different local skeleton,412 instructions |
| Two independent type guards |8|415 instructions, branch-count mismatch |
| Type2 outer guard |15| Same result as switch |
| Reversed addition operands |0|14 versus13 remains |
| Explicit int condition casts |0|14 versus13 remains |
| Natural volume if/else, eliminating three volume gotos |0|14 versus13 remains |

Every neighbor remained PASS in every probe. None of these experiments entered
the live source. Candidates remain diagnostic evidence under this directory.

GCC2.8.1 reorg.c lines1990 onward, redundant_insn(), searches backward for an
identical non-conflicting pattern and stops at a code label or call. Its
fill_slots_from_thread() code near3540 redirects the edge past a redundant
target instruction. This is the likely mechanism behind the observed skipped
reload; it is independent of the earlier jump-threading flag. A subsequent round
should inspect pre-reorg RTL/control labels and native source expression/type
shape, without inserting volatile/asm/fences or fabricated storage.

## Suspicious max-distance handle access: retail behavior preserved

Raw0x8007C904 exits the loop when s2 is nonzero; raw0x8007C92C then executes
`lw a0,4(s2)` while s2 is zero. No intervening instruction assigns s2; the
Math_Dist3D call preserves this callee-saved register. Native SYM identifies s2
as c. The source c->handle access therefore agrees with retail, despite its
suspicious null-base behavior. Updated M2C independently shows this same access.
The old monolithic IDA body is only `return 0` here and provides no usable
counter-evidence. No intent-based repair was made.

Main audiotrk.cpp and production tools stayed untouched. The unrelated existing
scratchpad/w85/o2.txt edit was preserved. No commits or pushes by this agent.
