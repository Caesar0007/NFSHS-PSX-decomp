# P875 common public-header repair receipt

Date: 2026-09-06. Scope: nine public headers in `recon/game/common`.
No implementation, private type/extern header, production tooling, oracle or
binary was edited. No commits or pushes were made by this agent.

## Result

**115 public prototypes repaired and 115 exact native linkage references verified.**
Each function's native EXT FCN return record and all REGPARM/ARG type/name records
were compared with its actual paired definition; no definition/native parameter
disagreements were found in this selected batch. All expected symbols exist in
the freshly compiled defining objects.

The original headers were compiled separately, with typed function-address
references. All **115/115** original declarations produced double-mangled
references absent from their defining objects and from the expected native set.
The corrected headers produce **115/115 exact native symbols**. Pointer types in
the fixed probes come from the independently reviewed definitions, so stale
return types are checked by C++ assignment compatibility, not just link names.

| Public header | Prototypes repaired | Final paired TU gate | Original/fixed reference proof |
| --- | ---: | --- | --- |
| `audioclc.h` | 18 | 17/18 PASS | all wrong / all exact |
| `audiocmn.h` | 48 | 48/48 PASS | all wrong / all exact |
| `audiomus.h` | 23 | 23/23 PASS | all wrong / all exact |
| `audiotrk.h` | 6 | 6/6 PASS | all wrong / all exact |
| `clock.h` | 3 | 3/3 PASS | all wrong / all exact |
| `fastrand.h` | 2 | 2/2 PASS | all wrong / all exact |
| `mathnfs.h` | 10 | 10/10 PASS | all wrong / all exact |
| `paths.h` | 1 | 1/1 PASS | all wrong / all exact |
| `udff.h` | 4 | 4/4 PASS | all wrong / all exact |

No literal production include of these nine public headers was found in
`recon` or `regiondiff/recon`. This is an include-search result, not a claim to
have reconstructed every historical/transitive include route. Existing source
TUs generally include their private type/extern headers. The broken unused API
prototypes therefore escaped the ordinary compilation/link gates.

## Verified signature corrections beyond spelling

- `AudioCmn_GetAsyncSfx`: `BOOL checkonly` -> `bool checkonly`.
  Native REGPARM `191b70` is BOOL and the real linkage is `__Fiib`;
  the old typedef spelling compiled the argument as INT (`__Fiii`).
- `ChooseImpactSample`, `ChooseLoopedSample`, `AudioCmn_SFX` and
  `AudioCmn_TrafficSkidSFX`: `surface1/surface2` restored from `int`
  to native `s_type` enum. Native EXT records `19106a`, `191097`,
  `1910c3`, `1911ef`; for example REGPARM `1925cb/1925ea` explicitly
  tag `s_type`. Correct references preserve `6s_type` encoding.
- `AudioCmn_SoundCar`: public parameter `dop` corrected to original
  `doppler`, native ARG `192ebb`, agreeing with its implementation.
- `AudioMus_GetCurrentSong`: `void *` -> `AudioMus_tCurrentSong *`,
  native EXT `19ea80`, PTR STRUCT size76.
- `AudioMus_GetSongList`: `void *` -> `AudioMus_tSongList *`,
  native EXT `19ebb9`, PTR STRUCT size8.
- `Udff_Opena`: `void *` -> `Udff_tInfo *`, native EXT `37c50f`,
  PTR STRUCT size12.

No selected function is a namespace member, method bridge, or explicit
C-linkage export. The final native-linkage/reference-to-definition comparison
checks this rather than assuming every encoded identifier may be stripped.
No overload ambiguity occurs in this selected batch; typed pointers remain
the appropriate proof and should use explicit types for later overloads.

## Regression and byte-identity receipts

Before and after header edits, paired TUs remain **114/115 normalized PASS**.
The sole unchanged normalized miss is
`AudioClc_SoundPlayersCar__Fi`: four differences. Two existing branch residuals
remain: that function at instruction51 (14 versus12), and
`AudioTrk_AddCustomObject__FP9AudioElemiP8Car_tObji` at instruction48
(14 versus13). These are not new and are not hidden by this receipt.

All **nine entire .o files** are byte-identical to their fresh pre-edit objects,
including code, data, relocation identities and addends. Thus no previously
matching implementation was regressed by this public-header correction.

| Defining object | Identical before/after SHA-256 |
| --- | --- |
| `audioclc.cpp.o` | `80c46a113419eb0d19b9137a7b4559935aeb24606c83f7bab7daca6d340c315e` |
| `audiocmn.cpp.o` | `71ddb86db9e91f16ed317d1fc7f327931b6deed22543f03c5aa7a9f86f12b993` |
| `audiomus.cpp.o` | `f6e556413410b4b0d3879ed8ae420b67df328f82cdf1e37add8e3ae6eee4a87b` |
| `audiotrk.cpp.o` | `ec24cfdfb6b9c0f0d32a9815a36aabd16c7dbd1983f3287d74e56c3de3dff784` |
| `clock.cpp.o` | `ea9ddec938de4caad254890411e192227fbd8ac491cbc5b7b7200e0cdc5241d5` |
| `fastrand.cpp.o` | `c2fe1bff91cf27f0388b75f068a1fb8883c8d4aecc3dcfd53d91ce55ae8a0193` |
| `mathnfs.cpp.o` | `b160ba0c6ac18bba5b6ef7a6edc34a89386128e1c487c321838fe92cd07f3852` |
| `paths.cpp.o` | `45db320acdcbb14a05f8decb855519769d66693e30f41f3c9de3a16fadd443ad` |
| `udff.cpp.o` | `444c6719d9fe59776fa66a3ee70d9f2e7ce22ffea51d39d525b0f368fbcb049c` |

`git diff --check` passes for all nine public headers.

## Reproduction and evidence artifacts

- `p875_common_prototypes.json`: every old line, actual definition,
  native EXT record/VA/return, and all native parameter records.
- `p875_common_original_*.h`: isolated original-header fixtures; only
  include paths are anchored so copies still locate their original dependencies.
- `p875_common_legacy_*.cpp`: typed references demonstrating former defects.
- `p875_common_fixed_*.cpp`: typed references using corrected production headers.
- `p875_common_probe.py`: real CPP/CC1PLPSX/build pipeline, native-record
  revalidation, exact relocation symbols and defining-object export checks.
  Run `python scratchpad/root_sym_audit/p875_common_probe.py legacy` or
  `... fixed` after compiling the corresponding nine implementation TUs.
- `p875_common_inspect.py`: pre-repair inventory only; repaired headers
  intentionally disappear from that scan. The reviewed JSON is the durable
  pre-edit snapshot. This script does not modify source or refresh the shared queue.

Probes and their identifiers are diagnostic scratch sources, never game inputs.
The parent maintains the consolidated public-header queue; no shared inventory
refresh was run by this agent.

## Remaining review queue

No unresolved prototype remains among these selected115. The broader project
is not claimed complete. The following non-AI common-header candidates were
not attempted in this bounded batch; counts are from the P874 snapshot, not
a fresh global inventory.

| Header | P874 candidate count | Required follow-up |
| --- | ---: | --- |
| `anim.h` | 10 | Native signature, linkage/context, typed reference and caller verification |
| `audedit.h` | 2 | Native signature, linkage/context, typed reference and caller verification |
| `bworld.h` | 21 | Native signature, linkage/context, typed reference and caller verification |
| `bworldsm.h` | 28 | Native signature, linkage/context, typed reference and caller verification |
| `camera.h` | 38 | Native signature, linkage/context, typed reference and caller verification |
| `cars.h` | 33 | Native signature, linkage/context, typed reference and caller verification |
| `chunk.h` | 3 | Native signature, linkage/context, typed reference and caller verification |
| `copspeak.h` | 27 | Native signature, linkage/context, typed reference and caller verification |
| `dashhud.h` | 6 | Native signature, linkage/context, typed reference and caller verification |
| `genericpmx.h` | 1 | Native signature, linkage/context, typed reference and caller verification |
| `hudpmx.h` | 3 | Native signature, linkage/context, typed reference and caller verification |
| `mpause.h` | 8 | Native signature, linkage/context, typed reference and caller verification |
| `nfs3.h` | 10 | Native signature, linkage/context, typed reference and caller verification |
| `pausemenu.h` | 3 | Native signature, linkage/context, typed reference and caller verification |
| `r3dcar.h` | 27 | Native signature, linkage/context, typed reference and caller verification |
| `render.h` | 23 | Native signature, linkage/context, typed reference and caller verification |
| `textsys.h` | 8 | Native signature, linkage/context, typed reference and caller verification |

These 17 headers contain 251 snapshot candidates.
In addition, the parent's disjoint physics/newton/replay/object/input/gmesetup/
stats/schedule/sim/simqueue/quatern/scene/souffle/track/trgsfx batch and another
agent's AI/frontend work must be reconciled by the parent, not counted as
unresolved or complete here. Member/constructor/ABI-bridge and multiline forms
omitted by the P874 simple scan remain a separate review requirement.
