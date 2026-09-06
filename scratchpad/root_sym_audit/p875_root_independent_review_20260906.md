# P875 root public-header batch: independent review

Reviewed 2026-09-06. Read-only review of production files and existing compiler
artifacts; no compiler/build was rerun, and no source, header, production tool,
oracle, inventory or existing receipt was edited by this reviewer.

## Verdict

The source/API corrections are supported. The plan contains **174 EXT prototype
corrections and 3 STAT removals across 15 public headers**. Independently checked:

- All177 native record identities, addresses, storage classes, return categories
  and structure tags against `C:/Temp/nfs4-clean/nfs4-f-v3.txt`.
- All177 planned definition signatures against current implementation text.
- All174 EXT declarations against their current public headers.
- All272 REGPARM/ARG records against their exact native function blocks, with
  parameter names matching the actual definitions. No record was borrowed from
  an unrelated function.
- All expected EXT symbols are GLOBAL and all three STAT symbols remain LOCAL
  in the actual defining objects, inspected independently with objdump.
- Current typed-reference receipts report all174 exact native linkage names
  and successful compilation of all15 full public headers.

No mismatch was found in those checks. This is API/signature restoration, not
proof of every original header's layout, inclusion history or macro spelling.

## Important contracts

- `Replay_RetreivingControllerData` returns **tControllerData by value**, not
  void and not a pointer. Native EXT `329a55` records STRUCT size128 with tag
  tControllerData. Both public and owner type definitions contain four32-byte
  arrays; the implementation returns that aggregate. The raw oracle saves the
  hidden result-buffer argument from a0 and copies128 bytes to it before return.
  Because return types do not generally appear in the function linkage name,
  this correction required the native return record and typed-reference check.
- `Sched_AddFunction` / `Sched_DeleteFunction` correctly use
  `Sched_tFunctionPt`, a `void (*)(void *)`, rather than void*. Native parameter
  records `336d0e` / `336e28` are PTR FCN VOID, and the native `PFPv_v`
  linkage component confirms its argument contract.
- `GetPlaneY` correctly takes three `const coorddef *` arguments. The PTR STRUCT
  parameter records alone omit constness; native `PC8coorddefN20` linkage and the
  actual source definition supply the additional evidence.
- `KillFile_ReadEntry` correctly uses `int &chunkInd` and `int &objectInd`.
  Native `RiT2` linkage distinguishes these references from the old int* public
  prototypes, while records `36f8e7` / `36f8fd` provide names and underlying type.

## Private functions remain private

| Function | Native STAT record | Current source / object / public header |
| --- | --- | --- |
| Sim_ProcessPause | 344ce6 | static / LOCAL / absent |
| SimQueue_SetLag | 34f36a | static / LOCAL / absent |
| SimQueue_IsBlocking | 34f38b | static / LOCAL / absent |

These removals are correct; exporting the functions merely to satisfy their
previous public declarations would have contradicted native storage evidence.

## Regression totals and reproducibility

The **correct total is 205/206 PASS**, not the initially stated235/236. The root
confirmed and corrected that arithmetic error during review. The15 saved gate
receipts sum to206 functions. The only unchanged miss is
Replay_StoringControllerData__FG15tControllerData:188 differences, with its
pre-existing branch residual at instruction1 (219 versus223).

Independently recomputed SHA-256 for each live defining .o. All15 exactly equal
both their recorded before and after hashes in
`p875_root_defining_object_receipts.json`. Thus the header edits did not change
their instructions, data, relocations or visibility. This review verified the
live artifacts and recorded gate totals; it does not claim a fresh build run.

The initial probe script read live repaired headers for historical `before`
mode. That reproducibility gap was reported and **fixed by the root**: immutable
`p875_root_header_snapshots.json` now supplies before/candidate text, and each of
the177 original plan lines occurs exactly once in its corresponding snapshot.
The updated script's mode selection was inspected. Refreshed before receipts
record13 compiling originals with126 invalid double-mangled references, plus
the genuine original object.h/track.h member-declaration compile failures.

Small remaining diagnostic qualification: `candidate` mode applies the free
prototype/STAT plan but not the separately reviewed6 object.h and3 track.h
non-member removals. Therefore `current` mode is the final full-header proof;
do not describe candidate mode as reproducing every final header edit.

Only this independent review document was written. No shared inventory refresh
or commit/push was performed.
