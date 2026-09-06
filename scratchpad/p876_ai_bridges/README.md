# P876 native AI class API restoration

Date: 2026-09-06. Production changes are limited to aihigh.h, aistate.h and
19 destructor declarations in recon/nfs4_types.h. No implementation, private
owner type header, oracle, production tool or compiler output was rewritten.

## Result

The 27 declarations left open by P875 are now repaired through the real class
APIs: 26 destructors and AIState_Purgatory::StartUp. The stale non-member
prototypes are removed, not renamed to invented free-function names.

The frozen pre-edit experiment proves two distinct problems:

- All26 encoded destructor prototypes emitted nonexistent double-mangled
  references such as ___11AIHigh_Base__FP11AIHigh_Basei.
- The encoded StartUp declaration emitted the native link name, but made an
  ordinary &AIState_Purgatory::StartUp expression fail with "not a member".
  Removing it restores the already-declared static member. A link-name-only
  check would have missed this source-interface defect.

Removing those27 prototypes alone was insufficient:19 AI destructors were
missing from the monolithic class declarations. Explicit destructor expressions
then inlined implicit destructors or called ancestors, exposing only7 distinct
destructor exports. Their proper declarations are now restored from native
destructor records; no virtual keyword, field, base class or body was added.
The obsolete comments suppressing real destructor declarations were replaced.

Final ordinary C++ caller probes emit **27/27 exact native references**. Every
reference matches an EXT/STAT native function record and an existing GLOBAL
FUNCTION export in the real owner objects. Raw native _._ destructor spellings
are compared with the project's existing ___ assembler adaptation, not new
aliases. Native STAT/vague-linkage ownership questions are not reclassified as
EXT by this work; existing definitions and bindings were untouched.

All26 class sizeof results are unchanged before/after under the actual target
compiler. The source-facing declaration surface is improved; this does not
prove the original public-header organization or restore every inline body.

## Regression evidence

- A compiler -M dependency census checked all184 reconstructed C++ sources:
  zero preprocessing failures,36 transitive nfs4_types.h consumers.
- All36 consumer objects were freshly built before/after and are entirely
  byte-identical, including data/relocation/symbol content. These are data or
  no-covered-function TUs: their0/0 function gates are **not** claimed as36
  matched functions. Whole-object identity is the relevant evidence.
- Both full-build lanes completed with NFS4_STRICT=1, no failed/skipped TUs:
  source-only build --skip-asm, and source-only build --out expected --no-link.
  full_build.py applies the same in-memory source-only policy as verify_asm.py;
  per-TU and permitted vendor compiler identities remain. No production tool
  or post-compiler instruction rewrite was introduced.
- Fresh owning gates: aihigh14/14, aistate52/52 PASS; both branch checks0.
  Replay remains15/16 in the source-only lane, solely its existing188-difference
  StoringControllerData miss and pre-existing branch offset(219 versus223).
- Relink GREEN:757 objects,964 existing blob duplicates,0 real duplicates,
  0 hidden phantoms and0 relocation-referenced unresolved symbols.
- Vtable indexing PASS1029 files; source-only policy and normal diff-check PASS.

## Reproducible artifacts and backup

- nfs4_types.before.h: byte-exact protected-header backup, SHA256
  a3f163760a881f4a5050bb2e350238f5975f47ea9baa0db58eca6a8c35424d97.
- aihigh.before.h / aistate.before.h: original public-header snapshots.
- legacy fixtures point at the frozen shared header. canonical_before.cpp
  reproduces the failed static-member lookup. old_shape.cpp removes false
  declarations but retains the old class shape, demonstrating the19 missing
  destructor declarations. canonical.cpp uses the final production headers.
- verify_api.py and api_receipts.json retain all native records, actual owner
  symbol rows, target-compiler results and26 before/after size constants.
- discover_consumers.py / consumers_before.json: actual compiler dependencies.
- regression.py before|after / regression_before.json / regression_after.json:
  exact36-object hashes and full gate outputs. Preserve the before report when
  running later checks; it represents the pre-edit state, not current Git HEAD.
- check_probe.py compiles isolated scratch probes. full_build.py provides the
  strict source-only full-build invocation used above. Generated .i/.s/.o files
  under build/scratchpad are not reconstructed source deliverables.

## Replay source-only carrier investigation

Replay_ResetReplay still retains piVar2; no invented spelling replaced it.
The native block329ee2 contains only int i in s0. The symbol-bearing NFS2 source
uses ordinary indexed clearing. Eleven source forms were tested: eight leave
only an extra addiu v0,v0,4 (87/86), the postdecrement while has4 differences,
and one-based ascending/descending forms have11/16. All edits were reverted.
The final source was compared to the captured original, and its entire object
again hashes to526b0b18dfe23420a526d33d889e9e0656aae0c4cc569dfdffd0e09d5a4c55a5.
Replay_ResetReplay itself remains PASS86.

GCC loop.c check_dbra_loop and emit_iv_add_mult explain the next question:
reversal and reduced-address initialization introduce the late constant offset;
trace expand_mult_add/address splitting to recover a pointer-free source or
authentic whole-TU compiler setting. These finite failed forms do not prove
that the pointer existed in original source. replay_probe_receipts.json records
the actual tested bodies/results. No new asm, volatile, carrier exemption or
semantic-name invention was retained.

The first ABI-triage worker stopped on a usage-limit error before completing
its review. The parent completed and verified this work locally. No other NFS4
task was messaged. No commit or push was made; the full SYM/SLD goal remains open.
