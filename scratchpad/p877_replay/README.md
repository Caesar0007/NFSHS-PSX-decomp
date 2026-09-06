# P877 consistent whole-TU C++ compiler selection

## Retained result

Replay and Night now each compile once with the available retail PsyQ2.8.1 SN
C++ compiler. Their two former PER_FN_CC1PLUS_VER_SPLICE entries are removed;
that compatibility table is empty. No function's compiler output is extracted
or inserted for either module. Per-TU flags remain ReplayG4 and NightG8.

| Owner | Previous strict source-only gate | New strict whole-TU gate | Branch differences |
| --- | --- | --- | --- |
| replay.cpp | 15/16; StoringControllerData188 differences | 16/16 PASS | 0 |
| night.cpp | 18/19; CreateNightTableElement56 differences | 19/19 PASS | 0 |

The previous normal mixed-compiler lane already passed these35 functions.
This is therefore **two source-only PASS recoveries and removal of compiler
output splicing**, not two new normal-board matches. Crucially, each entire
new production object equals its freshly rebuilt historical mixed object:

- Replay: ef13e273eff6b799c58a324040fc37b3cce9c3940f74c5bd66d516db072fbf39.
- Night: b818c9cff41a8dfb429466fc1dd62719ef38541900ddc888cc77618651071dab.

Identity includes instructions, data, all relocation names/addends, symbol
records and metadata at the same real source path. No byte normalization is
used for this equality. The replay/night source bodies are unchanged.

The selected retail compiler and the existing CI toolchain.zip member
toolchain/psyq/CC1PLPSX44.EXE both hash to
70319c94de27924f5720af361afd2aa7e6de051a7718e0c1a7f07b57fa92109c.
This proves a consistent byte-exact whole-TU compiler configuration; it does
not claim that the exact historical command line is uniquely recoverable.

## Implementation and safeguards

tools/build.py gains the cc1plus_ver per-TU input and cpp_compiler(src), shared
with tools/diffsrc.py. The selected compiler is resolved before compilation.
An unavailable explicitly selected compiler fails clearly rather than silently
falling back to a nonmatching one. Default selection for all182 other recon
C++ sources is unchanged; the184-source selection test checks this explicitly.
An AST comparison to the backup verifies that no other per-TU flag changed.

The original tools are preserved as build.py.before and diffsrc.py.before in
this directory. Changes are commented. No production verifier normalization,
instruction movement, branch retargeting, asm fence or volatile workaround
was added. Existing unrelated C-library/compiler mechanisms were not altered.

test_compiler_selection.py checks:

- all184 actual C++ source selections and unchanged other-TU settings;
- missing-compiler failure rather than fallback;
- the hash-matching existing CI kit slot;
- an empty C++ per-function compiler-splice table;
- exactly one real cc1plus invocation for each selected TU;
- exact whole-object equality against the old mixed baselines.

Both strict source-only full build lanes passed with no skipped TUs:
--skip-asm and --out expected --no-link, through the P876 full_build.py wrapper.
That wrapper applies verify_asm's source-only policy in diagnostic memory,
leaving production settings and generated instructions untouched.

## Native, raw and SLD evidence

Parent checks confirm Replay16/16 and Night19/19 PASS, branch0 for both.
The StoringControllerData and CreateNightTableElement -g code twins are exact
at243 and113 instructions. Replay_ResetReplay's twin remains exact at86.
The selected compiler is now also used for the whole-TU debug compile; no
different-compiler/fuzzy attribution is substituted for that evidence.

All16 Replay native EXT identities and2252 oracle words were independently
checked against rom/nfs4-f.exe. The independent Night check covers all19 native
EXT identities and1000 raw words. These validate the oracle slices. Full-object
identity separately preserves the existing source references and data layout;
it does not claim unrelated remaining source-level aliases are original.

final_replay_verify.py / final_replay_receipts.json and
compiler_selection_receipts.json contain the parent results. The independent
Night evidence is in ../p877_night/WHOLE_TU_RECEIPT_20260906.md and its JSON.

## Replay pointer investigation: failed forms were not retained

Replay_ResetReplay still contains piVar2. The canonical indexed source supported
by matched NFS2 remains87/86 with a late addiu v0,v0,4 under both retail compilers.
Four pre-biased pointer/index forms likewise leave that one difference. Four
byte/integer-address forms regress to10 differences at88/86, and the plain
array-object-address cast is still1 difference. All are isolated diagnostics,
not reconstructed source; none was retained or used to assert a source floor.

Whole-TU flag hypotheses were also rejected:

| Input option under2.8.0 | Pointer baseline | Canonical indexed source |
| --- | --- | --- |
| Default | 15/16 PASS | 14/16 PASS |
| -mno-split-addresses | 3/16 PASS | 3/16 PASS |
| -fforce-addr | 13/16 PASS | 12/16 PASS |
| -fno-rerun-cse-after-loop | 10/16 PASS | 9/16 PASS |
| Whole retail2.8.1 SN | 16/16 PASS | 15/16 PASS |

GCC loop.c4057/5781/5801 and6137/6153 show reversed-loop initialization feeding
expand_mult_add. extracted3/gcc-2.8.1/expmed.c3819-3825 wraps symbolic RTL in an
RTL_EXPR without TREE_CONSTANT; expr.c6163-6206 requires that flag for early
symbol-plus-constant folding. This is consistent with the observed late bias,
but a full retail-compiler RTL trace of add_val remains a useful next step.
Subtraction and the tested pre-anchors do not provide an escape. No original
pointer name or new macro spelling was invented from this finite experiment.

identity_probe.py freezes the pre-P877 default settings instead of inheriting
the newly selected whole-TU compiler when replaying historical tests. Its JSON
files retain complete16-function results and branch maps. Generated compiler
intermediates under build are not source deliverables.

The CopSpeak iVar3 removal is a separate source-body improvement in
../p877_copspeak/README.md. The full original-source/SYM/SLD goal remains open.
No commit or push was made in this round.
