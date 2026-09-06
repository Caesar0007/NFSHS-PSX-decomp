# P879: remove frontend aliases without sacrificing matching

Production owner: recon/frontend/common/femenudefs.cpp. The starting checkpoint
is 88bad579. This round remains uncommitted; unrelated worktree edits are not
part of it. No production tool or shared header is changed by this component.

## Restored expressions

| Callback | Removed source-only declarations | Target instructions |
| --- | --- | ---: |
| GoToTwoPlayerSingleRace | both menuDefinitions declarations and dialog | 69 |
| EnterUserName | player and defs, plus the volatile byte read | 25 |
| FinishedPlayer1GetName | defs | 68 |
| FinishedPlayer2GetName | defs | 40 |
| AwardPinkSlipsCar | menuDefsBase | 138 |
| ExitPinkSlipsEarly | menuDefsBase | 76 |

All callback names have the MenuExtended_ prefix. This removes nine actual
local declarations, represented by eight former carrier mappings. The direct
uses name the already-restored scalar menuDefs global; no replacement local,
fabricated semantic identifier, new helper, asm, or volatile is introduced.

Two additional callbacks, GoToTournTrackInfo and GoToSpecialEventTrackInfo,
restore the native amount declaration to a nested post-sound debit block and
use a success-first Run if/else. This retains a real native name rather than
deleting it or inventing a replacement. ../p879_amount/RECEIPT_20260906.md
records native LONG/REG3, the recovered collapsed cancellation-PC placement,
all 724 linked callback bytes, and the still-unresolved inner inline-body shell.

EnterUserName passes FEApp->fInputPlayer directly to the existing inline call,
alongside frontEnd.playerNameList[FEApp->fInputPlayer]. Keeping the caller
temporary but removing only volatile was not sufficient. Removing both gives
the two native byte loads with ordinary C++ evaluation. CurrentPlayer() reads
a different field and is not an equivalent substitute.

## Verification and its limits

verify.py freshly runs detailed verify_asm for all eight callbacks, the entire
66-function TU gate, the full branch-distance check, and eight exact-g code
twins. The complete normal object remains byte-identical to P878:

    e5f8a1f116f2e9aeecfbf0d2d96c5e4e6a6164caea5ef588aec3690449580fd0

This preserves all neighbor instructions, branch encodings, data, symbols and
relocation records/addends, beyond the normalized function gate. All 597 oracle
comment words for these callbacks were checked against rom/nfs4-f.exe. That
check establishes the oracle's raw provenance; it is not misrepresented as a
new full-link comparison of all 597 source-generated words.

The separate ../p879_username/RECEIPT_20260906.md does include an ordinary native
address link of EnterUserName: all 100 bytes agree with the raw executable.
Its five native command/inline-this/data/m records retain type, home and lexical
nesting; no player record remains. Its source-line instruction grouping remains
21/2/2. Absolute original source line values and the existing inferred inline
method spellings are not claimed recovered. Other callbacks' exact-g results
prove code-equivalent debug twins, not complete native declaration/SLD equality.
The pre-existing whole-debug-TU menu-constructor discrepancy remains 3205/3207;
the normal lane is 66/66 PASS, not a claim of 66/66 debug-lane PASS.

Frontend strict report frontend_common_strict_p879_20260906.md shows carriers
470 -> 462, with declaration-clean functions 781, missing names 0, extra locals
46, type findings 9, storage findings 9 and mapping-review functions 3. These
remaining findings are not suppressed or reclassified as completed restoration.

## Further receiver/source-shape probes

probe_shape.py applies pre-compiler-only variants to the current complete TU
without changing production source. Fresh two-player callback results:

| Probe | Instructions | Result |
| --- | --- | --- |
| Current baseline | 69/69 | PASS, entire published object unchanged |
| Direct screenCarSelect receiver | 71/69 | FAIL: late global load and empty slot |
| Direct command.nextMenu expression | 70/69 | FAIL: receiver/base schedule |
| Direct YesNoDialog fields | 69/69 | FAIL: four sp-relative versus receiver-relative stores |
| Remove screenState fence | 69/69 | FAIL: argument constant moves into call slot |
| Literal state instead of temporary/fence | 69/69 | same FAIL |
| Direct receiver plus literal state | 70/69 | FAIL |
| Both direct bases plus literal state | 70/69 | same FAIL |
| Remove one-shot do/while wrapper | 70/69 | FAIL |
| Existing SetString/SetChoices/Run member operations | 69/69 | PASS, whole object unchanged |
| Chain those existing member operations | 69/69 | PASS, but merges native statement groups |

All 65 neighbors remain normalized PASS in those normal-lane probes. None of
the failing variants was installed in production. The separate member-call
form was installed: it removes dialog without new local records, preserves
the native constructor this in REG16, and retains the distinct source groups
for the word lookup (native 225) versus stores/Run (229). The chained form
loses that grouping and was not chosen. These existing private helper names
remain inferred, not newly certified as original source spellings.

The existing screen receiver, nextMenu and screenState carriers and fence
are still open restoration work,
not proof that the original source needed them. The native source lists only
command, YesNoDialog and the nested constructor receiver. SLD lines 235/236
identify the final command store and SetState call; the remaining question is
how the original receiver/argument evaluation allowed the former in the latter's
delay slot without a named caller temporary or fence.

The normal/debug baseline inputs for shape experiments are frozen under
build/p879_femenudefs_shapes/baseline, so later production landings do not
silently change the negative controls. run_shapes.py retains the measured
matrix in shape_receipts.json. The complete pre-P879 production source is
backed up as femenudefs.cpp.before (P878 source; normalized text line endings).

The AudioTrk branch-target repair is tracked separately in ../p879_audiotrk.
The amount scope is improved, but complete native inline/SLD fidelity for the
tournament callbacks remains open as explained in the dedicated receipt.
