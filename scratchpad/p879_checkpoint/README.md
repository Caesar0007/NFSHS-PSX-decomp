# P879 source-restoration results (uncommitted)

Starting published checkpoint: 88bad579 on main. This round does not authorize
another commit or push. Unrelated scratchpad/w85/o2.txt and line-ending-only
worktree changes are preserved. Compiler intermediates remain diagnostic files.

## Production improvements

- AudioTrk_AddCustomObject: fixed the real jump-target mismatch with an ordinary
  byte interval expression. Root's native-address link verifies all 1,004 text
  words plus 17 data bytes against retail. The whole TU remains 6/6 PASS;
  branch discrepancies fall from one to zero, with target exact-g 413/413.
- Femenudefs: removed eight source-only carrier mappings (nine declarations),
  including the username volatile read and the two-player dialog alias. Two
  tournament callbacks now place native amount in the evidenced nested scope
  using success-first control flow. All 66 functions and all branch checks
  pass; the complete normal object remains byte-identical to P878.
- CopSpeak: bank-only signed-field semantics remove Flush's request pointer and
  signed address cast. Native int i is the only generated local, with native
  register and machine scope. Whole TU 27/27 PASS, branch-clean, object unchanged.
- AU/USA nfs3 startup copies: ordinary new Speaker uses the already-restored
  shared interface and removes their obsolete undeclared aliases and p locals.
  Both compile; the startup's 25 words and every relocation target are checked
  against each region's raw EXE. Regional qualifications are recorded separately.
- AU LoadPerps: restored the shared trafficDensity condition (12 differences
  -> PASS 172/172) and the raw-proven AU fecarsb.car literal. AU now has 3/3
  regional gates and USA 1/1; all 172 LoadPerps instruction/reference fields
  and all 71 AU rodata bytes pass independent production raw checks.

No new production identifier, asm, volatile, compiler flag, or post-compilation
instruction rewrite belongs to these edits. Existing inferred private helper
names and unrecovered inline/scope information remain explicitly qualified.

## Completed base verification

validation_receipts.json contains all commands, return codes and full output:

1. Complete strict source-only build with --skip-asm: no failed/skipped TUs.
2. Complete expected build with --out expected --no-link: no failures/skips.
3. Complete assembly-inclusive build with --no-link: no failures/skips.
4. Both standing relink lanes: zero REAL duplicates, hidden phantoms and
   relocation-referenced unresolved symbols. The recon lane retains 964 known
   blob-class duplicates; this is a green standing gate, not a claim that the
   final executable link is globally duplicate-free or fully source-restored.
5. Vtable-indexing audit and source-only policy audit PASS.
6. Eight frontend detailed gates/exact-g twins, 66/66 whole TU, branch-clean;
   all 597 target oracle-comment words independently equal raw EXE bytes.
7. Production AudioTrk ordinary link, full module raw comparison and gates.
8. CopSpeak 27/27, branch-clean and Flush exact-g.

The initial relink attempt correctly refused the empty build/src objects left
by --skip-asm. expected/src was populated but is not the link tool's input.
The assembly-inclusive third build populates the actual required lane; the
same unchanged anti-vacuity check then passes. The refusal is retained in
initial_validation_receipts.json, not discarded or counted as a successful gate.

The separate 79-owner cohort sweep is in
../root_sym_audit/p879_final_common_psx_validation_20260906.json: **1,301/1,301
normalized PASS, 79/79 identical accepted-object rebuilds, and 79/79 clean
branch checks**. Unlike P878, no inherited AudioTrk branch discrepancy remains.
The reused validator's historical round field says P875; its filename, fresh
command outputs and accepted/rebuilt hashes identify this P879 run.

The signed-bank dependency census covers 47 actual consumers. All 40 base
objects are full-file identical (119/119 real code functions, plus 36
data/no-covered-code TUs); five initially buildable regional consumers retain
21/21 selected matches and identical program/data/relocation fingerprints.
The two original regional compile failures are preserved as unavailable
before/after bank-only evidence, not vacuous identity results. Their later
source repair has its own production gate/raw receipts.

## Fidelity still open

Strict source-only carriers are frontend 470 -> 462 and game/common 479 -> 478.
These are nine common-cluster mapping removals, plus two separately removed
regional startup mappings. Remaining declaration-clean/review counts and the
source-only data-layout queue are not hidden by these reductions.

The nested monetary helper's original name/body shell is not recovered, and
selectedTourney still splits native tourn's value/register role. Username's
existing private inline names remain inferred. Flush's signed access contract
is proved but native CHAR does not distinguish the exact original keyword or
compiler flag; complete original SLD statement spelling is still unproved.
The pre-existing whole-debug frontend constructor discrepancy is unchanged.

Full original-source/SYM/SLD completion remains unproved. The active backlog is
../root_sym_audit/ORIGINAL_SOURCE_NAME_BACKLOG_20260903.md, not just a PASS board.
Dedicated receipts live in ../p879_femenudefs, ../p879_username, ../p879_amount,
../p879_copspeak, ../p879_audiotrk and ../p879_nfs3_regions.

The original regional startup compile failures and AU's intermediate 12-diff
LoadPerps result remain preserved in the earlier receipts. Final production
regional evidence is ../p879_nfs3_regions/production_receipts.json; it requires
actual zero-failure AU/USA gate outputs. It does not certify missing USA
LoadingIcon/main oracles or whole-regional-data placement beyond checked data.
The failed single-tourn controls and stock CSE diagnosis for the next round
are in ../p879_tourn/RECEIPT_20260906.md. No losing candidate was retained.
