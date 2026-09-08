# P892: native fields, source statements and regional interface recovery

Completed 2026-09-08 in `C:\Temp\nfs4-decomp`. This is a verified source-recovery
checkpoint, not a claim of complete original-source, SYM, SLD or final-image
equivalence. P884-P891 work and unrelated user changes remain preserved.
No commit or push is performed in this round.

## Retained source improvements

| Scope | Retained correction | Evidence and limits |
|---|---|---|
| ScreenPost / TrackRecords, base and USA | Two scalar ticks declarations; ten false outer-array reads removed | Four entire objects byte-identical; all eight affected method instances preserve debug locals and line partitions; native `tt` locals retained |
| ScreenCongrats, base/USA/JPN and private/shared types | Direct native initialization fields, entry tick captured first; unsupported nonvirtual `PrepareInitialize` helper removed | Initializer SLD merges24->0 and splits33->32, with no new bad pairs; all three49-word initializers raw-exact; remaining32 splits and native empty-block identity stay open |
| AIInit | Invented `AIInit_leaderBoardCars` array/asm alias replaced by actual `leaderBoard` structure and four native field names | Native type130b95..130c49 and global1371f7; complete65-word Reset2 raw-exact; existing AISpeeds owner unchanged |
| Camera, base plus six regions | Invented replay alias/macros replaced by `Replay_ReplayCamera` and native fields | Native type326706..32678F and global32A86B;42 raw replay-reference words exact across the seven actual images |
| Six regional Camera files | Stale aggregate interfaces replaced by current native GameSetup, simVar, simGlobal and Replay fields | Actual files now compile against current headers; old coherent baselines used a historical header only in scratch; regional constants and prior matching results preserved |

Camera's private and AIInit's private type projections use types recovered from
the actual owning native modules. Those foreign bodies are not established in
the consumers' surviving per-TU type streams. The code comments explicitly keep
that type-visibility/source-header provenance question open.

The regional Camera field reconstruction preserves `carInfo` at0x3D4, element
stride180 **decimal** bytes, and `Camera[4]` at element offset0xA4. Thirteen
target-layout assertions pass. No reinterpretation as `Car_tObj.slide` remains
at these sites. The six regional `Camera_NextMode` bodies lose the unsupported
`setupBase`/`setupOffset` locals without replacement names. Native base SYM has
only `cviewP` and `flagMode`.

## Coordinated full validation

`full_validation.py` completed all three full build lanes without failed or
skipped translation units:

1. Reconstruction/source-only `--skip-asm`.
2. Expected/oracle `--out expected --no-link`.
3. Complete object build `--no-link`.

The wrapper uses the existing source-only compilation policy; it does not
rewrite compiler output. Both linker generation/check steps, both relink lanes,
vtable indexing, source policy, the two strict declaration audits, and the
leaderBoard/Camera detailed verifiers pass their stated gates.

The protected regression set is **665/665 functions across31 base TUs**, with
zero branch differences and zero source-receipt hash drift. This expands P891's
537-function set by AIInit17, AISpeeds29, ScreenCongrats28, Camera38 and Replay16.
It is not represented as a fresh all-project per-function gate count.

### Literal bytes versus metadata equivalence

The frozen518-object baseline was hash-checked against P887's recorded normal
objects before comparison. **515 objects are literally byte-identical.** Exactly
three differ only in the following compiler-generated metadata:

| Object | Before SHA256 | After SHA256 | Allowed difference |
|---|---|---|---|
| ScreenCongrats | `a6b9b85ff98589344fd50eaeb22285d7c89ed4c766b3fcf38cbee193f5bb8846` | `ff967aa34d2ae254d5711561a750c52e8ea64949c84a559c23ba71c9e1bf2318` | Local `.bss+0` label `carRotate.44`->`carRotate.42`; source name unchanged |
| AIInit | `0d63d1b4934a00b72ec34512c2e114e4f4e3d254dd6969a14b9707b2e4430871` | `f85bc2d28cda7e2b4a9bc8805cd71007e5ab604e0ab261343576ff1d8b0a1b78` | Symbol/string order and corresponding relocation symbol indices |
| Camera | `d5719a2e607ed9c04c328928a6563c4665f468cb71cb96318fd76bf534f168f6` | `d725a8123294b656897ac4b92297b5848166f10554ad920780a4028793d0e0db` | Symbol/string order and corresponding relocation symbol indices |

Across all518 objects, every code/data/storage byte and semantic section
attribute is preserved. The full symbol multiset and ordered relocation
operations retain their binding, target, offset and type, subject only to the
explicit single local UID rename. Raw symbol-index integers are not falsely
claimed unchanged in AIInit or Camera.

The diagnostic linked ELF changes from
`74d77a4af62d7c63ca711bce57bf7850664b7b2b63562eff0b7186156ddfa86c`
to `bf66bf489f36b0c7236bbcff855ed2480f36f1fe4a889c20b22bb3e033e0592e`.
Its code/data/storage, semantic ELF header, LOAD program headers, global symbol
bindings and allocated section layout are unchanged. The allowed local
`carRotate.44`->`.42` rename remains at0x8013EFF0. That is a frozen current-link
storage-preservation anchor, **not** an assertion of native retail placement.

### Metadata verifier negative controls

The scratch-only `metadata_audit.py` is fail-closed for unsupported ELF metadata.
An independent review found that its original broad normalization could ignore
RELA, collapse duplicate section/local names, accept an executable UID rename,
trust a name found only in a source comment, and omit entry/header checks. The
checker was hardened before accepting the full checkpoint. No production
verifier threshold or compiler output was changed.

The current implementation handles exactly the inventoried ELF32 little-endian
MIPS REL/EXEC formats. It keeps every symbol row, checks relocation order, and
allows only the documented ScreenCongrats local data UID change. Unknown
metadata, duplicate section names, executable-symbol renames, payload/storage
changes and unapproved local UID changes are errors.

`python scratchpad/p892_checkpoint/metadata_audit.py --self-test` passes14 cases:
11 negative controls are rejected and3 valid controls accepted. The negatives
exercise duplicate-section data mutation, duplicate-local relocation retarget,
RELA mutation/addition, dynamic metadata, executable UID rename, two simultaneous
comment-only UID renames, entry point change, allocated bytes, NOBITS extent and
LOAD flags. Positives cover semantics-preserving duplicate-local permutation
and the actual ScreenCongrats/AIInit object changes. Fixtures exist only in
memory; no test modifies an object or executable.

## Regional, raw and SLD receipts

- ScreenPost base13/13 and TrackRecords7/7, with104 branch entries clean;
  USA3/3 each. All18 ticks-reference words are raw-exact. Existing native-relative
  SLD splits/merges remain unchanged, not claimed zero.
- ScreenCongrats base28/28, USA6/6. JPN's six existing misses remain
  13/4/6/12/10/6. Initializer147/147 words and all90 timer-reference words are
  raw-exact. Scalar ticks and spinTicks-removal probes regressed the retail
  reloads and were fully reverted; no new volatile or fake storage was used.
- AIInit17/17 and AISpeeds29/29. All17 AIInit methods preserve normal/debug code,
  instruction-source partitions and local/parameter records. Reset2 retains
  the actual field-write order and all65 resolved retail words.
- Camera38/38 and owner Replay16/16. All38 functions in each of seven Camera
  TUs have before/after object and debug comparisons. Base partitions are
  unchanged. In the regions only NextMode partitions change:164 fewer split
  pairs and no new bad pairs **relative to base SYM**. There is no claim of
  independent regional native SLD recovery.
- Camera AU's three available regional targets pass. FR-DE/UK-ES-IT/UK-SW
  retain their prior3/2/2-diff misses. JPN and USA currently have no Camera
  CHANGED-oracle slices, so their full object/reference preservation is not
  described as an unavailable regional PASS.

## Strict audit and still-open work

| Base directory | Declaration-clean | Missing names | Extra local names | Type / storage findings | Mapping review | Source-only carriers |
|---|---:|---:|---:|---:|---:|---:|
| frontend/common |780|0|48|9 /9|3|438|
| game/common |1228|0|6|28 /28|0|478|

These declaration-level counts do not prove that every source statement, scope,
inline helper, macro, extern or object owner is restored. The carrier queues,
foreign-type visibility, unresolved SLD partitions and false clock-array views
are active work. Existing debug-equivalent type recognitions and explicit
carrier annotations have not been silently promoted to exact-source evidence.

Standing relink policy remains851 known blob duplicates, zero REAL duplicates,
zero phantoms and zero referenced unresolveds. Its permissive diagnostic image
is not a clean final production link. Earlier1433 wrong native GP targets,
overlaps and main-data overrun remain open; preserving those bytes is not
fixing those defects. The data-only CDROM storage asm is unchanged by P892.

CI-style objdiff report generation succeeds:

```text
.\tools\objdiff\objdiff-cli.exe report generate -p . -o build/p892_report.binpb -f proto
```

The report is321195 bytes, SHA256
`2f64da5ebcadf1b920d8668e8a02ffed87abf40a1621fd45bfa97b3805ab19c3`.
`git diff --check` is clean. The user's `scratchpad/w85/o2.txt` remains SHA256
`d433425b806fc8abd1fa60c9f72a09f4c022bfd64a7fecf4df496931169e9546`.

Primary receipts are `final_receipts.json`, `full_validation_receipts.json`,
`checkpoint_source_receipts.json`, `metadata_receipts.json`, `relink.json`,
`frontend_strict.md` and `game_common_strict.md`. Per-family evidence/backups
are in `../p892_post_records`, `../p892_screencongrats`, `../p892_leaderboard`
and `../p892_replay_camera`. The main backlog retains the unresolved work.
The goal remains active and incomplete.
