# P897 AIPhysic native slice field contract

2026-09-09. Isolated proposal only. Required ISA/methodology references remain
fully read in this context. No production source, normal build output, shared
types/tools, compiler flags, commits or external app messages were changed.

## Verified recovery

The two-file proposal retires private
`char *AIPhysic_BWorldSmSlices asm("BWorldSm_slices")` and restores
`Trk_NewSlice *BWorldSm_slices` plus24 native field accesses in five functions:

| Function | Recovered source accesses | Retained native objects |
|---|---|---|
| CheckForBadPosition |2 leftDrive/rightDrive reads | `badSpeed`, `badRoadPos` INT,11c47f/11c495 |
| CalculateRoadPosition |1 center copy,3 signed right components | `centerBack`, `carRelative`, `right` coorddef AUTO,11cb27..11cb6e |
| GetDesiredVector |1 center copy,3 signed right components,8 width/lane reads | Existing source locals11cc27..11cd8f unchanged |
| CheckIfOutOfControl |4 width/lane reads | `futureBend` INT,11cf02; goto return funnel preserved |
| HitWallCheck |2 laneCount reads with native slice indexing | `onRoad` INT in $6/a2,11d8d3; original short-circuit shape preserved |

Both whole-coorddef copies remain copies, not three stores. All six signed
byte accesses retain explicit `(signed char)` casts; the field declarations
remain native CHAR arrays, respecting this compiler's unsigned plain-char
default. Existing arithmetic casts, signed comparisons, local names/lifetimes
and branch structure remain unchanged. No new local, helper, macro, asm,
volatile, register pin or allocator dial is introduced.

## Native authority and include census

Owner type1cec71..1cedc3 gives32-byte `Trk_NewSlice`; global1d937e gives the
pointer cell at8013C7C0. Members are center INT[3]+0, normal CHAR[3]+12,
forward CHAR[3]+15, right CHAR[3]+18, acousticType UCHAR+21,
pavedProfile/leftDrive/rightDrive SHORT+22/+24/+26 and
chunkIndex/laneCount/avgPavedWidthLf/avgPavedWidthRt UCHAR+28/+29/+30/+31.

For the formerly raw `*(short *)((char *)carObj+8)` indexing:
native114edf places `Car_tObj.N` at0,11175f places Newton's simRoadInfo at8,
and111379 places BWorldSm_Pos.slice at0 as SHORT. The native look-ahead index
is INT at Car_tObj+0x758,115c24. Twenty-seven actual CC1PLPSX compile-time
assertions prove all relevant sizes/offsets, both array and pointer extents,
and these complete nested field paths.

Production include census under `recon` and `regiondiff/recon` finds only
base `aiphysic.cpp` consuming `aiphysic_externs.h` or `aiphysic_types.h`.
No regional consumer/header repair is needed. The owner-derived slice body
is therefore defined at the genuinely private **extern boundary**, not
exported through the type graph. `aiphysic_types.h` remains byte-identical.
The comment explicitly states that the original foreign-header visibility
is unproved; no per-TU native type-stream seal is claimed.

The matched NFS2 `AIPhysic_HitWallCheck.c` and
`AIPhysic_GetDesiredVector.c` were read. They independently corroborate the
native slice/lane/center access families and coorddef copy idiom. Different
NFS2 locals, look-ahead behavior and off-road logic were not imported.

## Complete before/candidate gates

- **42/42 PASS ->42/42 PASS**, every branch count/offset unchanged.
  The manifest is `src/aiphysic.c`, as wired in objdiff.json; it is not under
  src/game/common. The first harness path lookup failed before compilation
  and was corrected to this actual manifest.
- Entire normal object is **byte-identical**, SHA256
  `ab7993f9f43778fb711f5f38ce67462d82f2e3ada7b56743f6b5524e169917d0`.
  Thus all code, data/storage, symbols and numeric relocation entries remain
  unchanged, including the order-sensitive AIPhysic time globals.
- Both exact-debug twins have identical normal text. All42 instruction-line
  partitions and ordered local/parameter/storage records are unchanged.
- Complete lexical marker graphs and marker placement relative to the exact
  compiler instruction streams are unchanged. Four functions have shorter
  numeric relative block-line counts because multiline raw pointer spellings
  became member accesses. These physical line-number differences are recorded
  in `verification.json`, not presented as unchanged literal line spacing.
- **18/18 slice-pointer relocation words exact** against raw rom/nfs4-f.exe:
  CheckForBadPosition2, CalculateRoadPosition4, GetDesiredVector8,
  CheckIfOutOfControl2, HitWallCheck2. Verification resolves in memory only;
  no object or generated code is rewritten.
- All27 layout assertions pass with the actual target compiler/current flags.

No score counts were taken from stale progress tables. Normal and exact-debug
objects were freshly built in this scratch directory, using existing compiler
and read-only verifier implementations. Shared production tools are untouched.

## Honest remaining source scope

This is field/global name and type recovery, not complete original-source
recovery for these five functions. For example, `checkSide` is still declared
at function scope in GetDesiredVector, but native11cd8f owns it in the nested
block starting8006B104, relative line117; that pre-existing discrepancy is
not hidden or renamed by this round. Original macro-token spellings, physical
line spacing and foreign type-header visibility remain unsealed.

Existing simGlobal[]/D_8011E0B0 declarations and all unrelated carrier/helper
work stay out of this bounded patch. The native `badSpeed`, `badRoadPos`,
`onRoad`, `futureBend` and vector locals must not be removed merely because
their names resemble simple temporaries.

## Handoff

`propose.py` prints the exact two-file patch after checking current production
and frozen backup/candidate hashes. It writes nothing. Final artifacts are
`before.json`, `candidate.json`, `verification.json`, `layout_receipt.json`,
`gate.py`, `verify.py`, `layout.cpp`, `check_layout.py`, the input sources and
exact backups. Root owns actual-production revalidation and combined
regression/link checks after review.

## Independent actual-production receipt

After root applied the two-file proposal, `gate.py landed` compiled actual
`recon/game/common/aiphysic.cpp` against actual current private headers into
isolated landed outputs. No staged include path or normal build output was
used. `landed_verification.json` confirms42/42 PASS, all branch counts/offsets,
all42 local/instruction-line/lexical-marker contracts, and18 exact raw slice
reference words. `landed_layout_receipt.json` independently proves all27
assertions using `landed_layout.cpp` with direct actual-header includes.

Actual input SHA256 values:

| Input | SHA256 |
|---|---|
| aiphysic.cpp | `d64dc195b42d474e9b4237d93ff1e43561b89cf3d0ecf273b478ee59089e9651` |
| aiphysic_externs.h | `144413b50bb6767f18586a9b5c67273d89930700095575ea4678a7e542a9b35b` |
| unchanged aiphysic_types.h | `f4406abe2176a7bbed32b230af7194f19686c2d89aacb85272e45186fbff59cf` |

The actual normal object SHA256 is
`f0e2531e355fee1f87a628bd7ad44e5f14c4bb17362df7fa6a787c071b25f2dd`.
It differs from the staged baseline solely by its exact `STT_FILE` pathname.
The checker asserts both complete expected pathname rows, equal remaining
**ordered** symbol rows, identical semantic headers/section schemas/payloads,
and identical ordered relocation entities. It does not merely ignore every
file symbol or accept arbitrary metadata differences.

Original `verification.json` (`3db427...`) and `layout_receipt.json`
(`7036e7...`) remain unchanged. Existing physical line-spacing and native
scope/visibility debts described above remain explicit. This agent made no
production edits or further experiments during final validation.
