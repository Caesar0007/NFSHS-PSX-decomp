# P875 root public-header restoration receipt

Scope: 15 public headers in recon/game/common. No implementation, private type
header, extern header, production build tool, oracle or binary was edited in
this batch. Earlier P869-P874 source work and unrelated edits are preserved.

## Disposition and native evidence

The 177 historical free-function candidates are resolved as **174 corrected EXT
public prototypes and 3 removed native STAT declarations**. All 177 were checked
against their owning native function return record, parameter names/types and
actual definition. Mangled binary names remain unchanged: ordinary C++ source
identifiers now let the compiler emit the original linkage names itself.

| Header | Corrected EXT | Removed STAT | Defining TU gate |
| --- | ---: | ---: | --- |
| physics.h | 22 | 0 | 22/22 PASS |
| newton.h | 18 | 0 | 32/32 PASS |
| replay.h | 16 | 0 | 15/16 PASS |
| object.h | 26 | 0 | 37/37 PASS |
| input.h | 8 | 0 | 8/8 PASS |
| gmesetup.h | 2 | 0 | 2/2 PASS |
| stats.h | 7 | 0 | 7/7 PASS |
| schedule.h | 6 | 0 | 6/6 PASS |
| sim.h | 7 | 1 | 8/8 PASS |
| simqueue.h | 6 | 2 | 8/8 PASS |
| quatern.h | 4 | 0 | 4/4 PASS |
| scene.h | 6 | 0 | 6/6 PASS |
| souffle.h | 10 | 0 | 10/10 PASS |
| track.h | 25 | 0 | 29/29 PASS |
| trgsfx.h | 11 | 0 | 11/11 PASS |

The sum is **205/206 PASS**, not the erroneous 235/236 intermediate hand sum.
The unchanged miss is Replay_StoringControllerData__FG15tControllerData:
188 normalized differences and one branch offset divergence at instruction 1
(219 versus 223). No new miss or branch divergence was introduced.

Ten declarations also required signature restoration:

- Replay_RetreivingControllerData returns tControllerData by value, not void
  (native 329a55, FCN STRUCT size128). The original spelling is retained.
- FindObjInstanceFromSerialNum returns Trk_SimpleInst*, not void* (2d8bc5).
- GetSimObj returns Trk_SimObject*, not void* (2d8c5f).
- Object_GetAnim returns ObjectAnim*, not void* (2d8d87).
- Sched_CreateNewSchedule returns Sched_tSchedule*, not void* (3367f1).
- Souffle_Add returns Souffle_tISouffle*, not void* (358726).
- Sched_AddFunction and Sched_DeleteFunction take Sched_tFunctionPt, the
  existing void (*)(void*) callback type, not an untyped void* argument.
- GetPlaneY takes three const coorddef* arguments.
- KillFile_ReadEntry takes int& for chunkInd and objectInd, not int*.

The three removed public declarations are Sim_ProcessPause (STAT 344ce6),
SimQueue_SetLag (34f36a) and SimQueue_IsBlocking (34f38b). Their definitions remain
static; actual object symbols remain LOCAL. They were not renamed or deleted.

## Real class APIs versus false duplicate declarations

Nine additional non-member declarations incorrectly duplicated real C++ APIs:
six in object.h (four Draw methods and two constructors) and three in track.h
(SaveSurface constructor, Save and RestoreAll). These caused original whole
headers to fail compilation with member/non-member declaration collisions.
The real members are already declared in object_types.h and track_types.h and
implemented in the corresponding CPPs; those declarations and bodies remain.
Each removed encoded spelling is preserved in the frozen snapshot. Separate
native/member/export probes are recorded in the root-member review artifacts.

This is not blanket removal of ABI names. Existing explicit-C destructor bridges,
the nonblocking ___10ObjectAnim declaration, and 14 ordinary Newton prototypes
with pre-existing assembly linkage labels are unchanged and remain review work.

## Reproducible compile and object proof

- All 15 complete current public headers compile. Typed function-pointer
  initializers validate all 174 public contracts without casts that hide type
  disagreement. Their emitted references match all 174 exact native symbols;
  every target is a GLOBAL symbol in its actual defining object.
- Frozen original headers reproduce 13 successful includes emitting **126/126
  wrong double-mangled references** and two failures (object and track) caused
  by the nine duplicate members. Failed headers are not counted as successful
  old-reference probes.
- All 15 complete defining objects have identical fresh pre-edit and post-edit
  SHA-256 values. This preserves code, data, symbol visibility and relocation
  identities/addends, stronger than normalized instruction matching alone.
- No reconstructed function body or SLD statement placement changed in this
  header-only batch. This does not newly prove historical header organization
  or resolve existing local/SLD discrepancies.

Evidence in this directory:

- p875_root_header_plan.json: all177 old declarations, native records, definition
  signatures and independently reconciled parameter/return evidence.
- p875_root_header_snapshots.json: complete frozen pre-edit headers, plus the
  removed member declarations. These are diagnostic data, never build inputs.
- p875_root_header_probe.py before|candidate|current: compile-only probes.
  A review caught and fixed the historical-mode replay bug: before/candidate
  now read frozen snapshots, not live repaired headers. Original compile
  failures were reproduced after that correction.
- p875_root_header_before.json and p875_root_header_current.json: compiler
  outcomes and emitted reference lists. The intermediate candidate report
  intentionally predates duplicate-member removal.
- p875_root_defining_object_receipts.json: all15 before/after object hashes,
  full TU and branch gate output, export/visibility checks.
- p875_root_independent_review_20260906.md: independent native/signature review.
- p875_root_members/README.md and receipt.json: independent 9/9 exact native
  member/constructor references, actual global exports and unchanged object
  hashes. The existing class declarations and private type headers are intact.

The diagnostic scripts do not alter production source or rewrite compiler
output. Generated build/scratch intermediates are not intended for Git.
No commit or push was made for this batch.
