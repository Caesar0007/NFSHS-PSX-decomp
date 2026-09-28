# NFS4 per-track auxiliary files: `.KIL`, `.FOG`, `.BIN` (TrackSpec), `.ENV`, `.COP`, `.QBE`, `.QCR`, `.AUD`, `A.VIV`, replay cameras `.rho`, scenes `.scn`; global `ZTRACK.DAT`, `ZTRAFCFG.DAT`, `ZFETRK.TRK`, `ZTOURN.TRN`, `ZSFX*.PSH`, `ZNIGHT.PSH`

Games: NFS4 ★★★. Reference data: pristine files from the retail image. All are small and little-endian;
`.ENV` is text and `.QBE`/`.QCR` are Huffman-packed. Every claim below was checked on every
instance on the disc.

## `.KIL` — object kill list ★★★
Only tracks 04 (276 entries) and 07 (81 entries) have one. Loaded by `KillFile_OpenRead` /
`Track_LoadObjectKillData` (`track.cpp:1043-1136`) right after the GRP.

| Off | Type | Field |
|-----|------|-------|
| 0 | i32 | entry count |
| 4 + 8i | i32 | `chunkInd` |
| 8 + 8i | i32 | `objectInd` — index into that chunk's `0x03` instance list |

Effect of each entry: the instance's `type` gets bit `0x80` (removed), and every sim object in the same
chunk within XZ distance `0x1999` of the instance is retyped to `0x10`. All 357 retail entries resolve
to existing instances.

## `.FOG` — fog trigger keys ★★★
Present for tracks 00 (plus `N`/`S`/`W` variants) and 02 only; other tracks have no fog file.
Variant choice (`Fog_ReadFogKeys`, `textureprocess.cpp`): `S` if night and weather, else `N` if night,
else `W` if weather, else the base file.

| Off | Type | Field |
|-----|------|-------|
| 0 | i32 | `numKeys`; must be < 32, otherwise the file is ignored |
| 4 + 8i | i32 | `slice` — track slice where the key starts |
| 8 + 8i | i32 | `distance` — fog distance (stored as i16) |

Files are a fixed 260 bytes (a 32-slot table); unused slots follow the used keys. Keys go into a
slice-sorted circular list, and a key whose slice already exists is dropped (`Fog_AddKey`). Retail keys
are sorted and all slices are valid.
✗ Earlier notes described a key as `{distance, colorOrAttr}`; the loader proves it is `{slice, distance}`.

## `.BIN` — TrackSpec (sky, fog, horizon, weather, night, colour) ★★★
Loaded by `TrackSpec_Read` (`trackspec.cpp`). Header `CTrackSpecHeader` {i32 version = 108;
i32 num_spec}, then `num_spec` × `CTrackSpec` (0x108 = 264 bytes each). File size = 8 + 264·num_spec
on every track.

Selection: `TrackSpec_Load(weather, night)` reads spec `[[0, 1], [2, 3]][weather][night]`, i.e.
0 = clear day, 1 = clear night, 2 = weather day, 3 = weather night. Tracks 05 and 07 contain a fifth
spec that this path never selects.

`CTrackSpec` layout (all i32 unless noted; `CVECTOR` = u8 r, g, b, cd):

| Off | Field |
|-----|-------|
| 0 | i16 × 8: `fogstate`, `weatherstate`, `horizonstate`, `skystate`, `nightstate`, `depthcuestate`, `worldcolorstate`, pad — enable flags for the blocks below |
| 16 | fog: `contrast`; 20 `color` (CVECTOR); 24 `start`; 28 `dist2base` |
| 32 | weather: `type`; 36 `intensity_limit` |
| 40 | horizon: `mirror`; 44 `angle`; 48 `yoffset`; 52 `height`; 56 `frontColor[2]`; 64 `backColor[2]`; 72 `ringPMX[16]` (char) |
| 88 | sky: `type`; 92 `flags`; 96 `frontcolors[5]`; 116 `backcolors[5]`; 136 `clearcolor`; 140 `sunAngleInSky`; 144 `sunHeightInSky`; 148 `moonAngleInSky`; 152 `moonHeightInSky`; 156 `numStars`; 160 `starAngleLow`; 164 `starAngleHigh`; 168 `starBrightMin`; 172 `starBrightMax`; 176 `starBaseColor`; 180 `starRandomSeed`; 184 `sunBeamColor`; 188 `sunHaloColor`; 192 `yoffset`; 196 `cloudIndices[5][4]` (char); 216 `ringAngles[5]` |
| 236 | night: `nightcolor` (CVECTOR) |
| 240 | depth cue: `color` (CVECTOR); 244 `distance` |
| 248 | world colour: `contrast`; 252 `contrast_color` (CVECTOR); 256 i16 `worldR`, `worldG`, `worldB`, `type` |

Example (track 00): the state flags match the slot meaning — spec 1 has `nightstate = 1`, spec 2 has
`weatherstate = 1`, spec 3 has both.
Field semantics beyond the names come from the sky/horizon/fog renderers and are still to be traced.

## `.ENV` — car environment-map and shadow zones (text) ★★★
Despite the extension, this is a **plain-text script** read by `DrawC_ReadLightingData` (`drawc.cpp`)
through `Risk_ReadNextValue` (`color.cpp`). The reader skips every character that is not part of a
number, and skips from any `/` to the next `/`, so `/* ... */` comments work (as would any text between
two slashes). Numbers are decimal, optionally negative, separated by anything.

Structure:
```
<envCount>
envCount × { slice, tex, extra, quad }     -- a slice of -1 ends the list early
<shadowCount>
shadowCount × { slice, tex, extra, quad }  -- same
```
Each entry is stored as {i16 slice, i16 tex, i16 extra}, where extra = `(third << 8) + fourth`; a
negative slice is stored as `0x7FFF`, ends the list, and is included in the count. Per the file's own
header comment, `extra` is ignored when `quad` is 0.
Entries are slice ranges along the track where the car reflection map (`tex`) or car shadow changes.
All 10 retail files parse with no leftover numbers. In `ZTR02.ENV` the shadow count is 21 but the `-1`
terminator arrives after 19 entries, so the terminator, not the count, bounds the list.

## `.COP` — cop / pursuit triggers ★★★
Loaded by `AICop_StartUp` (`aicop.cpp`, `"%sTr%02d.cop"`, via the compressed-capable `loadfileadrz`;
retail files are stored raw) and parsed by `AITrigger_TriggerManager::Init` (`aitriger.cpp`).

`i32 count`, then `count` variable-length records, each starting `{i32 type; i32 slice}`:

| Type | Struct | Size | Fields after type, slice |
|------|--------|------|--------------------------|
| 1 | `trigger_roadblock_t` | 20 | i32 dir, numCars, spikeBelt (`aih_cop.cpp:446` creates roadblocks with type 1) |
| 2 | `trigger_simple_t` | 20 | i32 dir, side, moving (★★ by elimination: the other 20-byte trigger) |
| 3 | `trigger_offroad_t` | 72 | i32 dir; coorddef position; matrixtdef orientation (3×3 i32); i32 maxSpeed, releaseTime, endSlice |
| 5 | `trigger_trafficPath_t` | 64 + 20·numPoints | i32 dir; matrixtdef orientation; i32 maxSpeed, releaseTime, numPoints; pointer slot (set to +0x40 at load); then numPoints × {coorddef position; i32 targetSpeed, waitTime} |

`trigger_trafficAccident_t` (56 B) exists in the code, but the file loader has no size for it, so it
cannot come from a `.COP`. After loading, triggers are sorted by slice.
Loader hazards: an unknown type returns size 0, so the cursor never advances and the same record is
inserted again for every remaining count; the trigger table holds 100 entries with no bound check.
Retail census: 10 files, 18–55 triggers, types 1/2/3 only, every file consumed exactly.

## `.QBE` / `.QCR` — AI best line and track curvature ★★★
Loaded by `AIDataRecord_t::Load` → `loadpackadrz` (`aidatarecord.cpp`). Both are Q-packed (first bytes
`32 FB` = EA Huffman with 1-D delta; bytes 2–4 = big-endian unpacked size). The uncompressed
development names `.bes` / `.crv` are selected when `recordMethod_ != 0`; they are not on the disc.

| File | Record | Unpacked | Element | Meaning |
|------|--------|----------|---------|---------|
| `.QBE` | `AIDataRecord_BestLine_t` | `gNumSlices` bytes | s8 per slice | racing-line lateral offset: `AI_CalcBestLineMerits` sets preferredLateralPosition = `fixedmult(personality[+0x44], s8 << 14)` minus lane slack |
| `.QCR` | `AIDataRecord_TrackCurve_t` | `gNumSlices + 1` bytes | u8 per slice | curvature; drives the per-car 256-entry `.qcs` curve-speed table (`AIDataRecord_CurveSpeedTable_t`, |curve| clamped to 255) |

Census: `.QCR` unpacked size = slices + 1 on all 10 tracks; `.QBE` = slices on 9 tracks, and track 03
has one extra byte (974 for 973 slices).
The old Python port `unhuff_port.py` fails on these files; use `tools/nfs4_codecs.py`
(see [NFS4_Q_CODECS.md](NFS4_Q_CODECS.md)).

## `.AUD` — ambient positional sounds ★★★
Four per track: `ZTR<NN>00..03.AUD`. `BWorld` picks index `(night ? 1 : 0) + (weather ? 2 : 0)`
(`bworld.cpp:1157-1161`), i.e. 00 clear day, 01 clear night, 02 weather day, 03 weather night — the same
2×2 scheme as TrackSpec. Loaded whole by `AudList_LoadAudioFile` (`audedit.cpp`) into `gGameAudioList`;
consumed by `audiotrk.cpp` (PreLoad, per-frame ambient update scanning a quarter of the list per tick).

Header `CAudioList` (16 B): i32 `id` (= the file index), i32 `numElements`, i32 `slice`, i32
`versionNumber` (= 1). Then `numElements` × `AudioElem` (24 B):

| Off | Type | Field |
|-----|------|-------|
| 0 | i32 × 3 | `cp` — world position |
| 12 | u16 | `nextDelay` — runtime countdown, zeroed at reset |
| 14 | i8 | `patchID` — sound-bank patch |
| 15 | i8 | `fadeIn` |
| 16 | i16 | `range` |
| 18 | i8 | `minDelay` |
| 19 | i8 | `randomDelay` |
| 20 | i8 | `type` |
| 21 | s8 | `chan` — runtime channel, reset to −1 |
| 22 | i8 | `minRepeat` |
| 23 | i8 | `randomRepeat` |

Census: all 40 files satisfy size = 16 + 24·numElements, `id` = file index, version = 1.

## `ZTR<NN>A.VIV` — canned animation scripts (`.can`) ★★★
Loaded by `Anim_InitSystem` (`anim.cpp`) with `loadfileadrz`, then copied into the FMV decode buffer
(`Platform_GetDCTBuffer`, tag "animScripts"), which is idle during a race.

Container = EA's compact **`C0FB`** archive (not BIGF), handled by `locatebig` (`eaclib/.../locatbig.c`):
big-endian header {u16 magic `0xC0FB`, u16 header length (128), u16 count}, then `count` entries of
{u24 BE offset, u24 BE size, NUL-terminated name}.

Entries are looked up as `tr00a00.can` … `tr00a09.can` into `animScripts[0..9]`. **The names are
hard-coded with `tr00` for every track** (the loader's `strstr(trackName, "Tr")` result is discarded),
and the retail archives indeed all use `tr00a..` names. Every retail archive has exactly 7 entries —
slots 00, 01, 02, 03, 06, 07, 09 — so slots 04, 05 and 08 are always NULL.

Each `.can` is one `Trk_AnimateInst` keyframe record (GRP §7: 12-byte header + `count` × 20-byte
`Anim_tFrame`); retail: type 3, objectIndex 0, `size = 12 + 20·count` on every entry. The scripts are
generic and shared across tracks (identical counts on every track). Users: the camera's finish sequence
reads slot 6 (`camera.cpp:1032`); breakable objects play `animParms->baseAnim` onward (`object.cpp:1185`).
After loading, persistent type 3/7 instances with a non-zero `objectIndex` are registered in
`Anim_gInstanceFromIndex[objectIndex]` — `objectIndex` is the animation link ID.

## Replay cameras `tr<NN>.rho` / `tr<NN>r.rho` (in `ZCAMERA.VIV`) ★★★
`Replay_LoadCameraFile` (`replay.cpp`) mounts `camera.viv` (a BIGF archive) and loads `tr%02d.rho`, or
`tr%02dr.rho` for a reversed track. Name lookup is case-insensitive; the archive mixes `TR00.rho` and
`tr02.rho`, and also contains `TR01.rho` for the unreleased track 01.

The game copies exactly **32 × `Camera_tCamSlot`** (32 B each = 1024 bytes):

| Off | Type | Field |
|-----|------|-------|
| 0 | u8 | `mode` (census 3, 4, 8–12, 15) |
| 1 | bitfield | `track` (1 bit), `zoom` (2 bits), `splineMode` (3 bits) |
| 2 | i16 | `fov` — 0 marks an empty slot (its `slice` is forced to −1) |
| 4 | i32 × 3 | `pos` |
| 16 | i32 | `height` |
| 20 | i32 | `splineOffset` |
| 24 | i16 × 3 | `euler` |
| 30 | i16 | `slice` — slot becomes active from this slice |

After loading, valid slots are bubble-sorted by slice (retail files are already sorted). 15 of the 21
files are 2048 bytes: their second half holds more non-zero slot data that the game never reads, which
suggests a 64-slot editor format. The 1024-byte files are exactly 32 slots.

## Scenes `tr<NN><MM>.scn` (in `ZSCENE.VIV`) ★★★
`Scene_LoadSceneFile` (`scene.cpp`) mounts `scene.viv` and loads `tr%02d%02d.scn` for the current
scene number, chosen in `bworld.cpp:1088-1116`: a random 0 or 1, plus 10 in weather, else plus 20 with
traffic; network, tournament and replay races use 99 (no such file). The scene is active between a
random `SceneStartLap` and `SceneEndLap`.
Retail archive: 42 files = tracks 00 and 02–07 × scene numbers 00, 01, 10, 11, 20, 21; tracks 08–10 have
none.

Header `CSceneList` (16 B): i32 `id`, `numElements`, `slice` (becomes `Object_customSliceNum`),
`versionNumber` (= 1). Then `numElements` × `SceneElem`, walked with a **fixed 92-byte stride** (the
record's own `size` field is 0 on disc and unused):

| Off | Type | Field |
|-----|------|-------|
| 0 | i32 | `type` — only 0, 1, 2 become custom objects (`Object_AddCustomObject`) |
| 4 | i32 | `size` (0) |
| 8 | i32 | `committed` |
| 12 | i32 | `visible` |
| 16 | i32 × 3 | `cp` — position |
| 28 | i32 | `height` |
| 32 | i32 × 9 | `orient` — 3×3 matrix |
| 68 | i32 | `subType` |
| 72 | i32 | `subTypeIndex` |
| 76 | i32 × 4 | `scalar1`..`scalar4` |

Files are padded to 8192 bytes. Census (type, subType): (0, 0) 84, (0, 1) 185, (1, 0) 15, (2, 22) 66.

## `ZTRACK.DAT` — car shadow and env-map colour per track ★★★
Text, C comments, read with `Risk_ReadNextValue` by `R3DCcar_ReadTrackShadow` (`r3dcar.cpp:422`). The header comment reads "Track car shadow and horizon colour info"; the block order is `[normal], [weather], [night], [weather & night]`. The file holds 48 records (TR00–TR11, 4 each) of 6 numbers: `shadow r, g, b, env r, g, b` (0 = none). The game reads records 0…`track·4 + Weather + Time·2` and keeps the last: the first triple becomes `R3DCar_shadowColour` and the second `R3DCar_eMapColour` (the car env-map tint; the file comment says "horizon").

## `ZTRAFCFG.DAT` — AI physics config (not loaded) ★★★
108 bytes. `AIInit_LoadConfigs` (`aiinit.cpp:206`) formats `"%strafcfg.dat"` but then reads the compiled-in copy `trafcfg[108]` (@0x8010D560; byte-identical to the file) through `Udff_Opena` / `Udff_GetInt`. The layout is 27 ints: `latvelcalc_lookahead, min_lookahead, max_lookahead, look_ahead_factor, skid_value`, then two 11-int models (IC, OOC) `{dlpos_to_dlvel, max_dlvel, dlvel_to_clacc, max_clacc, dangle_to_dav, max_dav, dav_to_aa, max_aa, vel_limit_range, lat_vel_limit_factor, ang_vel_limit_factor}`.

## `ZFETRK.TRK` — front-end track list ★★★
`{u32 count, tTrackInformation[count]}`, 48-byte records (`shared/tTrackInformation.h`), copied whole (`fetracks.cpp:86`). The record fields are:
- `char trackID`, `u8 simNumber, difficulty, available, isEgg, lengthKM, lengthMiles, numMoments`;
- `char shapeName[8]` (`yTR06`), `splineName[8]` (`TR06`);
- `char country, dispatch, reverseCall, language`, `char trafficCars[6]`;
- `i16 TX, TY, SX, SY`, `u8 speedoCountry, pad`, `i32 rotate`.

Retail: 10 tracks, 484 bytes exact. `available` sets `fAvailableTracks[id]`, and `isEgg == 0` makes the track viewable. `ZFETRKB.TRK` (never loaded) differs only in the unlock set.

## `ZTOURN.TRN` — tournaments ★★★
Loaded by `fetourn.cpp:71`:
- `u8 finishPoints[6]` (8, 6, 4, 3, 2, 1), then `u8 tierCount`;
- then per tier: `tTierInfo` (12 B `{numTournaments, descriptionID, tournOffset, pad, reserved[8]}`) followed by its tournaments;
- each tournament is `tTourneyInfo` (84 B: id, track count/offset, opponent class, traffic, knockout, car count, award car/model/upgrades, activate/required flags, prizes[6], entrance fee, personalities/opponent cars/upgrades[5], laps…), followed by its tracks;
- each track is `tTrackInfo` (40 B `{i8 track, direction, mirrored, timeOfDay, weather, random, situations, pad, i32 prize[6], u32 difficulty, reserved[4]}`).

Retail: 3 tiers, 43 tournaments, 60 races, and the walk ends exactly at 6,055 bytes. `ZTOURNB.TRN` / `ZTOURNC.TRN` (never loaded) differ in 13 / 41 bytes.

## `ZSFX*.PSH` and `ZNIGHT.PSH` — track-effect shapes ★★★
- `genericpmx.cpp` loads from `ZSFX.PSH` the shapes `LIN0`–`LIN9` (road-line textures: `gDLPixmap[type]` of GRP §9), `spik` (spike belt), `DEBG`, `SHAD` (car shadow) and `SKD0/1` (skid marks). Track 04 uses `ZSFX4.PSH`, and `ZSFX4W.PSH` in wet weather. The file's other shapes (SMX*, SMOK, DIRT, GRX*, …) are particle textures loaded elsewhere.
- `ZNIGHT.PSH` (night races only, `night.cpp:1091`) has one shape, `nght`: an 8-bit 64×64 image whose pixel bytes are used as a **headlight light-pattern table** (`Night_gNightTbl` = shape + 0x10). The cell for a point relative to the car is `(|z| >> 5)·64 + ((x + 0x400) >> 5)`, for x in ±0x400 and |z| < 0x800. The byte then selects the night or cop-light colour (`Night_NightCalc`, `draww.cpp:1265`).
