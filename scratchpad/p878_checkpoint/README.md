# P878 checkpoint: source restoration and retired flag splices

The user explicitly authorized committing the verified P869-P878 checkpoint
and pushing it to origin/main. Unrelated edits, compiler intermediates and
the existing large untracked scratch collection are excluded.

## Final P878 changes

- Weather_Init consistently reads its initialized Weather_gTrackSpec->type
  pointer. Whole Weather25/25 PASS, branch0, Init211/exact-g. The redundant
  PER_FN_FORCE_ADDR entry is removed; the table is empty. The production
  object remains0ddbacb299921c55bccc8e4514a775ab4a2623d42e3e8791a4749c681eb67f0e.
- AudioClc uses one whole-TU -fno-thread-jumps input at its existing2.8.0/G4
  identity. Its former per-function splice is removed; that table is empty.
  Whole18/18 PASS, branch0, SoundPlayersCar461/exact-g. The complete object
  equals the old normal mixed object:
  b8d20ef0cff1416894e8fe988c4fae015651e6cc496ef0024bcf44748266da89.
- The existing no-thread-jumps option is mirrored into SLD debug compilation.
  Protected tool snapshots are build.py.before and diffsrc.py.before here.
  No generated instruction stream or verifier acceptance rule was rewritten.
- MenuExtended_GoToTournTrackInfo and GoToSpecialEventTrackInfo use the genuine
  scalar menuDefs pointer directly for the final command stores. Their obsolete
  menus aliases are gone. They remain90/91 PASS with exact code twins; the
  entire Femenudefs66/66 object remains
  e5f8a1f116f2e9aeecfbf0d2d96c5e4e6a6164caea5ef588aec3690449580fd0.
  Other source-only webs and fences remain explicitly open.
- CopSpeak_Flush restores native i to its for-loop scope, retaining PASS20,
  exact code twin and whole27/27/branch0. Its request carrier remains; all
  failed removal probes were restored. P877's iVar3 removal is preserved.

The first two changes recover the last two normalized source-only misses in
the P875 79-owner cohort. The final cohort is **1301/1301 normalized PASS**.
One inherited branch-distance discrepancy in AudioTrk_AddCustomObject remains
explicit; normalized PASS is not proof of full branch/reference/source fidelity.

## Checkpoint validation

- Both complete strict source-only builds passed with no skipped TUs:
  --skip-asm and --out expected --no-link.
- The final79-owner sweep is retained in
  ../root_sym_audit/p878_final_common_psx_validation_20260906.json.
-78 whole-object rebuild hashes were identical immediately. The sole exception
  was AIWORLD.cpp source-path casing after a full build: exactly7 bytes in
  .strtab, no program/data/relocation bytes. Recompiling with the same uppercase
  input reproduces the exact accepted full hash. check_aiworld_metadata.py and
  aiworld_metadata_receipt.json reproduce this adjudication. The reused P875
  validator now reuses the accepted object's source input spelling rather than
  forcing lowercase; it never normalizes or rewrites generated object bytes.
- New Weather raw checks cover2035 words; AudioClc1852; CopSpeak_Flush20.
  Per-agent receipts are in ../p878_weather, ../p878_audioclc and
  ../p878_copspeak. Previous P877 raw/object/compiler receipts remain intact.
- Normalized source/codegen carriers: frontend472 to470; game remains479.
  The main source/SYM/SLD goal is not complete. In particular, next's native
  target home, remaining inline/local ownership, data views and existing
  compiler-shaping fences are not certified as original source by this checkpoint.

## Publication scope

inventory.py is a read-only candidate inventory. It excludes scratchpad/w85/o2.txt
and all compiler .i/.s/.o intermediates. The production candidate list contains
only substantive diffs; line-ending-only worktree files are preserved outside
the commit. JPN feinput's two changes were checked and are solely the verified
FeTools_gScrollTicksOut scalar accesses. The fetched origin/main initially
matched local fe5df950. The final Git commit/push outcome is reported only after
Git confirms it; this document does not pre-claim publication success.

Before staging, whitespace-only lines and excess empty EOF lines in diagnostic
text snapshots were normalized. snapshot_formatting_receipt.json retains every
pre/post hash. C/C++ token content and source line numbers, plus JSON values,
were checked unchanged. This does not alter production source or compiled
objects; historical raw input hashes in earlier receipts remain historical.
