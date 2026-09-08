# P889 source-restoration checkpoint — 2026-09-07

Four unsupported base-function locals have been removed without a replacement
name or a matching regression. Including AU/USA copies, twelve source-local
instances and twenty-one false ticks-array accesses are gone across six TUs.
The two scalar extern declarations now agree with the existing ticks owner.
No executable asm, volatile, codegen fence, compiler flag or postcompile rewrite
was added. CDROM's existing data-storage assembly was not changed in P889.

## Completed verification

- All three full builds completed with no failed or skipped TUs.
- 518/518 source objects reproduce the accepted P887 hashes byte-for-byte.
- 527/527 protected functions across 25 base TUs PASS, with no branch-count
  or branch-offset divergence. This is a scoped regression set, not a claim
  that the whole project has 527 functions or that all functions are restored.
- FEScreen's three whole objects are byte-identical. Femenuextended's base
  object is byte-identical; AU/USA preserve complete code/data/symbol/relocation
  fingerprints while temporary file-name metadata changes.
- All six selected regional manifest checks remain PASS. The changed
  transitions not covered by those manifests have separate raw/reference proofs.
- All 42 ticks relocation words in the six changed consumers match retail.
  FEScreen independently proves all 51 words of its six changed method bodies.
- The linked diagnostic ELF is identical to P887, SHA256
  74d77a4af62d7c63ca711bce57bf7850664b7b2b63562eff0b7186156ddfa86c.
  This preserves earlier native-reference proofs and earlier unresolved debt.
- Vtable indexing and source-policy checks pass. Both relink policy lanes
  retain their prior counts; no real duplicates, phantoms or referenced
  unresolved symbols were introduced.
- CI-style objdiff report generation completed successfully from the rebuilt
  build/expected objects: build/p889_report.binpb (generated, not source).

Full commands/results: full_validation_receipts.json. Object/function totals:
final_receipts.json and checkpoint_source_receipts.json. Actual linked-byte
and relink-count comparison: link_identity.json, reproduced by link_identity.py.

## Strict source coverage and remaining fidelity work

Fresh frontend/common report: 781 declaration-clean mapped functions,
0 missing SYM names, 46 extra names, 9 type findings, 9 storage findings,
3 mapping-review functions. Source-only codegen carriers decrease **446 to442**.
The unchanged extra-name count is a different category, not evidence that the
four carrier removals did nothing. Full report: frontend_strict.md.

The changed methods are not advertised as fully SLD-exact. FEScreen's emitted
line groups split native fade/ticks lines622/630; Femenuextended TransitionOff
groups a hoisted read and store spanning native856/858. TransitionOn still has
an iterator/source-scope question. The source comments and explicit per-family
SLD receipts retain those active issues; no generic exemption closes them.

The broader link still has851 legacy blob duplicates,1433 wrong-but-in-range
native GP targets, and the existing output overlaps. A byte-identical
permissive diagnostic is not a clean runnable final image. The main objective
remains incomplete and active.

## Evidence routes

- ../p889_ticks/README.md and SLD_RECEIPT.md: native zero-local FEScreen cleanup.
- ../p889_femenuextended/README.md and receipts.json: scalar ticks, removed
  iVar1/enterTicks, whole-consumer and native-reference proof.
- ../p889_cdrom_storage/README.md: the warning is caused by the active old
  compiler's hardcoded named-section @progbits output. Ordinary C COMMON
  allocation through the actual PsyQ linker is the next evidence-backed probe;
  the warning-dependent section-attribute candidate remains scratch-only.
- ../p887_checkpoint/README.md: the earlier completed native BSS/data checkpoint,
  now consolidated without overwriting its historical receipts.

User scratchpad/w85/o2.txt remains unchanged at
d433425b806fc8abd1fa60c9f72a09f4c022bfd64a7fecf4df496931169e9546.
The index remains empty; no commit or push is performed by this round.
