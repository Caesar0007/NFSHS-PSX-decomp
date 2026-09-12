# P900 AddCustomObject: native scope and statement recovery

2026-09-12. Source-only recovery from SYM/SLD, raw nfs4-f.exe, and the
independent split M2C/Ghidra bodies. No assembly/volatile device, new helper,
qualifier, invented name, production-tool change, or output rewriting.

## Accepted result

- AudioTrk_AddCustomObject: 413 instructions PASS. All 40 reference words
  independently resolved in verifier memory agree with the raw executable;
  all 373 remaining words are unchanged, for 1652 exact bytes.
- SLD partition conflicts: **1 merge / 174 splits -> 0/0**.
- All **31 native blocks** now match in ordered start/end/depth and complete
  declaration ownership/type/tag/size. All **18 native local owners** are
  exact, versus 6 before; parameter records remain unchanged.
- Seven unsupported reconstruction labels removed, including six previously
  emitted SCL6 records. No label renaming or debug-record substitution.
- All six TU functions remain PASS, all 159 branches exact, and the complete
  normal object is literally identical in the same-path isolated comparison.
- All five neighbors' source-line groups, declarations and scopes unchanged
  in this isolated proposal. The root separately integrates the independently
  validated SoundTrack and lifecycle proposals.

`final_receipt.json` is the checked proposal proof; `candidate_inspection.json`
contains every native block, source-line group and local owner. The production
combined result is independently verified in ../p900_audio_landed_20260912.
The campaign regression is in ../p900_checkpoint. No original token spelling
or entire-project completion is inferred from these exact recovered records.

## Evidence-driven source changes

1. Early null-global return, compound rejection condition, and initialization
   of the existing `c` after rejection. The compiler schedules that initializer
   into the second condition's delay slot exactly as retail. No comma-condition
   workaround is needed.
2. Structured channel selection plus positive delay guard and scoped `for`
   preserve the free-slot selection's existing n-first address expression.
   The W85 receipt remains load-bearing; no identity fence is restored.
3. Move maxind/maxdst, both loop i declarations, chkdst, cleanup's shadow c,
   and repeatnow to their native lexical owners. Use the existing native
   for-loop and single compound SNDover/max-distance test statement.
4. Enter the repeat/audio body only when c is non-null. Express the special
   type-1 handling as the positive availability guard with its early-return
   alternative, recovering the two missing slicePos parent scopes.
5. Restore the near/fade volume if/else, retaining P879's two explicit byte
   bounds so the type-3 edge still reaches the native reload at 8007CBF0.
6. Restore the **meaning** of ambdist: native SLD292 computes the unshifted
   difference; native293 applies >>2 to each fixedmult argument. Its old
   initializer prematurely shifted the named source value. Moving that shift
   to the consumer yields 0/0 without changing a single compiled word.

The suspicious existing c->handle read inside the c==0 reclaim loop is real:
8007C92C is lw a0,4(s2), and both independent decompilers show the same access.
This round preserves shipped behavior rather than silently correcting it.

## Frozen path / falsification ledger

| Stage | Instructions / diff | SLD merges/splits | Exact local owners |
|---|---:|---:|---:|
| before |413 / PASS|1/174|6/18|
| structured |413 / 4|1/128|11/18|
| structured_joins |414 / 3|not scored across changed size|not claimed|
| positive_gate |414 / 3|not scored across changed size|not claimed|
| native_c_init |414 / 5|not scored across changed size|not claimed|
| post_guard_init |413 / PASS|1/62|17/18|
| slice_scope |413 / PASS|1/62|18/18|
| loop_groups |413 / PASS|1/25|18/18|
| ambdist_consumer |413 / PASS|0/0|18/18|
| candidate |413 / PASS|0/0|18/18|

The first structured probe placed c=0 too early (wrong delay slot). A comma
inside the compound condition introduced an XOR; predicate negation did not
remove it. Initializing c at declaration added an instruction. The paired
post-rejection initializer fixed this naturally. Temporary failed forms are
preserved here only; production receives the final byte-identical source.

Diagnostic corrections remain explicit: the initial native-block expectation
was 29; the full native parse contains 31. The local reader initially omitted
tagged struct records; after fixing that reader the baseline is 6/18, not 5/18.
The 414-word failed probes are not valid aligned SLD comparisons. No failure
was erased or treated as a proof of impossibility.

The last ambdist residual was initially questioned as a possible assembler
NOP attribution issue. Independent inspection rejected that hypothesis:
8007CCC0 is the real sra a0,a0,2, not a NOP. The source-level correction above
resolves it. The separate SoundTrack NOP-attribution findings are not used as
an exemption here or there. See ../p900_soundtrack_sld/addcustom_nop_receipt.json.

## Hashes and limits

P899 actual input source:
7fff98cd7b07e474d4e75d92e78fa7ed1125a67f97f2e8a658aee8bc402f3dda.
Isolated AddCustom candidate source:
64fb3714400fb17e88b549eb26870c44240c1196ea07a1485078c9db845f4377.
Raw target SHA256:
21d506c914a4bd4cffb8ebf96666e1c9a370e4352c1dba22b73dabc14ce1acf6.

Native sources: C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt,
records1bec2b..1befec, VA8007C750..8007CDC4; split M2C
C:/Temp/nfs4-clean/Binaries/NFS4-B-USA/c/func_8007C750.c; Ghidra
C:/Temp/nfs4-psx/nfs4-psx-Ghidra/functions/FUN_8007c750.c.

GAS -L retains existing debug anchors only. Compiler assembly hashes and
all instruction/data payloads are checked unchanged; no markers are injected,
renamed or moved. Scope equality does not prove original physical line counts,
whitespace, macro tokens, or compiler-erased declarations. Full goal stays open.
