# P875 follow-up: remaining common public headers

Date: 2026-09-06. This is the second, disjoint common-header batch; it preserves
the first batch's115 repaired prototypes and all P869-P874 implementation work.
Only these17 public headers were edited. No .cpp, private type/extern header,
shared production tooling, oracle or binary input was edited; no commit/push.

## Completed disposition

The entire **251-candidate** non-AI common-header queue assigned to this agent is
resolved: **249 genuine EXT public prototypes corrected**, and **2 native STAT
functions removed from the public API without changing their implementation or
visibility**. Typed address probes emit all249 exact expected native linkage names,
and each exists as a GLOBAL symbol in its freshly compiled defining object.

A separate review additionally removed **64 false non-member declarations** which
misrepresented existing C++ constructors, destructors and methods: anim8, mpause1,
pausemenu55. The real class declarations were already included by these headers.
Typed member-pointer and constructor/destructor-call probes verify all64 expected
native member exports. The legitimate explicit-C `___14tPauseMenuDefs` destructor
bridge remains unchanged and has its own positive reference/export proof.

| Header | Correct EXT prototypes | Removed STAT prototypes | Removed false non-members | Paired TU |
| --- | ---: | ---: | ---: | --- |
| `anim.h` | 10 | 0 | 8 | 18/18 PASS |
| `audedit.h` | 2 | 0 | 0 | 2/2 PASS |
| `bworld.h` | 21 | 0 | 0 | 21/21 PASS |
| `bworldsm.h` | 28 | 0 | 0 | 28/28 PASS |
| `camera.h` | 38 | 0 | 0 | 38/38 PASS |
| `cars.h` | 33 | 0 | 0 | 33/33 PASS |
| `chunk.h` | 3 | 0 | 0 | 4/4 PASS |
| `copspeak.h` | 27 | 0 | 0 | 27/27 PASS |
| `dashhud.h` | 6 | 0 | 0 | 6/6 PASS |
| `genericpmx.h` | 1 | 0 | 0 | 1/1 PASS |
| `hudpmx.h` | 2 | 1 | 0 | 3/3 PASS |
| `mpause.h` | 8 | 0 | 1 | 10/10 PASS |
| `nfs3.h` | 9 | 1 | 0 | 11/11 PASS |
| `pausemenu.h` | 3 | 0 | 55 | 60/60 PASS |
| `r3dcar.h` | 27 | 0 | 0 | 27/27 PASS |
| `render.h` | 23 | 0 | 0 | 23/23 PASS |
| `textsys.h` | 8 | 0 | 0 | 8/8 PASS |

## Native signature and visibility evidence

All251 free-function candidates were checked against native EXT/STAT FCN records,
actual definition signatures and parameter records. The corrected public function
types/names agree with those definitions and the exact compiler-emitted linkage.
No namespace conversion or C-linkage alias was invented.

- `HudPmx_LoadShape`: native STAT record `2326e1`, VA80092464, actual
  `static void HudPmx_LoadShape(char *,HudPmx_tShape *)`. Removed its public
  prototype. Actual symbol remains LOCAL; negative public-header compile probe
  reports that `HudPmx_LoadShape` is not declared.
- `NFS4_LoadPerps`: native STAT `2c698e`, VA800a3f08, actual
  `static void NFS4_LoadPerps(void)`. Same LOCAL/negative-public-probe evidence.
- `Anim_GetAnim`: `void *` -> `AnimScript *`, native `17460e`,
  PTR STRUCT size20.
- `NormalCache_FindEntry`: `BOOL` -> `bool`, native `1d749c` BOOL.
  The old public header did not even define BOOL through its minimal dependencies.
- `BWorldSm_UNormal/UForward`: `void *` -> `coorddef *`, native
  `1d751c/1d7557`, PTR STRUCT size12.
- `PauseMenu_MenuText`: both `BOOL` arguments -> native `bool`,
  retaining the exact `__FsbT1` signature.
- `R3DCar_ReadInCarData`: `void *` -> `Transformer_zScene *`,
  native `31058f`, PTR STRUCT size588.

The native metadata file retains the complete record identities, returns and
parameter records for all251 candidates. Member metadata additionally retains
native EXT identities and130 parameter records for the64 removed duplicate
declarations, plus their corresponding actual C++ definition signatures.

## Original-header failure modes (do not conflate them)

13 original full headers compiled but emitted **202 wrong
double-mangled references**, all absent from their defining objects. **Four
original full headers failed compilation** before references could be emitted:

- `anim.h`:8 pseudo-free encoded ctor/member declarations collide with real
  `AnimScript` member declarations.
- `mpause.h`: encoded pseudo-free constructor collides with
  `tPauseMenuDefs::tPauseMenuDefs()`.
- `pausemenu.h`: pseudo-free encoded methods/constructors collide with the
  included widget class members; stale destructor-like nonmembers are likewise
  not actual bridges.
- `bworldsm.h`: `BOOL NormalCache_FindEntry...` lacks a BOOL definition.

Those compile failures are preserved as diagnostic outcomes, not labeled as
successful old-linkage probes. All17 corrected full headers compile successfully.

The member correction does not delete a real API. Real constructors and methods
remain available through their existing classes; return/reference/enum/callback
types come from the actual member declarations. Constructor tests use ordinary
new-expressions, destructor tests explicit C++ destructor calls, and method tests
typed member pointers, with overload casts where needed. No probe executes.

The existing mpause destructor C bridge is distinguished explicitly:
native `_._14tPauseMenuDefs`, record `2a0a4f`, VA8009e234, corresponds to the
project's normal compiler-adapted `___14tPauseMenuDefs` export. Its declaration
was not changed. This is not a blanket rule to strip encoded ABI names.

## Regression

All **320/320 paired functions PASS** before and after. All320 branch checks
have zero divergence. Every one of the17 defining .o files is byte-identical
to its fresh pre-edit object, covering instructions, data, relocation targets,
addends and symbol visibility.

| Object (source casing preserved) | Identical before/after SHA-256 |
| --- | --- |
| `anim.cpp.o` | `68caaa92eb015f572c4200e9e1ee635e3994b0591d0bce1c566d4c0d293fbb42` |
| `audedit.cpp.o` | `dfbdbcfeb4e45f6902bd605f9a125c06d281ac9ccb4614a418b5558230ef54d2` |
| `bworld.cpp.o` | `c3a0b5c04421d3854304c9961d5e6d4f398e3d5d4729f7ea0c886af4bff30435` |
| `bworldSm.cpp.o` | `f6260bf3fb68f723e334eb93f07f1c1dfe0d9cc2c7e60dd706cfd5d550f25b2b` |
| `camera.cpp.o` | `d5719a2e607ed9c04c328928a6563c4665f468cb71cb96318fd76bf534f168f6` |
| `cars.cpp.o` | `c198fb69f6ffaf9fd2243b89d96ea95d81fbb758658d92ba41bdd378e9191598` |
| `chunk.cpp.o` | `8aa1d225c7f9d1ec5dd25c8ab16b7cfa67c214efa0dafe5277f01795ca20efbe` |
| `copspeak.cpp.o` | `70fc97ebe71e9feeb970a4af6af67f16969a2171d4a82bfc1a35834376f9807e` |
| `dashhud.cpp.o` | `b586015a33fcc582624f2884f8ea3dd12be015cddaca2e16fe1a7183fc2453d7` |
| `genericpmx.cpp.o` | `7c4f41b27d16aa6ebdec0644208a2e5f3a05a51c763426e09dbc452e537a6b08` |
| `hudpmx.cpp.o` | `1999a066a551d2dc24c5f2a455806914ca26c37a62cd8974a822b936aef3ade9` |
| `mpause.cpp.o` | `17fbf429095d9b37a94e3ae084123ed77b618480f41abd89a2296ffd2205dcb1` |
| `nfs3.cpp.o` | `ed3390faba0dff90ca5a780e763100ec856d40415478a6f74a1272bf5c5c27e1` |
| `pausemenu.cpp.o` | `a00281d5768ce5d4b0a6aff6d14096f32626acfcae0b63e5d3bc8a966314a6bf` |
| `r3dcar.cpp.o` | `1d23d35f5b1f7ab7e0fc385db93dd69e8fdc4675cdb0aa9e7bb566e45205517a` |
| `render.cpp.o` | `c19627d83c71e56bc79b3eca762ba4cfa3d3da527e63b3c55fafd462cb8668a8` |
| `textsys.cpp.o` | `3015870caf1dc0c672fe1ccd787ce4df264fc8b0efe009a1a2f0aae8710f45f5` |

A case-insensitive exact-basename literal include scan across `recon` and
`regiondiff/recon` found **zero production includes** of these17 public headers.
This explains why the malformed APIs survived implementation builds. It is not
proof of every possible historical/macro-generated include relationship.
No existing consumer needed a source edit. `git diff --check` is clean.

## Durable diagnostic artifacts

All are under `scratchpad/root_sym_audit` and are diagnostic only:

- `p875_common2_prototypes.json`:251 reviewed free-function candidates and actions.
- `p875_common2_original_*.h`: original full headers, with include paths anchored
  so isolated copies still find their real dependencies.
- `p875_common2_legacy_*.cpp` and `p875_common2_fixed_*.cpp`: typed address probes.
- `p875_common2_private_*.cpp`: two expected-failure private-API probes.
- `p875_common2_probe.py legacy|fixed|private`: real legacy compiler, native-record
  revalidation and defining-object visibility checks. Legacy records the four
  specific original compile failures rather than hiding them.
- `p875_common2_member_declarations.json`:64 native/member/source correspondences.
- `p875_common2_members_*.cpp`: typed member/constructor/destructor probes.
- `p875_common2_member_probe.py`:65 positive native/export checks, including the
  retained explicit-C mpause destructor bridge. Additional emitted references
  belong only to the scratch wrappers and the compiler allocation helper.
- The first-batch `p875_common_probe.py` supplies the shared diagnostic compiler
  wrapper used by this follow-up. It is not production tooling.

## Remaining scope and qualification

No unresolved candidate remains in this assigned17-header/251-row set, and the
64 separately identified false member declarations are resolved. Do not count
this as proof of fully restored historical public-header layout, include paths,
macros, or every transitive class declaration: those are distinct source-restoration
questions. In particular, broad shared `nfs4_types.h` inclusion is existing project
organization, not newly proven original organization.

The parent's other common-header batch and the AI/frontend agents' scopes were
not touched. Their work must be reconciled by the parent. No shared inventory
refresh was run; the parent owns the consolidated queue and completion assessment.
