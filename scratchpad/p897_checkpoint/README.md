# P897: verified native AI/audio source contracts

Completed local checkpoint, 2026-09-09. **831/831 protected functions across
35 base translation units PASS**, with zero branch divergence. This is a
regression set, not a whole-game matching percentage. The original-source,
SYM, SLD and final-image goal remains incomplete.

## Restored source

AIPhysic, AIState and AudioTrk now use the native `BWorldSm_slices` pointer and
`Trk_NewSlice` members, retiring three invented asm aliases and offset views.
The owner-derived 32-byte type is confined to each private extern boundary.
Original foreign-header visibility is not claimed recovered. Existing signed
byte casts, whole-coordinate copies, local names and control flow are preserved.

- AIPhysic: 42/42 PASS; all 42 local/line/scope-marker contracts preserved;
  18 raw reference words exact; 27 actual-header layout assertions pass.
- AIState: 52/52 base PASS; both available USA oracles PASS. All 52 USA
  bodies and storage/symbol/relocation contracts preserve the coherent
  historical-header baseline. Eleven stale USA SimGlobal/GameSetup accesses
  are repaired with native fields. All 90 own-image reference words are exact.
- AudioTrk: 6/6 PASS. PreLoad's five `se/i/x/z/d` local owners now match their
  native address spans and lexical depths. All 116 raw instruction words match;
  13 actual-header assertions pass. Two calls now pass `false` to the native
  BOOL `checkonly` parameter, and its prototype uses the native parameter names.

The two USA manifest checks are not counted as 52 regional oracle matches.
Complete object/debug comparisons protect the unmanifested bodies independently.
AIState's regional simGlobal map anchors the `gameTicks` field at +4; subtracting
that explicit delta recovers the actual global base before resolving relocations.

## Honest source-provenance correction

AudioTrk_Reset's existing `se` name is no longer labeled an exact original-name
recovery. Reset's own SYM lists only two `i` locals; the neighboring functions'
same-role name does not prove Reset's source. The code/name stays unchanged,
explicitly open, with no replacement audit exemption. A direct-index trial
failed at 58/56 instructions and 32 differences; it was not retained.

Consequently strict game/common coverage changes from 1228 clean / 6 extra
locals / 33 original-name recoveries to **1227 / 7 / 32**. This exposes an
unjustified claim; it is not a code or matching regression. Game/common retains
478 source-only carriers, 28 type findings, 28 storage findings and zero mapping
review items. Frontend/common remains 780 clean / 48 extra / 438 carriers,
9 type findings, 9 storage findings and 3 mapping review items. Neither cluster
has missing mapped SYM local names, but that does not establish full restoration.

PreLoad still lacks the original CAudioList accessor identity, implicit `this`
record and two empty inline blocks. Its existing SLD partitions are preserved,
not declared exact. AIPhysic_GetDesiredVector's `checkSide` scope and the broader
name/type/SLD queue remain open. No invented getter, new local, asm, volatile,
compiler flag or instruction rewrite was introduced by P897.

## Full local regression

All three full build lanes completed without failed/skipped TUs. All **518
ordinary source objects are literally identical to P896**. The entire linked
ELF and link map are identical too, preserving every previously verified native
data binding and GP/reference result. The actual-source checks are tied to
source/header hashes, not merely staged candidates.

Linked ELF SHA256:
`52800553415581618c04766bca85e3d943de8343f60b78c62ff7c62af9e32ae0`.

Vtable and source-policy audits, both relink policy lanes and CI-style report
generation pass. Report SHA256:
`2f64da5ebcadf1b920d8668e8a02ffed87abf40a1621fd45bfa97b3805ab19c3`.

This preserves, rather than resolves, P896's remaining layout debt: 848 known
blob duplicates, 133 output-overlap pairs, 1428 confirmed wrong native GP
targets and 3 native-unknown targets. No real duplicate, phantom or referenced
unresolved symbol is added. A permissive diagnostic link is not a final native
image. The owner registry still has 19 initialized and 4 zero-storage owners.

`CDROM.c` has one existing file-scope `__asm__` block containing only BSS
storage directives, not executable instructions. Its 72-byte reservation is
verified, but replacing that storage bridge with recovered ordinary C remains
an explicit source-restoration item.

## Receipts and publication boundary

`final_receipts.json`, `object_receipts.json`, `source_receipts.json`, strict
reports and build/relink receipts record this local checkpoint. Actual-source
details are in the P897 AIPhysic, AIState and AudioTrk directories. Older
checkpoint receipts remain historical; compact published receipts are not
standalone test harnesses without their local binary fixtures and scratch
dependencies.

The user approved a selective commit and push after validation. At this local
checkpoint the fetched upstream is three speech-library commits ahead, ending
at `7728c5ea`; integration and its own revalidation are recorded separately in
`INTEGRATION.md` before publication. No force push or discarded upstream work
is authorized. The unrelated `scratchpad/w85/o2.txt`, status-only changes and
uncurated build/scratch artifacts are excluded from the commit.
