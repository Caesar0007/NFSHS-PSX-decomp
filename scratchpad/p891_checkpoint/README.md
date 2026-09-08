# P891 source-interface and SLD checkpoint — 2026-09-07

Retained source work is limited to the complete ScreenTracks and FeMenuOptions
private-header graphs: eight files, six actual base/AU/USA consumers. No new
source name, helper, asm, volatile, flag or instruction rewrite was introduced.
The separate Fedialog experiment was rejected and fully restored.

## Retained progress

- ScreenTracks now uses scalar ticks at18 reads. SetBrightness uses its three
  native fields directly, in native statement order, instead of the reconstructed
  helper call. The debug body now exposes only native this/bright, not the
  prior extra inline receiver/current/start records. Native SLD partition
  distance improves9->5 (2splits/7merges ->4splits/1merge); no new merge pair.
  The remaining ticks-load/store attribution and native scope gaps stay open.
- FeMenuOptions now uses scalar ticks at three direct reads and passes &ticks
  at three existing pointer-helper calls. The unsupported inline_fn/arg0 helper
  could not be removed by the measured forms and remains explicitly open.
  Its pre/post85,108-byte debug ELF is identical: all151 source/instruction
  assignments and8,487 pair classifications are unchanged. This improves the
  declaration interface without silently worsening SLD fidelity.

These scalar interfaces agree with the existing four-byte owner and NFS2 INT
corroboration. Native NFS4 record019199 is untyped; neither that record nor
one four-byte cell uniquely proves every detail of the original NFS4 access
declaration, macro, or qualifier. No whole-source-exact claim follows.

## Local/regional proof

All six complete normal objects are byte-identical before/after. BaseScreenTracks
10/10 and FeMenuOptions92/92 PASS with zero branch divergences. AU's existing
ScreenTracks Initialize2diffs and four FeMenuOptions2/4/4/2 misses are preserved,
not counted as repaired or new regressions. USA's selected manifest checks pass.

ScreenTracks verifies39 raw ticks-reference words plus complete SetBrightness
12-word bodies in all three images (36words; overlapping those references).
FeMenuOptions verifies453 complete affected function words across three images,
including12 ticks-reference words. Regional VA maps and original EXEs are used
independently of the limited CHANGED-manifest gates.

ScreenTracks startTicks remains because direct removal, although byte-exact,
introduced six new native-line merges; field staging retained an extra store.
No new name substitutes for it. FeMenuOptions direct helper removal lost a
retail copy and remained5 or15diffs; those probes were restored.

## Rejected dialog work and new compiler evidence

Scalar ticks in Fedialog preserved31/32 base functions but left9diffs at
360/359 in CalculateDimensions__11tDialogHelp, reproduced regionally. Value-
parameter, compound-addition, scoped-body and equivalent-address trials did
not remove it. All five source/header files now equal the original backups
byte-for-byte, and base32/32 plus all regional baseline gates are restored.

Actual CC1PLPSX RTL tracing identifies the change: the tick load loses its
MEM_IN_STRUCT flag. Two scheduler anti-dependencies to width/height stores
disappear, changing scheduling before register allocation and leaving the
extra load-delay nop. This is a bounded cause, not a matching floor or proof
of a particular original array, macro, helper, or qualifier. The next source
investigation must account for that alias/dependency behavior without inventing
an original declaration or rewriting compiler output.

## Final coordinated checks

- Three full build lanes complete without skipped/failed TUs.
- All518 source objects reproduce the accepted P887 hashes exactly.
- 537/537 protected functions across26baseTUs PASS; branch divergences0.
- All26 source receipt hashes equal the final worktree files; drift0.
- Linked diagnostic ELF is byte-identical to P887; all prior native-reference
  fixes and the prior unresolved layout debt are preserved.
- Vtable/source-policy checks and both standing relink policy lanes pass.
- CI-style objdiff report generation succeeds: build/p891_report.binpb.
- User scratchpad/w85/o2.txt remains unchanged at
  d433425b806fc8abd1fa60c9f72a09f4c022bfd64a7fecf4df496931169e9546.

Strict frontend/common counts remain780declaration-clean,0missing,48extra,
9type/9storage findings,3mapping reviews and438source-only carriers. This round's
native statement/debug improvement is not a declaration-count change.

The diagnostic still has851 legacy blob duplicates,1433 wrong-but-in-range
GP targets and existing overlaps. These gates are not a clean final-image
link or a complete original-source/SLD seal. The full goal remains active.

## Reproduction/evidence

full_validation.py and full_validation_receipts.json contain the complete
coordinated commands; final_receipts.json, checkpoint_source_receipts.json,
frontend_strict.md and link_identity.json contain the final state.

Per-scope artifacts: ../p891_screentracks/README.md;
../p891_femenuoptions/README.md and SLD_BEFORE_AFTER.md;
../p891_fedialog/README.md and restoration_receipts.json;
../p891_fedialog_compiler for the independent compiler trace.

No staging, commit or push is performed. Earlier source changes and historical
receipts are preserved; the current changes remain uncommitted.
