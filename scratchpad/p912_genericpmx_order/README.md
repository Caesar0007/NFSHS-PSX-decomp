# P912 GenericPMX native declaration order — verified source proposal

Production is untouched. `inputs/before.cpp` freezes its existing mixed-EOL state;
the final candidate preserves the entire function/body/tail byte-for-byte,
including those line endings. Only the ownership comment/caption and seven array
declarations change. The caption now explicitly retains the unproved pmx_height
carrier; this is not a full original-source or SLD seal.

## Primary native order

Typed SYM27bd72..27be86, ROM and complete CPE coverage establish the1304-byte
initialized `.data` owner80112B2C..80113044:

| Array | Native offset | Bytes | Before offset |
|---|---:|---:|---:|
|gDLPixmap[10]|0|40|0|
|gSparkHPixmap[6]|40|24|116|
|gStartUpPixmap[4]|64|16|140|
|gWeatherPixmap[3]|80|12|156|
|gFlarePixmap[3]|92|12|40|
|gLightningPixmap[16]|104|64|52|
|gPixmaps[71]|168|1136|168|

The first six arrays contain Draw_tPixMap pointers; the last contains71 native
16-byte Draw_tPixMap objects. All seven are GLOBAL/default visibility, with no
data relocation. Zero payload equality alone hid the five wrong named offsets.
The old 80112AE0/Flare-before-Spark comment was not authoritative and is corrected.
Existing `.sdata` declarations and all literal pools remain unchanged.

## Verification

- Fresh baseline and final:1/1 PASS,593 instructions, all18 branches exact.
- Every executable/data payload and section metadata schema is identical.
- Symbol differences are confined to the seven-array ordering, five documented
  value changes and the exact scratch STT_FILE path. Exactly16 relocation tuples
  reflect those changed symbol values. All relocation names/kinds/sites, all
  other symbol entities, and every implicit addend are preserved.
- All30 own data-reference words resolve through **one native section base plus
  the actual emitted array offset** to the raw oracle, with correct HI/LO carry.
  No per-symbol forced-native aliases were used to conceal the original order.
- Complete local definitions, lexical scopes and compiler-label graphs are
  unchanged. Native SLD remains0 merges/1377 splits; no new bad pair is introduced.
- No new names, asm, volatile, padding, flags or compiler-output rewrites.

## Eventual owner integration boundary

Current raw `data_8010CCD4_r09.data.s.o` has only1304 bytes of program storage,
in `.data.r09_pre`, plus tool metadata. It has no relocations, so a validated
whole-file reconstruction-lane exclusion needs no additional split.

It has eight raw labels, not seven: D_80112B84 is the third pointer of the native
gWeatherPixmap[3]. The raw gWeather label covers eight bytes and the D alias the
remaining four. There are zero live reconstruction references to D_80112B84;
the Weather_CreateSplat oracle still uses it, so the oracle lane must retain it.

There are46 live named references across six objects: GenericPMX30, sfx6,
weather4, draww2, flare2, hrzsku2. Exact entries are in `final_receipt.json`.
Native owner/link integration is not performed here; p869 has received the
verified candidate inputs for that separate combined audit.

## Frozen inputs and patch

- Production baseline SHA256:
  `a5195d346379cbcdafd21b8c35ff621583d23e07f7c030d41d663a2d54f79521`.
- Final `inputs/final.cpp` SHA256:
  `3dfd882a993089952a9e6cde0337312c288f733858abe43b28997ec54b0688df`.
- Final object path:
  `final/objects/scratchpad/p912_genericpmx_order/inputs/final.cpp.o`.
- Object SHA256:
  `b100eafdf8320c14bb40fbf874ac2763d138ca512275b4d045457bfe43ec90f3`.
- Current profile G8; `.data` alignment4, flags3, size1304.
- Apply-ready patch: `proposed.patch`. Parent should apply only these hunks,
  preserving the unrelated working-tree EOL state; do not replace the whole file.

`final_receipt.json`, `final.json`, both prior stages and all debug inputs remain
frozen. Existing pmx_height and the substantial SLD/body recovery debt remain.
