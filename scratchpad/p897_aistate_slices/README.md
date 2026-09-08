# P897 AIState native slice-field proposal

2026-09-09. **Verified proposal only; no production edits or normal build
outputs were made by this subtask.** Root owns landing and coordinated regression.
`propose.py` checks exact original, backup and candidate hashes before printing
the three-file `apply_patch` proposal; `proposed.patch` is its saved output.

## Complete graph and retained boundary

Exactly two actual consumers include the private AIState types/extern graph:

- `recon/game/common/aistate.cpp`.
- `regiondiff/recon/NFS4-R-USA/game/common/aistate.cpp`.

The proposal changes those two sources plus only
`recon/game/common/aistate_externs.h`. No public/shared type graph or
`aistate_types.h` is changed. The complete native Trk_NewSlice projection is
placed at the private extern boundary, explicitly identified as owner-derived;
AIState's original foreign-header visibility is not claimed recovered.

Native authority: bworldSm records **1cec71..1cedc3**,32-byte Trk_NewSlice, and
**1d937e**, scalar PTR Trk_NewSlice BWorldSm_slices at8013C7C0. The latter is one
pointer cell, not an array stored at that address. The recovered fields used here
are center[3] at+0, laneCount UCHAR at+29, avgPavedWidthLf/Rt UCHAR at+30/+31.
The entire32-byte field layout and native types are verified from compiler debug
records, including the remaining normal/forward/right/profile fields.

The old char-pointer asm alias and offset macro are retired across the whole
graph: base3 direct uses+20 macro calls; USA6 direct uses+12 macro calls.
USA's existing slicePtr-derived four field reads are typed through the same
native body. The BWorldSm_slices extern is not an owning definition.

## Required USA dependency repair

The untouched USA source did **not compile** with current headers. Its nine
`AIState_SimGlobalWords[1]` and two `AIState_GameSetupWords[3]/[6]` uses refer to
aliases already removed from the private header. The first failure is frozen in
`baseline_USA.json`; it must not be hidden by claiming a repaired-only baseline.

Root authorized the exact native-field repair:

- nine reads -> `simGlobal.gameTicks`, native INT+4 (17d287/338790, owner345234).
- index3 -> `GameSetup_gData.commMode`, native INT+12 (27dd4b).
- index6 -> `GameSetup_gData.trafficDensity`, native INT+24 (27dd95, owner2874b5).

A coherent **historical private-header pair** was recovered directly from git
`2eaf1c50cee302229765b5ef19306798e4b81707` (`bdad608c^`), before the GameSetup
alias retirement; it also retains the SimGlobal alias. Both exact headers are
under `inputs/historical/common`. The original current USA body compiled with
that historical pair, using the same current transitive context throughout.
The dependency-repaired current-native header stage preserves its complete
code/data/storage payloads, symbol entities and ordered relocations. All52
functions' debug instructions/scopes/declarations and line partitions also agree.
Only the explicitly checked scratch source FILE pathname differs.

No invented extern or signature was used. The pre-existing fixedmult/memset
implicit-declaration warnings remain; their existing object references are the
plain `fixedmult`/`memset` symbols, not newly invented variadic manglings.

## Final checks

| Proof | Result |
|---|---|
| Whole base TU | **52/52 PASS** |
| Base branches | **316**, zero divergence |
| Actual USA manifest oracles | **2/2 REGION-PASS**: StartUp/Restart16 each |
| Complete normal object semantics | All payloads, headers/schemas, full symbol multisets and ordered relocation entities preserved |
| Complete debug `.text` | Exact normal-code twin in every accepted stage |
| Final function instances | **104** (52 base+52 USA) preserve all contracts |
| Dependency-repair comparisons | Additional52 USA function instances unchanged |
| Raw own-image references | **90/90** words exact |
| Debug label changes | **0**; uniqueness checked before assembly |

The normal-object comparison does not just rely on the two USA manifest gates.
Every actual emitted function and every data/storage byte is protected, including
unmanifested USA bodies. Physical FILE path differences between scratch stages
are explicitly checked; no other symbol difference is ignored. The gate does
not assert52 regional-oracle PASSes when only two manifest oracles exist.

For all104 final instances (and the52 dependency comparisons), the verifier
checks unchanged parameter/local/storage records and instruction-line partitions.
Stronger check: the **entire compiler debug function body** agrees after removing
only absolute `.loc` directives. Instructions, labels, lexical block positions,
relative block lines and declaration sequences remain unchanged. This preserves
current scopes; it does not prove all current scopes equal retail SYM.

Raw references, per image:

- 22 BWorldSm_slices HI/LO words ->44 total, native base8013C7C0 / USA8013DAB4.
- 21 simGlobal words ->42 total.
- 2 GameSetup_gData base-materialization words ->4 total.

**Regional map caveat handled explicitly:** the USA symmap's simGlobal row is
anchored to base8011E0B0 / USA8011F368, which is the gameTicks field, not the
native global start8011E0AC. Subtracting that explicit+4 field delta recovers
the USA global base8011F364. The verifier validates every resulting raw word,
rather than blindly treating the map's region_addr as the global base.

## Bounded variants and final source shape

The first natural indexed candidate preserved the base, but changed USA Donuts
from319 to317 instructions. Its existing sliceCenter reference/forwardSlice web
requires the original integer-address evaluation shape. That failed stage
`slices` remains frozen; the two manifest PASSes did not conceal the regression.

The next `shaped` stage restored Donuts319, but complete-object comparison found
one remaining USA Chase word: index251 changed `addu a2,v0,v1` to
`addu a2,v1,v0`. The final stage retains the existing slicePtr integer carrier
and index-first address arithmetic using `sizeof(Trk_NewSlice)`, then reads its
native fields through a Trk_NewSlice pointer. Both issues are fixed in `final`.

USA Donuts preserves its existing sliceCenter reference and integer-address
evaluation while naming `.center`. Base uses natural indexed center access.
All existing coorddef copies remain whole-struct copies. No carrier was removed,
renamed, hidden by an audit exception, or declared original merely because a
field type became correct. In particular, slicePtr, bVar1/bVar2, sliceCenter,
latOffset/latBias/limit, and other existing names retain their prior provenance
status. Existing fences are unchanged; no asm, volatile, helper, new local or
compiler flag was introduced.

Native affected blocks were read in full: CloseTargeting147980, barrier targeting
147e4f, barrier scan147f92, Offroad ctor1483b3, RovingTraffic148f5f and Donuts1491f8.
Their original locals, nested block structures and existing unresolved carrier
questions were not replaced by semantic-name guesses. `native_records.py`
prints those exact source records without building or editing anything.

## Final hashes and proposal

Final scratch normal objects (FILE paths differ from production):

- Base22864bytes:
  `066ab0b55771dde7cfe93a3230635bcbd0dbb7eec232100cf93578b52709bcc0`.
- USA22988bytes:
  `7d08803d81438fc5a8c92ea136fb64f1fe3d8c4d7b0f5cf71ccbc77039d2b50d`.

Candidate source hashes are pinned in `propose.py` against the compiled inputs.
Run `python -B scratchpad/p897_aistate_slices/propose.py` to obtain the checked
patch; it refuses if any original source/header or candidate has drifted.

Artifacts: `backups/`, `inputs/{baseline,historical,dependency,slices,shaped,final}`,
all stage JSONs/objects/debug outputs, `verification.json`, `gate.py`, `verify.py`,
`diff_objects.py`, `native_records.py`, `propose.py`, `proposed.patch`.
The final verifier writes only its own receipt; the gate writes only this scratch
namespace. Root must apply the proposal, re-gate actual production paths, and
run the coordinated whole-project regression. Full source/SYM/SLD restoration
is not claimed by this field-interface correction.
