# P890 original-source/SYM/SLD checkpoint — 2026-09-07

This round improves source declarations and statement structure while keeping
the matched code intact. It does not establish whole-project source restoration.

## Retained source changes

1. FEScreen's six base/AU/USA TransitionOff/On definitions no longer invent the
   unused parameter name arg2. Four owning/shared prototype names are also
   omitted. The tMenu* argument, its exact type, and full ABI arity remain.
   Explicit comments retain the unknown-original-name question; unnamed is not
   claimed to be the original author's spelling. All five files were backed up.
2. Both fade fields now use the natural chain
   fInternalScreenFadeVal = fScreenFadeVal = constant, preserving the original
   short-store-before-int-store order and existing flag-before-ticks order.
   This joins two related initializations without a new name or invented helper.
3. Front's complete base/USA interface uses scalar int ticks and one-argument
   void seedrandom(int), replacing a false array and an ellipsis prototype.
   The failed attempt to remove Front_BuildStream's t temporary was reverted.
   Its USA copy retains its pre-existing volatile read; no new volatile access
   is added or falsely advertised as removed.
4. lang/randomSeed no longer receive generic carrier exemptions in Front.
   Their unchanged code and measurements remain, but they are explicitly open
   source-recovery items: a local matching result does not prove an original
   named local. No replacement names or audit-suppression rules were introduced.

## Verified fidelity progress

FEScreen native SLD split pairs improve from17 to12: Off5->4, On12->8, with
zero new merges. These count pairs of instructions that retail groups together,
not recovered records or a whole-project SLD percentage. Ticks/fade grouping
and native nested empty blocks remain unresolved. All six final debug methods
have only the native named this/type parameters, no named local and frame0/mask0.

The finite eight-case matrix is preserved, including reverse-chain failures.
The raw51-word proof covers the six changed methods across their three real
images, including12 ticks relocation words. Base27/27 and regional3/3 selected
manifest checks remain PASS; the manifests do not themselves cover the changed
transition methods, so the independent raw proof is required.

Front remains43/43 PASS and branch-clean. All nine selected USA manifest cases
remain PASS. Both complete substantive object fingerprints are unchanged.
Ten ticks reference words and two seedrandom calls resolve raw-exact using each
image's own addresses. The direct seed expressions all retain a two-diff
lw-versus-lhu miss at1000/1000; no failed candidate was retained.

## Final coordinated verification

- All three initial full-build lanes completed without skipped/failed TUs.
- After the last fade-chain edit, every final source object was rebuilt again,
  followed by the full final link/source/branch/policy checks. Earlier receipts
  are preserved in before_transition_landing_receipts.json; only the two
  completed earlier build lanes are reused by --resume-final-source.
- 518/518 source objects reproduce their accepted P887 hashes exactly.
- 527/527 protected functions in25baseTUs PASS, with zero branch divergences.
- All25 source receipt hashes were checked against the final worktree: zero drift.
- The linked diagnostic remains byte-identical to P887, SHA256
  74d77a4af62d7c63ca711bce57bf7850664b7b2b63562eff0b7186156ddfa86c.
- Vtable/source-policy checks and both standing relink policy lanes pass.
  CI-style objdiff report generation succeeds: build/p890_report.binpb.
- The user's scratchpad/w85/o2.txt remains unchanged at
  d433425b806fc8abd1fa60c9f72a09f4c022bfd64a7fecf4df496931169e9546.

The identical diagnostic still contains the documented851 legacy blob
duplicates,1433 wrong-but-in-range GP targets and output overlaps. A green
policy gate is not a clean final executable link or a global source-exact seal.

## Strict report: exposing debt is not a code regression

Frontend/common now reports780 declaration-clean functions,0missing names,
48extra names,9type findings,9storage findings and3mapping reviews. The source-
only carrier count is438, down from442. This comprises two base parameter-name
removals plus two existing locals moved into the visible extra-name queue;
it is **not four removed local objects**. The extra count46->48 and clean
count781->780 reflect removed exemptions, not changed executable behavior.

Remaining original names, source scopes, type/ownership questions and exact
SLD partitions stay active. The entire goal remains incomplete.

## Receipts and next evidence

- ../p890_fescreen_params: literal unnamed-parameter patch, backups, complete
  normal/debug object identities, raw code, real Ctags/ABI/arity checks.
- ../p890_transition_shape: finite matrix, final regional objects, exact SLD
  partition/parameter/block maps, and unapplied negative controls.
- ../p890_front: scalar/prototype graph, failed seed-removal experiments,
  current open-name classification, whole objects and raw references.
- ../p890_cdrom_native: actual PsyQ C/assembler/linker experiments. Plain C
  produces the canonical XBSS names/sizes without warnings, but the native
  standalone linker controls do not reproduce retail ordering. The native
  assembler code schedule also differs. These findings do not falsify ordinary
  C or prove a floor; no warning-dependent replacement is landed.

The CDROM audit additionally identifies unnamed MMIO-pointer data present in
canonical objects but absent from their current source objects. Repeated bytes
alone do not uniquely establish their VA. A named pfuncCdReadyCallback cell is
also absent from source declarations; its ownership/type/reference trace is
the next bounded investigation, not permission to guess a type from its name.

All changes remain uncommitted; this round performs no staging, commit or push.
