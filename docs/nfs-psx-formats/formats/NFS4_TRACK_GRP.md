# NFS4 `.GRP` — track geometry container (SerializedGroup)

Games: NFS4 ★★★ | NFS1/2/3/5: not used (NFS3 uses the NFS2 TRK set). Extension `.GRP`, no magic
(first node has `m_type = 0x1E`). Census: 40 files (10 tracks × 4 variants), 4,856 chunks. Every
structural claim marked ★★★ below holds on all of them (checked by `tools/nfs4_grp_validate.py`).

Loaders (nfs4-decomp recon): `SerializedGroup::*` in `group.cpp`; `Track_Init` `track.cpp:870`;
`Track_InitPersistentData` `track.cpp:811`; `Chunk::InstanceGroup` `chunk.cpp` (@0x8008B3FC);
renderer `DrawW_DoTrough`, `DrawW_StripDraw_High`, `DrawW_kCtrlWorld_High`, `DrawW_DrawQuad` in
`game/psx/draww.cpp`.

## 1. Container format ★★★
Every node is a 16-byte little-endian header followed by its payload.

| Off | Type | Field | Note |
|-----|------|-------|------|
| 0 | i32 | `m_type` | node type (tables below) |
| 4 | i32 | `m_length` | total size including this header |
| 8 | u32 | `dummy` | always `0xCDCDCDCD` (MSVC debug-heap fill from EA's exporter; never read) |
| 12 | i32 | `m_num_elements` | child count for containers; for leaves usually the element count (exceptions noted) |

- A container's children follow at +16, back to back.
- `LocateGroupType` rounds each child's `m_length` up to a multiple of 4 **in place** while walking,
  so the loaded file is mutated in RAM.
- `CreateLiteGroup` copies a leaf out as a 4-byte `m_num_elements` plus payload (a "lite group"); the
  runtime never keeps the 16-byte header.
- Container types: `0x1E` root, `0x1D` chunk, `0x17` chunk geometry, `0x21` persistent data.

## 2. Top level (children of root `0x1E`) ★★★
Order on disc, identical in all 40 files: `0x1F`, `0x20`, `chunkCount` × `0x1D`, `0x21`, `0x23` —
the light table is always the last group and ends exactly at end of file. (The loader finds every group
by type, so the order is not required by the code.)

| Type | Name | Payload | Consumer |
|------|------|---------|----------|
| `0x1F` | TrackHeader | 32 B, see §3 | `Track_header` |
| `0x20` | chunk centers | `chunkCount` × `coorddef` {i32 x, y, z} (12 B) | `Chunk_chunkCenters` |
| `0x23` | light table | N × `CVECTOR` (4 B); N = (m_length−16)/4, observed 20–212 | copied to `Chunk_lightTable` |
| `0x21` | persistent data | container, §6 | `Track_InitPersistentData` |
| `0x1D` | chunk | container, §4 | `Chunk::InstanceGroup` |

**Light-table quirk ★★★ (runtime-confirmed):** `Track_Init` always copies 1024 bytes (256 CVECTORs)
from the payload into the 0x404-byte `lighttbl` buffer, whatever N is. Because `0x23` is the last group,
the copy reads (1024 − 4N) bytes **past the end of the loaded file** into unrelated heap memory (track 06:
288 bytes). Harmless in retail: `Chunk_numLight` holds the true N and no vertex indexes beyond it.

## 3. TrackHeader (`0x1F`, 32 B) ★★★ (census)
| Off | Field | Census |
|-----|-------|--------|
| 0 | `type` | always 666 |
| 4 | `version` | always 13 |
| 8 | `maxMetaChunkSize` | 40,260–52,176 |
| 12 | `maxGeomCollSize` | 6,564–9,484 |
| 16 | `maxFullSize` | 125,640–226,140 |
| 20 | `maxSplitSize` | 197,056–258,272 |
| 24 | `metaChunkCount` | = ceil(chunkCount / 8) in every file |
| 28 | `chunkCount` | = number of `0x1D` groups = number of chunk centers (104–136) |

**The game reads only `chunkCount`** (6 uses, all in `Track_Init`; an exhaustive search of the recon
finds no other field access). `type`, `version`, the four `max*` budgets and `metaChunkCount` are
exporter metadata, and the loader never validates `type` or `version`. A re-writer only needs to keep
`chunkCount` correct.

## 4. Chunk (`0x1D`) children ★★★
| Type | Name | Element | Size | Loaded into (`Chunk` field) |
|------|------|---------|------|-----------------------------|
| `0x1C` | chunk meta | 1 record | 48 B, §4.1 | `firstSimSliceInd`, `chunkInd`, `boundPts[4]`, `chunkboundPts[4]` |
| `0x04` | visibility list | u16 | 2 | copied to `Track_gInViewList` (§5) |
| `0x03` | object instances | variable-size records | §7 | `objInstanceBuf` |
| `0x15` | special object instances | as `0x03` | | `objSpecialInstanceBuf` (never present on disc) |
| `0x0B` | sim objects | `Trk_SimObject` | 20 | `simObjBuf` |
| `0x0A` | glare / light flares | `Trk_SFX`, §10 | 16 | `sfxBuf` |
| `0x05` | sim quads | `Trk_NewSimQuad` {u8 surface} | 1 | `simQuadBuf` |
| `0x06` | sim slices | `Trk_NewSimSlice` {u8 stripIndex, quadCount, simquadIndex, simquadCount, simquadStartIndex} | 5 | `simSliceBuf` |
| `0x09` | center/edge lines | `Trk_Line`, §9 | 4 | `lineBuf` |
| `0x17` | geometry | container, §4.2 | | |

`Trk_SimObject` (20 B): i32 point[3]; i16 radius, serialNum; u8 topCRAP, bottomCRAP, instIndex, type.

### 4.1 Chunk meta (`0x1C`, 48 B)
| Off | Type | Field | Tag |
|-----|------|-------|-----|
| 0 | i32 | value A, repeated at +4 in every chunk | ★★ census; not read by the loader |
| 4 | i32 | A (duplicate) | ★★ unread |
| 8 | i16 | small count, 4–9 | ★★ unread, meaning open |
| 10 | i16 | `firstSimSliceInd` = running sum of the preceding chunks' sim-slice counts | ★★★ |
| 12 | i16 | `chunkInd` = the chunk's own index | ★★★ |
| 14 | i16 | pad | ★★ |
| 16 | RelCoord16[4] {i16 x, z} | `boundPts` | ★★★ loaded |
| 32 | RelCoord16[4] | `chunkboundPts` | ★★★ loaded |

### 4.2 Geometry (`0x17`) children ★★★
| Type | Name | Element | Chunk field |
|------|------|---------|-------------|
| `0x1B` | quad counts | 12 × i16 (24 B), below | `quadCounts[6]` (low bytes of s[6..11]) |
| `0x18` | vertices | `CCOORD16` {i16 x, y, z, light} (8 B); count = payload/8 = s[5]; `m_num_elements` always 1 | `vertexBuf` |
| `0x1A` | strips, full res | variable, §4.3 | `stripBuf` |
| `0x25` | strips, low res | same format | `lorezstripBuf` |
| `0x19` | road quads | `Trk_Quad` (6 B), §4.4 | `renderQuads[4]` |
| `0x27` | object vertices | `CCOORD16` | `objVertexBuf` |
| `0x28` | object quads | `Trk_Quad`, count = c2 | `objQuadBuf` |
| `0x29` | object-instance quads | `Trk_Quad`, count = c3 | `objQuadInstanceBuf` |

Quad-count block `0x1B` (12 × i16):
- s[0]: about 1,600–3,000; not read by NFS4. Lineage (★★): in NFS3 the same 24-byte header is live, and s[0..1]
  is a u32 offset from the header to the chunk's sub-block table ([NFS3_TRACK_FILES.md](NFS3_TRACK_FILES.md) §1.4.1).
- s[1] = s[2] = 0 in every chunk.
- s[3] ≤ s[4] ≤ s[5], and **s[5] = the chunk's vertex count** in every chunk.
- s[6..11] = the counts c0..c5 used below.

**Vertex colour ★★★:** `CCOORD16.light` is an index into the track light table (`0x23`); each quad
corner's colour is `Chunk_lightTable[vertex.light]` (Gouraud shading, `DrawW_DrawQuad`). Census: every
vertex index in all 40 files is below that file's own table length (about 940k vertices), and the
largest tables have exactly 212 entries, apparently an exporter limit.

**Coordinates:** vertices are chunk-local. `DrawW_DoTrough` sets the translation to
`(chunkCenter − camera) >> 10`, so world = chunkCenter + (vertex << 10). Vertex indices are u8
everywhere, which caps a chunk at 256 vertices (census maximum 252).

### 4.3 Strip record ★★★ (80,240 strips checked)
| Off | Type | Field |
|-----|------|-------|
| 0 | u8 | `topVert` |
| 1 | u8 | `botVert` |
| 2 | u8 | `quadCount` |
| 3 | u8 | `size` = 4 + 2·quadCount (exact for every strip) |
| 4 | u16 × quadCount | material index per quad |

The group's `m_num_elements` is the strip count. Quad *i* of a strip uses vertices
`{top+i+1, top+i, bot+i, bot+i+1}` (`DrawW_StripDraw_High`), so a strip is a band of quads between two
vertex rows. When `geomRez != 0` the renderer draws `0x1A` and then the c5 quads; when `geomRez == 0`
it draws `0x25`.

### 4.4 Road quads (`0x19`) ★★★
`Trk_Quad` = {i16 material, u8 aPoints[4]}. The payload holds four partitions in this order:
`[c0][c1][c4][c5]` (`renderQuads[0..3]`, `chunk.cpp`). All vertex and material indices inside these
partitions are valid in every chunk.

**Exporter garbage ★★★:** in 1,736 chunks the payload is longer by exactly `c2 + c3` quads. The game
never addresses those bytes, and every one of those tails contains MSVC heap fill (`FD FD FD FD` or
`CD CD`). The exporter sized the buffer for all six counts but wrote only the four partitions the game
uses. A re-writer can drop them. Lineage (★★): NFS3 fills all six partitions (low / medium / high detail ×
{main, extra}); NFS4 dropped the medium level c2/c3 but the exporter still sized for it.

A quad's material is a plain signed index into the material table (§6), with no flag bits
(`DrawW_DrawQuad`).

## 5. Visibility list (`0x04`) ★★★, plus a retail bug
- Each entry is a u16: bits 0–9 = neighbour chunk index (always < chunkCount on disc); bits 10–15 =
  category (observed even values 0–20; meaning open).
- `Track_Init` keeps up to 36 entries per chunk, drops any whose index ≥ chunkCount, and pads with
  `0x3FF`.

**Bug (runtime-confirmed):** the list is allocated at 72 bytes per chunk (`chunkCount * 0x48`, room
for 36 entries), but rows are written and read at a 64-byte stride (`i << 6` in `Track_Init`,
`sourceChunkInd * 32` shorts in `bworld.cpp`). Up to 36 entries are stored, so entries 32–35 of chunk
*i* are overwritten by chunk *i+1*'s first four, and the last `8·chunkCount − 8` bytes of the allocation
are never written. Retail data has 8 chunks with 36 entries; all others have ≤ 32.

Category bits (from `SetupChunkBuildList`, `bworld.cpp`; census uses only these four):

| Bit | Effect on the neighbour |
|-----|-------------------------|
| `0x0800` | never drawn from this chunk; also treated as not visible by the line-of-sight test |
| `0x1000` | **midground-object mask**, read by position, not by neighbour: see below |
| `0x2000` | build-enable bit 0x01 cleared: its road geometry is not drawn (`DrawW_DoTrough`) |
| `0x4000` | build-enable bit 0x02 cleared: its objects are not drawn (`DrawW_DoObjects`) |

Build-enable bit 0x04 (lines) is set only within the context's line distance.

**Midground mask (bit 12) ★★★.** When drawing the midground objects (`0x24`), `DrawW_DoObjects` passes
the camera chunk's own visibility row as a per-object mask (`gChunkObjInfo.visList =
Track_gInViewList + chunk * 64 bytes`); `DrawW_BuildObjectFacets` draws midground object *i* only if
row entry *i* has bit `0x1000` set. So each entry does double duty: bits 0–9 name a neighbour chunk,
bit 12 gates midground object number *i*. Consequences: a chunk whose row has fewer entries than there
are midground objects cannot show the remaining objects (the `0x3FF` padding has bit 12 clear), and
dropping an out-of-range entry at load would shift the mask (never happens in retail).
Census: files without midground objects never set bit 12; 16 files set it only at positions below the
midground-object count; 8 files (two tracks, all variants) have stale bits past the count, which are
never read because the loop stops at the object count.

## 6. Persistent group (`0x21`) children ★★★
| Type | Name | Payload | Consumer |
|------|------|---------|----------|
| `0x02` | materials | (m_length−16)/10 × `Trk_Material`, padded to 4 | `Track_LinkMaterials` |
| `0x0F` | track slices | n × `Trk_NewSlice` (32 B), §8 | `BWorldSm_Init` → `BWorldSm_slices`, `gNumSlices` |
| `0x07` | object instances (persistent) | variable records, §7 | `gPersistObjInst` |
| `0x24` | midground object instances | variable records | `gPersistMidgroundObjInst` (optional) |
| `0x08` | object definitions | `Trk_ObjectDef` {i16 id; u8 vertexCount, quadCount} + data | `gPersistObjDef` |
| `0x26` | object-definition offsets | one i32 per definition, prefix-summed into pointers by `CalcObjDefPtrs` | `Track_gObjDefs` |

`Trk_Material` (10 B):

| Off | Type | Field |
|-----|------|-------|
| 0 | i16 | `shapeIndex` — texture index in the track PSH |
| 2 | u8 | `flag` — 0x02 multi-palette, 0x04 animated-texture controller, 0x80 scrolling-UV controller; 0x08 set at runtime for mipmapped materials |
| 3 | u8 | `uvFlag` — flip/rotate bits; any of mask 0x5E creates a derived pixmap |
| 4 | u8 × 3 | r, g, b tint |
| 7 | i8 | `textureCount` — animation frames |
| 8 | u8 | `interval` — animation interval, or palette number when flag & 0x02 |
| 9 | u8 | pad |

## 7. Objects ★★★

### 7.1 Object definitions (`0x08`) and offsets (`0x26`)
A definition is `Trk_ObjectDef` {i16 id; u8 vertexCount; u8 quadCount}, then `vertexCount` ×
`CCOORD16`, then `quadCount` × `Trk_Quad` (indices into the definition's own vertices), padded to 4 bytes.
Definitions are packed back to back; `m_num_elements` is the definition count. All 40 files tile exactly.

`0x26` holds one i32 per definition (its own `m_num_elements` is 1): slot 0 is 0, slot *i* is the padded
byte size of definition *i−1*. `CalcObjDefPtrs` overwrites slot 0 with the base address and prefix-sums
the rest in place, giving `Track_gObjDefs[i]`. `id != −1` marks a definition whose persistent instances
are disabled at load (`InvalidatePersistentCollideBoomObjects` sets their `type` to 0).

### 7.2 Instance records (in `0x03` chunk instances, `0x07` persistent, `0x24` midground)
Variable length, walked by `size`. Common 8-byte header:

| Off | Type | Field | Meaning |
|-----|------|-------|---------|
| 0 | i16 | `size` | record length in bytes |
| 2 | u8 | `type` | layout/behaviour, table below |
| 3 | u8 | `objectIndex` | animation trigger ID for types 3/7 (0 = none), below |
| 4 | u8 | `zoffset` | depth-sort bias selector, below |
| 5 | u8 | `flags` | bit 0x02 on animated types: draw a headlight streak along −Z |
| 6 | i16 | `pad` | **object-definition index** into `Track_gObjDefs` (the recon's field name hides this) |

| Type | Layout | Sizes on disc | Behaviour (consumer) |
|------|--------|---------------|----------------------|
| 1 | `Trk_SimpleInst`: + i32 x, y, z | 20 | placed, unrotated (`DrawObjectSimple`) |
| 2 | `Trk_CollideBoomInst`: + i32 x, y, z; i16 qx, qy, qz, qw quaternion; i16 sx, sy, sz scale (`<< 8`); u8 simIndex, boomIndex | 36 | rotated and scaled static object |
| 5 | same as 2 | 36 | breakable: tied to sim object `simIndex`; when hit it plays the type-8 parts with the same `boomIndex`, otherwise drawn like type 2 |
| 9 | same header + x, y, z; `qx` = yaw angle, `qz` = X/Z scale, `qy` = Y scale, `qw` = light | 28 | yaw-only object (`xformy`) |
| 3, 7 | `Trk_AnimateInst` (12 B: + i16 count, interval) + `count` × `Anim_tFrame` | 212–4012 | keyframed object (`Anim_GetRotPos`) |
| 8 | `Trk_AnimateBoomInst` (16 B: + count, interval, u8 simIndex, boomIndex, i16 pad2) + frames | 136–436 | debris parts of a breakable object (`AnimScript`, `object.cpp`) |

`Anim_tFrame` (20 B) = i32 x, y, z + i16 qx, qy, qz, qw. Playback: frame = ticks / interval (interval
outside 1–400 falls back to 6), looping over `count − 1` segments, interpolating position and quaternion
between frames. Census: all 766 animated records satisfy `size = header + 20 · count`; all intervals valid.

**`zoffset` ★★★** indexes the fixed EXE table `goffsets[8] = {125, 125, 50, 15, −1, 125, 0, 0}`
(`draww.cpp:70`). The result is the object's ordering-table bias: `otz = depth + offset`
(`DrawW_DrawQuad`), so larger values sort objects further back; −1 selects the midground layer (and
halves coordinates by `>> 2`). It is consulted only when the draw context's own offset is 0 (normal
chunk objects); midground objects are always drawn with −1. Census: chunk instances use 1, 2, 3
(125/50/15), persistent use 2, 3, midground always 4.

**`objectIndex` ★★★ — triggered animations.** For types 3/7 a non-zero `objectIndex` registers the
instance in `Anim_gInstanceFromIndex[objectIndex]` and gives it a clock `animation_timer[objectIndex − 1]`
(`DrawW_GetAnimationTime` / `DrawW_SetAnimationTime`). Each frame the timer starts counting when a
human car's slice is inside that ID's range, plays the animation once (clamped at
`(count − 2) · interval`), and resets once the timer has passed 0xF00 ticks and every human car is
outside the range. Index 0 means free-running on the game clock. The slice ranges are **hard-coded in
the EXE**, only for track 00 (`trk0[9][2]`, e.g. 410–530, 800–850, 815–885) and track 04 (`trk4[10][2]`,
300–440, 705–910); tracks 03 and 07 are forced to free-run. Census matches: triggered IDs exist only
on 00 (1–6, ID 1 used twice) and 04 (1–10); 03 and 07 carry IDs that act only as lookup keys.
Latent bug: `DrawW_DoObjectAnimations` walks 16 slots without a NULL check, reading
`NULL->objectIndex` (RAM byte 3) for empty ones; that byte is 0 in the running game (checked in the
runtime checkpoint), so empty slots are skipped harmlessly.

Where each type occurs on disc: chunk instances use 1, 2, 5, 9; persistent use 1, 3, 7, 8; midground use
1, 3. Midground instances get their definition's vertices shifted right by 2 at load
(`ReduceObjectPrecision`) and their translation shifted to match. That is done once per instance, so a
definition shared by two midground instances would be shrunk twice; no retail track does this.

## 8. Track slices (`0x0F`, `Trk_NewSlice`, 32 B) ★★★
The road centerline as a sequence of cross-sections, used by physics (`bworldSm.cpp`) and AI (`ai.cpp`).

| Off | Type | Field | Meaning |
|-----|------|-------|---------|
| 0 | i32 × 3 | `center` | world position of the slice center |
| 12 | s8 × 3 | `normal` | up vector, unit length scaled to 127 (census 125–127) |
| 15 | s8 × 3 | `forward` | direction of travel, same scaling |
| 18 | s8 × 3 | `right` | lateral vector, same scaling |
| 21 | u8 | `acousticType` | observed 0, 0x33, 0x40, 0x44; **no reader in the code** (dead data) |
| 22 | i16 | `pavedProfile` | road-profile code; compared between slices by AI, turned into a median ("island") sign by `Camera_IslandProfile` |
| 24 | i16 | `leftDrive` | drivable extent to the left; `<< 8` = world units |
| 26 | i16 | `rightDrive` | drivable extent to the right; `<< 8` = world units |
| 28 | u8 | `chunkIndex` | chunk that owns the slice |
| 29 | u8 | `laneCount` | high nibble L = left lanes, low nibble R = right lanes; valid lane indices are `[7−L, 6+R]` (`ai.cpp:372-375,536-539`). Observed 0x11, 0x12, 0x21, 0x22, 0x23, 0x31, 0x32 |
| 30 | u8 | `avgPavedWidthLf` | paved width left; `<< 15` = world units |
| 31 | u8 | `avgPavedWidthRt` | paved width right; `<< 15` = world units |

Proven on all 40 files: the slice count equals the sum of all chunks' `0x06` sim-slice counts, and
slice *i* lies in `[firstSimSliceInd, firstSimSliceInd + count)` of the chunk named by its
`chunkIndex`. So a chunk's `Trk_NewSimSlice` *k* describes global slice `firstSimSliceInd + k`.
Closest-slice searches measure XZ distance as `((p − center) >> 9)²`.

## 9. Lines (`0x09`, `Trk_Line`, 4 B) ★★★
`{u8 firstPoint, u8 slice, u8 type, u8 quadIndex}`. `firstPoint` indexes the chunk's vertex buffer;
`slice` is chunk-local (global = `firstSimSliceInd + slice`); the segment is built from that vertex
along the slice's `right` vector (`DrawW_BuildChunkCenterLineFacets`). Lines are drawn only when a
chunk's build entry has `geomRez == 4` and enable bit `0x04`. All 87,024 records are in range.
`type` census: 0–9 and 255 (meaning open); `quadIndex` meaning open.

## 10. Glare / light flares (`0x0A`, `Trk_SFX`, 16 B) ★★★
`{i32 point[3]; i16 type; i16 pad}`, consumed by `BWorld_BuildGlareEffects`:
- `pad == 0`: one `Flare_Halo` of kind `type` at `point`.
- `pad != 0`: `pad & 0x7FFF` is a pair-group ID; if bit 15 is set, a `Flare_Halo2` streak is drawn to
  the first record with the same group ID. (That search starts at record 0, so a record can match
  itself.)
- `type == 100`: environment effect (`TrgSfx_AddEnviroEffect`, direction (0, 0xA0000, 0)), and the
  function then **returns**, skipping the chunk's remaining flares.

Retail census: 4,753 records, every `pad` is 0 and type 100 never occurs, so only single halos are
used. Flare kinds present: 25, 27, 28, 29, 31, 32.

## Runtime validation ★★★
Retail NFS4 was booted in the modified DuckStation (GDB + full-state API), driven into a race by
injected pad input, and stopped right after `Track_Init("zTr06.grp")` returned
(`tools/runtime/nfs4_track_probe.py`). `tools/runtime/compare_track_init.py` then compared RAM with the
predictions computed from the pristine `ZTR06.GRP` using this spec — **8/8 byte-exact**:
TrackHeader; chunk centers; the full 1,086-slice array; light-table entries; every chunk's
boundPts/chunkboundPts/firstSimSliceInd/chunkInd; every chunk's quadCounts; the visibility counts; and
the visibility rows including the 64-byte-stride overlap. A full-state checkpoint
`nfs4_after_track_init` (track 06, day) is saved in the isolated runtime for further probes.

## Open questions
None that the game reads. Unread by the game (exporter metadata): chunk-meta A and the short at +8,
quad-block s[0], s[3], s[4], TrackHeader `type`/`version`/`max*`/`metaChunkCount`, slice
`acousticType`, and the render-quad surplus. Their exporter-side meaning is open but irrelevant to
the game; a re-writer can copy them or fill them with the census values.

## Tools
- `tools/nfs4_grp.py` — walker and census.
- `tools/nfs4_grp_validate.py` — asserts §4.2–§5 on every chunk.
- `tools/psx_iso.py` — pristine extraction from the disc image.
