# P879-P883 source/data checkpoint (2026-09-07)

This checkpoint continues original-source/SYM/SLD restoration; it does not
claim full source recovery, an overlap-free final link, or a byte-exact image.
No post-compile instruction rewriting was introduced. Remaining source-only
carriers, uncertain original inline spellings, and misplaced data stay open
in the root SYM backlog.

## Source restoration

P879-P882 restored the real function-local static `lasttick`, corrected
recorded local scope, removed unnecessary array-shaped aliases of scalar
globals and their dependent caller locals, restored the signed bank access
contract, and repaired a branch-target mismatch in AudioTrk. AU/USA startup
uses ordinary `new Speaker`; AU LoadPerps also regains its actual condition
and regional filename. Earlier round receipts distinguish genuine native
names from still-inferred helper names; no new invented identifiers are
presented as original source names.

P883 removes `MEMCARDFRONTENDISINITTED_words[]` from front.cpp. Its three stores
now use the existing native BOOL/bool scalar directly. All 43 functions,
branches and the entire 39,004-byte object are unchanged. Both affected debug
twins and all 69 raw oracle words are checked in ../p883_front/receipts.json.

## Eight source-owned data windows

The registry in tools/source_data_owners.py admits a source section only after
checking its complete native payload, size, initialization and lack of data
relocations. Recon excludes its separate raw copy; src retains the original
bytes. The credits owner additionally requires its actual global and local
static symbols, not an invented public alias for local storage.

P882 corrected section accounting: selecting a TU's .data does not select its
.sdata. All 324 real GP16 overflows disappeared. Five independently anchored
source .sdata windows restored 234 native targets without regressing a correct
target. This left 1,462 wrong-but-in-range targets, explicitly not waived.

P883 selects CTYPE0's canonical mutable .data, replacing its stale .rodata
selector. _ctype_[129] is at 801371D0, followed by three linker-alignment bytes
and the existing twelve-byte gap; the typed asintbl section resumes at 80137260. The native
ordered main .data run ends at 8013C54C again, rather than 132 bytes too early.
Only CTYPE's raw copy was split out; other r18 legacy data was not removed.
Three isolated links match all 1,632 bytes across the seam, including neighbors.
The full diagnostic link still binds public asintbl to its pre-existing raw
duplicate, not the correctly placed typed section. That separate ownership
debt is recorded explicitly and is not claimed fixed by this checkpoint.

FETextRender's existing 88-byte .data is placed at 800515B8: textDefinitions is
CHAR[14][6], and gSemiTransText is BOOL at +84. All source/object/raw bytes agree.
The generator does not consume the historical frontend fragment, so this owner
uses an explicit output section (registry index 7), like credits (index 0).
The active main-data CTYPE and five .sdata owners use real fragment selectors.

## Reproducing current checks

From the repo root, with the project's local toolchain and original ROM:

1. Run scratchpad/p876_ai_bridges/full_build.py with --skip-asm, then
   --out expected --no-link, then --no-link. The last run restores populated
   build/src oracle objects required by the both-lane relink check.
2. Run tools/gen_ld.py --check-nfs4ld, then tools/gen_ld.py --link.
3. Run scratchpad/p883_data_layout/verify_production.py. It verifies all eight
   actual owner sections, native positions, padding, exclusions and the 34
   retained Hud pointer-table aliases. It records output overlaps explicitly.
4. Run scratchpad/p883_data_layout/verify_checkpoint_sources.py, then
   tools/relink.py --lane both, tools/audit_vtable_indexing.py, and
   tools/textmoves_audit.py. The source script enables NFS4_SOURCE_ONLY=1 and
   requires exact whole-TU counts and zero branch discrepancies.
5. For the exhaustive GP comparison, run scratchpad/p882_gprel/audit.py and
   compare_current.py with a fresh tag. The frozen baseline fixture includes
   independently proved native expectations for all 2,381 relocations.

full_validation_receipts.json is a historical execution record, not a claim
that every archived comparison can run from a clean clone. In particular the
P881 before/after local-static comparison used an uncommitted baseline object;
current owner and source gates above do not require that old binary cache.
No build outputs, ROMs, copyrighted compiler binaries or unrelated scratch
experiments belong in this checkpoint.

## Final verification

All three full builds passed without failed/skipped TUs; all 518 live source
objects reproduced byte-for-byte. All 358 functions across the twelve changed
base TUs pass detailed source-only gates and branch checks. AU 3/3 and USA 1/1,
the AudioTrk 1,004-word raw proof, credits static/reference proof, vtable audit,
source policy and both-lane standing relink checks also pass. The CI-style
objdiff report generated successfully (build output intentionally uncommitted).

All eight native data owners pass. Known blob duplicates are 909 (down from
912 before P883), with zero REAL duplicates, phantoms and referenced unresolveds.
All 2,381 GP relocations resolve and fit, with zero encoding discrepancies or
regressed native targets. The 1,462 wrong-but-in-range targets remain open.
The main .data overrun is now 28,348 bytes, 88 fewer; 119 allocated output
overlap pairs and the unregistered asintbl legacy binding remain explicit debt.

The first new-validator attempt misparsed a linker filename wildcard as a
comment; the corrected lexer preserves it. A later neighbor assertion exposed
the pre-existing asintbl raw binding, now documented separately from the exact
typed section. All current owner checks and the remainder of the regression
sequence were rerun successfully. No production instructions were modified
to address either finding.

The user approved publication to origin/main. The exact commit is available
in Git history; unrelated w85/o2.txt and line-ending-only edits are excluded.
