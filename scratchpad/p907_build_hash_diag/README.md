# P907 six-object build-profile diagnosis — complete

All six discrepancies are confirmed **default-build versus verifier-strict
configuration**, not benign label numbering or a P907 source regression.
No metadata/hash waiver is justified: actual instructions, relocation records
and, for FIRST, storage-section placement differ.

For every object, independent isolated compilation established both literal
identities:

1. Current default builder output equals the initial full-build snapshot.
2. Exact verifier-strict configuration output equals the frozen pre-P907 hash.

| Source | Relevant default-only setting | Default text bytes | Strict text bytes |
|---|---|---:|---:|
| libapi/FIRST.c | firstfile RAW40 override | 668 | 652 |
| libcd/cdread.c | _read_issue RAW40 and CdRead no-split overrides | 2048 | 2020 |
| libetc/INTR.c | RestartCallback no-delayed-branch override | 1608 | 1604 |
| libmcrd/LIBMCRD.c | MemCardFormat no-delayed-branch override | 6056 | 6052 |
| libpad/PADCMD.c | _padLoadActInfo_rcv G4 override | 2372 | 2364 |
| libpad/PADSEQD.c | _padInitDirSeq RAW40 override | 1164 | 1168 |

Paths in the table are under `recon/syslib/psx`. The exact strict branch from
tools/verify_asm.py preserves the permitted compiler-version selections while
clearing the other PER_FN tables. The corresponding active-table inventories
are retained in each per-mode JSON. Setting NFS4_SOURCE_ONLY=1 for build.py
alone does not execute that verifier branch.

The isolated builders reset their private counters. Default objects still
match whole-process outputs literally, so no counter-renaming exception is
needed. The diffs also include downstream internal-address shifts; they are
not all independent source-function changes. FIRST's alternate labels share
one physical body and must not be counted as separate functions.

## Receipts and closure

- `root/README.md`, six `root/*_{default,strict}.json` files and
  `root/mode_differences.json`: FIRST/cdread/INTR.
- `peer/summary.json` and per-mode/comparison JSON files:
  LIBMCRD/PADCMD/PADSEQD.
- Initial full-built objects remain in `root/backups` and `peer/backups`.

This subtask wrote only isolated artifacts/reports. No production source or
tool was modified; no normal object was patched/copied back. Existing default
builder interventions were exercised for diagnosis, not endorsed or newly
added. Parent separately recompiled all six actual paths under the exact
strict configuration, restoring every frozen object hash and the verified
linked ELF/map. Parent's authoritative final closure is
`scratchpad/p907_checkpoint/build_profile_restored.json` and
`scratchpad/p907_checkpoint/policy_build_closure.json`.

Diagnosis and required verification are complete. No further probes pending.
