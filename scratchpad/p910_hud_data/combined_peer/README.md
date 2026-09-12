# P910 combined initialized HUD data + LOCAL zero-storage link review

Final reviewed private image:
`69a16b3e8b61fd915369ab7ac44701a66bf484e0556ec7f5cf87ea7950a75570`.
Map: `42761bd7fc662a51cb5c550c6820df8fd5870ee4fbc2b07a821804522eaba158`.
Baseline: production60e7dc44... / mapa5207be9... (frozen in `baseline/`).

The earlier3e18 image is **not** final acceptance: its HUD NOBITS output had
alignment4. The reviewed refreshed image has true `.hud_sbss` NOBITS76 at
8013DE00, flags0x10000003 and **output alignment8**, matching the source input.
No NOBITS file offset was read as a payload or assigned a ROM-zero hash.

## Owner and reference proof

- Initialized source HUD.data668 at80120924..80120BC0 is native-byte exact;
  all11 records are at their correct locations with nine GLOBAL/two LOCAL bindings.
- HUD.sbss76 at8013DE00..8013DE4C has all14 original LOCAL identities, including
  the countdownTick numeric compiler UID stem. No CPE load intersects this range.
- All32 initialized-data references and all140 zero-owner references have exact
  encoded native targets, checked through their actual input/output map sections.
- GP audit covers2381 relocations:1254 previously correct targets stay correct;
  exactly118 HUD targets improve. Wrong targets drop1124→1006. Zero unresolved,
  overflow, encoding mismatch or native/raw conflicts.

## Binding preservation — explicit distinctions

3864 ordinary native public full records and88 native FILE-qualified LOCAL full
records are unchanged. The following eight removed raw GLOBAL exports were
actually native **STAT** records, so replacing them with the same native names
and addresses as source LOCAL cells is an intentional binding correction:

`g1Player`, `gSprite0`, `gSprite1`, `currentSpriteColor`, `HudSplitTimeDiff1`,
`HudSplitTimeDiff2`, `PerpOverlayOn`, `PerpOverlayMessage`.

`combined_review.json` records the exact old GLOBAL tuple, new LOCAL tuple and
primary STAT record for each. The raw exports have no references; no caller is
silently rebound to a new external alias.

`biglen` is another explicit, different case: native VA8013DE64, width4, binding,
visibility and its four existing transport bytes remain unchanged. Only the
output container changes `.tail_data`→`.tail_after_hud_sbss` after the raw split.
It is not counted as an unchanged full tuple or a storage regression.

## Complete executable-input audit

All698 original objects rehash unchanged;696 are retained identically, and only
the two raw transport donors are replaced by the verified private splits.
Source/code objects are unchanged.

466 executable-flag input sections were compared (249505 words, including the
explicitly classified inert blob). Every one of2336 changed words occurs at an
existing input relocation, with unchanged non-relocation instruction bits.
`relocation_encodings.json` additionally verifies both old and new resolved
encodings against actual symbol bindings and same-object section bases:

- 1816 LO16 words;
- 361 GPREL16 words;
- 140 R26 words, including self/callee targets when spill addresses move;
- 19 HI16 words with signed-low carry.

All3238 previously native-positioned STT_FUNC full records/addresses are preserved.
The audit follows input executable flags even when the linker output container
is `.data_rest`; it does not skip those inputs based on output flags.

## Placement debt remains visible

Four **previously unanchored** code inputs in `.data_rest` move backward76 bytes
as generic storage shrinks: feapp10208 bytes, xform400, C52 eight, C_00296. Their
input code/relocations remain exact, and all changed linked encodings are verified,
but their placement remains debt. Thus not all code geometry is unchanged.

The separate24-byte `sn_lnk_blobs.text.s.o` also moves backward76. It is inert
SN-LNK transport carrying executable flags, not callable code: its three named
blobs have no current references and its input has no relocations.

No new allocated-overlap area or multiplicity appears. The existing callback
overlap remains: rawo21 `.data` still covers the callback reservation, now shifted
by76 bytes with `.data_rest`. Exact ranges, all section metadata changes, other
still-wrong GP target movements and every spill input move are in the JSON.

This was read-only: no builds, production writes, object edits or instruction
rewrites. It validates this private combined link and its bounded improvements,
not a fully native-layout/runnable image or complete source restoration.
