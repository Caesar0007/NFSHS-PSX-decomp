# NFS2 (PSX) track files — survey

Game: Need for Speed II, PSX. **Reference disc = PAL `SLES-00658`** ("Need for Speed II (Europe) (En,Fr,De,Es,It,Sv)"):
its `SLES_006.58` with `FRONT.BIN` spliced at 0x80010008 is byte-identical to the code oracle
`nfs2-clean/NFS2-F.EXE` (raw disassembly `nfs2-clean/nfs2-raw-FULL.txt`, Ghidra body `nfs2-f.c`, IDA body
`NFS2-F.IDA.c`). The USA disc (`SLUS_002.76`) is a different build (630,750 bytes of the EXE differ) and is not
used as the code reference. Extracted data: `C:/Temp/nfs2_disc` (PAL, 506 files, movies skipped).
Tools: [`tools/nfs2_trk.py`](../tools/nfs2_trk.py) (reuses the NFS3 walkers in `nfs3_trk.py`).

Tags: ★★★ = proven on every file (and/or read in the loader); ★★ = strong evidence; ★ = observed only.

## Track set ★★★
Seven tracks, one variant each: **00, 02, 03, 05, 06, 07, 08** (ids 01 and 04 have no files). Per track:

| File | Format | Notes |
|------|--------|-------|
| `ZTR<NN>.TRK` | `TRAC` v22 streamed geometry | 682–983 KB; §1 |
| `ZTR<NN>.COL` | `COLL` v11 persistent collections | §2 |
| `ZTR<NN>0.QPS` | RefPack (`10FB`) → `SHPP` | track textures (all 7 unpack to exact size) |
| `ZTR<NN>.HRZ` | text | horizon ("Black horizon flag", "Mirror Flag", radius, rotation, flat-projection distance, gouraud base/height, …) |
| `ZTR<NN>.LGT` | text | "Depth cueing definition" (4 × {distance, level}), 16 × RGB "Light palettes", "Maximum and minimum intensity", "sfx light color [type, r0, g0, b0, r1, g1, b1]" |
| `ZTR<NN>.QAL`, `.QPL` | Huffman (`30FB`) | unpack to exactly **one byte per slice** (7 of 7 each) ★★★ size |
| `ZTR<NN>.QAS`, `.QPS` | RefPack (`10FB`) | unpack to exactly **2 · (slices/2 + 1)** bytes (7 of 7 each) ★★★ size |
| `ZTR<NN>0<k>.CAN` | camera animation | 5 per track (k = 0–4) |
| `ZTR<NN>ROK.MAP`, `TEC.MAP` | `PFDx` | interactive-music maps (rock / techno), as NFS3 §11.3 |
| `ZTR<NN>.TRJ`, `.TRM` | `SCHl` ASF | music streams |
| `ZTRAMB<NN>.BNK` | `BNKl` | per-track ambience bank |

The `Q*` pair naming (`A`/`P` × `L`/`S`) matches NFS3's AI files (speed line / racer speeds); their meaning in NFS2
is not traced yet.

## Loader map (raw oracle) ★★★ addresses, roles ★★
| VA | What |
|----|------|
| `func_8004B530` | track load: builds names with `func_8004B2EC` from the suffix strings `".col"` (0x800D5290), `"0.qps"` (0x800D5298), `".trk"` (0x800D52A0), opens the TRK (handle in gp+4936) and reads its header through `func_80079D98` / `func_80079DE0` / `func_80079E28` / `func_80079E70` (same accessor family as NFS3 `func_8009E694…`); allocates the stream buffer `"stmbuf"` (0x800D52A8) of max(header value, 0xD000) bytes — the 0xD000 sits in the branch delay slot, so it is a floor, not a cap |
| 0x80060C2C | `'COLL'` magic check (string 0x800D5384) |

## 1. `.TRK` ★★★ container
Same container as NFS3 ([NFS3_TRACK_FILES.md](NFS3_TRACK_FILES.md) §1): header `{'TRAC', 0x16, MaxMetaChunkSize,
largest chunk, +0x10, +0x14, metaCount = ceil(chunks/8), chunkCount}`, StmChunkF / StmCenter / StmMetaI tables,
meta-chunks of 8 chunks, chunks with the 0x40-byte header, the sub-block table and `{u32 len, u16 type, u16 n}`
sub-blocks. `nfs2_trk.py census`: **7 files, 1,547 chunks**, every container, meta, chunk-size, sub-block bound,
chunk-meta (first sim slice / index), LOD-count, sim-slice partition, slice-link, type-5 frame and record-size
check passes. Sub-block types (occurrences): 4 ×1547, 5 ×1547, 6 ×1547, 0xD ×1547, 7 ×863, 8 ×1086, 9 ×862,
0xB ×338, 0x12 ×551, 0xA ×11, 0x11 ×17, 0x13 ×26 (NFS3 has no 0x13).

### 1.1 Geometry block — the NFS2 difference ★★★
Header at chunk+0x40 as in NFS3 (`u32 rel`, `u16 n0 ≤ n1 ≤ n2 ≤ n3` LOD vertex prefixes, `u16 q[6]`), but the
records are smaller/larger:

| Record | NFS2 | NFS3 |
|--------|------|------|
| vertex | **6 B** `{i16 x, y, z}` (no colour) | 8 B `{i16 x, y, z; u16 rgb555}` |
| quad | **8 B** `{u16 material, u16 flags, u8 v[4]}` | 6 B `{u16 material, u8 v[4]}` |

Proof: `rel − 0x18 − 6·(n0+n3) − 8·Σq` lands in 0…3 (4-byte padding) for **all 1,547 chunks**, and 6/8 is the
only size pair that does for 1,514 of them. Every quad's material is below the COL material count. The quad's
second u16 is `Stm_Quad.light` (§1.8).

21 quads (tracks 02, 03, 06) use vertices outside their level's transformed range — see §1.7.

### 1.2 Names — the PC beta debug info ★★★
The NFS2 PC beta (`nfs2-clean/pc-beta/nfsw.exe`, Watcom debug → SYM `nfs2-v1.txt`) is the same game and names the
PSX structs; the PSX reader module is `game/common/stmrd.c` (its asserts carry the file name and line numbers;
`func_80079D68`…`0x8007A160` = the 21 PC `Stm_*` functions in order). Sub-block header = `Stm_ItemCollection
{u32 size, u16 type, u16 itemCount}`; geometry header = `Stm_TrackGeometry {u32 size, u16 vertexCount[4], u16
quadCount[6]}`. The sub-block lookup is `Stm_GetItemCollection` (`func_8007A090`, wrapped by `func_8004B414`).

### 1.3 Chunk binder and sub-block types ★★★
`LoadChunkFromBuffer` (`func_8004BB3C`) looks up each type and stores it in the chunk slot's record (PC
`BW_tChunkDat`; PSX records reached through the pointer at gp+4824). ⚠️ Every store sits in the **delay slot of
the next lookup call**, so it saves the *previous* call's result; read that way the PSX slots follow the PC
struct's field order exactly:

| Type | PSX slot | PC field | Record (size) | On disc |
|------|----------|----------|---------------|---------|
| 4 | (fetched by `func_8004D7BC`) | — | i16 chunk index (2) | 1,547 lists; every entry is a valid chunk, each list contains its own chunk |
| 8 | +1024 | `objDefBuf` | object definitions (§1.5) | 3,902 |
| 7 | +1028 | `objInstanceBuf` | instances (§1.4) | 2,500 records |
| 0x13 | +1032 | `objInfrontInstanceBuf` | instances | 84 |
| 0x12 | +1036 | `objBehindInstanceBuf` | instances | 1,318 |
| 6 | +1040 | `simSliceBuf` | `Stm_SimSlice {u16 quadIndex, u8 quadCount, u8 musicIndex, i16 leftLinkSlice, i16 rightLinkSlice}` (8) | partitions q4 exactly |
| 0xD | +1044 | `simQuadRotBuf` | `Stm_Rotation {i16 normal[3], i16 forward[3]}` (12) | one table per chunk |
| 5 | +1048 | `simQuadBuf` | `Stm_SimQuad {u8 rotationIndex, u8 surface}` (2) | one per q4 quad |
| 0xB | +1052 | `simObjBuf` | `Stm_SimObject {i32 point[3]; u16 radius, u16 serialNum; u8 top, bottom, instIndex, type}` (20) | 338 blocks |
| 0x11 | +1056 | `audioPtBuf` | `Stm_SoundPt {i32 point[3]; u16 type, u16 property}` (16) | 17 |
| 0xA | +1060 | `sfxBuf` | 16 B `{i32 point[3]; u16 (1 or 2), u16 0}` | 14 |
| 9 | (fetched by `func_8004C08C`) | — | `Stm_Line` (4), §1.6 | 26,035 |
| 0xC | (fetched by `func_8004BEAC`) | — | — | never present |

The binder also sets `renderQuads[0…5]` (+1064 + 4k): the quad arrays, each advancing by `8 · quadCount[k]` — the
code's own proof of the 8-byte quad. The NFS3 type numbers are the same for every shared type.

Readers confirm the pairing: `BuildFacets` passes the behind-instances (+1036) as the draw list and the object
definitions (+1024) as the block table to `BuildObjectFacets` (`func_8004D290`); `BWorld_SoundTrack`
(`func_8004C98C`) hands the audio points (+1056) to `DoChunkAudio` (`func_8004D89C`), where `property` = 1 makes
the point play only on a random 1-of-8 phase (layer 0xF), otherwise it plays once (layer 0xE). `DoChunkAudio` uses only the **first** sound point of the collection (on disc every collection holds exactly one):
`type` is the sound id passed to the sfx player (`func_80046CAC`), the volume falls with the square of the distance
and the pan comes from the point's position relative to the listener. `Stm_SimQuad.surface`: bits 0–5 = surface id
(getter `func_8005089C`, `& 0x3F`), bits 6–7 flags (as NFS3: 0x40 / 0x80); id 0 is undrivable
(`Newton_TestForUndrivableSurfaces`) and the whole byte 0xE is a wall — `RawFindClosestQuad` will not step onto it.
On disc ids 0–15 occur, 0 (69,052) and 1 (27,346) most; every `rotationIndex` is inside its chunk's 0xD table.
No PSX code reads the
sfx slot (+1060) apart from the binder (every other +1060 access in the EXE belongs to other structs), and a
runtime access watch confirms the records are never read (below) ★★★.

### 1.4 Instances (types 7, 0x12, 0x13) ★★★
`{u16 size, u8 type, u8 objectIndex, …}`, walked by `size`; all 3,902 records on disc parse exactly:

| type | Struct | Size | Count |
|------|--------|------|-------|
| 1 | `Stm_SimpleInst {…; i32 x, y, z}` | 16 | 3,244 |
| 3 | `Stm_AnimateInst {…; u16 count, u16 interval}` + `count` × `Stm_AnimateFrame {i32 x, y, z; i16 qx, qy, qz, qw}` (20) | 8 + 20·count | 23 |
| 4 | `Stm_CollideInst {…; i32 x, y, z; u8 simIndex, u8 pad, u16 pad2}` | 20 | 635 (type 7 only) |

`objectIndex` indexes the chunk's object definitions (type 8). In **every** chunk the instances of types 7, 0x12
and 0x13 together use each definition **exactly once** (their `objectIndex` values are a permutation of
0…defs−1, 1,547 of 1,547 chunks): NFS2 stores one definition per placed object, with no sharing.

### 1.5 Object definitions (type 8) ★★★
`Stm_ObjectDef {u32 size, u16 vertexCount, u16 quadCount}`, then `vertexCount` × 6-byte vertices and `quadCount` ×
8-byte `Stm_Quad`; `size = 8 + 6·vertexCount + 8·quadCount` (+2 padding in 198 of 3,902). Every object quad's
vertex indices are below `vertexCount` and its material below the COL material count.

### 1.6 Road lines (type 9) ★★★
`Stm_Line {u8 firstPoint, u8 slice, u8 type, u8 quadIndex}`, read by `BuildChunkCenterLineFacets`
(`func_8004C08C`): the point is chunk vertex `firstPoint` plus the slice's signed `right` vector (bytes 18–20 of the
COL slice; vertices below `vertexCount[0]` get the chunk-centre delta first, as NFS3's seam vertices); `type` = line
style (0xFF = no segment, else 0–9, cf. the `LIN%d` shapes); `quadIndex` selects the road quad (array 4) whose
`light` word lights the segment (§1.8). On disc: every `firstPoint` < chunk vertices, every `slice` < the chunk's slices;
`quadIndex` < q4 in 24,445 of 26,035 (85 % fall inside the line's own slice's quads).

### 1.7 Level of detail ★★★
`BuildFacets` (`func_8004CAB0`) picks a level from the table at `0x800BC608` = PC `tRezContext {ptRez, geomRez,
transPrecision, quadLoopPtr}`: `{1, 0, 11, QuadLoop}`, `{2, 2, 10, QuadLoop}`, `{3, 4, 9, QuadLoop}` (`QuadLoop` =
`func_8004C480`). It transforms `vertexCount[ptRez]` vertices starting after the first `vertexCount[0]` (the seam
vertices), then the `vertexCount[0]` seam vertices, and draws quad arrays `geomRez` and `geomRez+1` against those
`vertexCount[0] + vertexCount[ptRez]` transformed vertices — the same rule as NFS3 (NFS3_TRACK_FILES.md §1).
21 quads on disc (tracks 02, 03, 06; arrays 0–3 only) use a vertex index at or past
`vertexCount[0] + vertexCount[ptRez]` (20 exactly at it, one — ZTR03 chunk 200 — also the next): vertices that exist
in the file but are **not transformed** at that level, so the game reads stale slots of the transformed buffer — an
exporter slip, not a different rule. `nfs2_trk.py census` counts them separately.

### 1.8 Quad `light` = lighting context ★★★
`QuadLoop` copies `Stm_Quad.light` into the facet's texture context (`DRender_tFacet3D.texture.ctx`, facet +0x20 on
PSX; the PC `QuadLoop` does the same), and cars take the `light` of the road quad under them
(`R3DCar_GetLightingContext` on PC; 0xFFFF when none). Encoding, read by `func_80080AAC`:

| Bits | Meaning |
|------|---------|
| 0–3 | light **palette** (0–15; the `.LGT` "Light palettes", §2.1) |
| 4–6, 7–9, 10–12, 13–15 | intensity **level** 0–7 of facet corner 0, 1, 2, 3 |

Each corner's colour = entry `(level << 4) | palette` of the 128-entry RGB light table (the second half of the
0x4000-byte "light table" allocation, `func_800839FC`); `func_80080AAC` averages the four for a car. Facet corners
0–3 are `aPoints[1], aPoints[0], aPoints[3], aPoints[2]` (`QuadLoop`). On disc, reading the fields this way makes the
level at each shared vertex agree between neighbouring road quads in **97.4 %** of vertices (the next-best bit
order: 76 %). Palettes used: 15 (white; includes 0xFFFF = all corners level 7) on 65,894 non-0xFFFF road quads, 2
(red) on 4,316, 1 (green) on 1,925.

### 1.9 Runtime check (DuckStation, PAL disc) ★★★
`tools/runtime/nfs2_track_probe.py` boots the PAL disc in the isolated DuckStation copy (GDB port 2350), injects
pad input by stopping at 0x800A0058 inside the pad-driver VSync callback `_padDr` (`func_800A0018`) and writing a
digital-pad record `{0x00, 0x41, buttons}` into the port-0 result buffer `*(u32 *)0x800D5F60`, and drives the menus
into a race (track 00 after ~2,200 pad frames; no attract-mode race starts on its own within 7 minutes). After
`LoadChunkFromBuffer` returns, the slot records (base `*(gp+4824)`, 0xBC per slot) are dumped: for all 8 slots, the
11 pointers (+1024…+1060 and `renderQuads[0]` at +1064), taken relative to the chunk pointer at +1012, equal the
file offsets of the sub-blocks of exactly one `ZTR00.TRK` chunk (slots 0–7 = chunks 152–159), absent types
reading 0. This confirms the slot map of §1.3 (the delay-slot reading), the unmodified in-RAM chunk layout and the
6-byte vertex stride. The slot word at +1016 is `chunk + 0x40` (geometry); +1020 (PC `objBuf`) is never written — see the full-race
check below.

## 2. `.COL` ★★★ container
`{'COLL', 11, size, count, offsets}` as NFS3; all 7 parse. Collections: **2 materials** (10-byte records in all 7 — 298–529 per track),
**0xF slices** (36-byte records in all 7; 1,287–2,027 per track, equal to each track's sim-slice total), **7 instances**
and **8 object definitions** (variable-size records; 5 tracks — 05 and 07 have none).

**Slice** (collection 0xF) = PC `Sim_Slice` (36 B) ★★★ names:

| Off | Field | Off | Field |
|-----|-------|-----|-------|
| 0 | `i32 center[3]` | 0x18 | `u16 pavedProfile` |
| 0xC | `s8 normal[3]` | 0x1A | `u16 leftDrive` |
| 0xF | `s8 forward[3]` | 0x1C | `u16 rightDrive` |
| 0x12 | `s8 right[3]` (read by the line builder, §1.6) | 0x1E | `u8 barrierType` |
| 0x15 | `pad` | 0x1F | `u8 laneCount` |
| 0x16 | `u16 chunkIndex` | 0x20 / 0x21 | `u8 avgPavedWidthLf / Rt` |
| | | 0x22 | `u16 pad2` |

Readers (recon names from the PC port; formulas from the raw):

| Field | Use |
|-------|-----|
| `pavedProfile` (+0x18) | lane bitmask: lane *n* is drivable when bit `15 − (n+1)` is set (`AI_IsDriveableLane`, `AI_CheckForBarriers`) — the NFS3 "legal lane mask" |
| `leftDrive` / `rightDrive` (+0x1A / +0x1C) | barrier extents left / right of the centre line, `<< 8` (`Physics_DoBarrierCheck` tests the car's lateral position against them; `AI_HandleShouldersAndOffRoad` puts the shoulder at `drive<<8 − lanes · width`) — NFS3's +26/+28 extents |
| `barrierType` (+0x1E) | two nibbles; `func_800508E4` returns 1 when either is 2 (NFS3: cover 2 = tunnel); also read by `AudioCmn_SoundCar` |
| `laneCount` (+0x1F) | high nibble = left lanes, low nibble = right lanes (`AI_HandleChangeInNumLanes`, `AI_PutCarOnShoulder`; `AI_GetOneWay` = slice 1 has no left lanes) |
| `avgPavedWidthLf` / `Rt` (+0x20 / +0x21) | lane width `<< 15` per side (`AI_PutCarOnShoulder`: offset = width · lanes − width / 2) |
| `chunkIndex` (+0x16) | the chunk holding the slice (`BWorldSm_FindClosestSlice`, `SetSimSlice`); valid in all 12,359 slices |
| `normal`, `forward`, `right` (+0xC/+0xF/+0x12) | signed axes `<< 9` (physics, cameras; `right` also by the road lines) |

The NFS2 slice is byte-for-byte NFS3's (NFS3_TRACK_FILES.md §2), so these PC names also name the NFS3 fields.
On disc: `laneCount` (1,1) × 5,980, (0,4) × 2,286, (0,3) × 1,662, …; `barrierType` (1,1) × 6,294, (4,4) × 2,278,
(2,2) × 1,277, …; `pad` and `pad2` are 0 everywhere.

**Material** (collection 2) = PC `Stm_Material` (10 B): `{u16 shapeIndex; u8 flag, uvFlag, r, g, b; s8 textureCount;
u8 interval; s8 pad}` — the same layout as NFS3 (NFS3_TRACK_FILES.md §2).

### 2.1 `ZTR<NN>.LGT` — light file ★★★
Text, read by `Draw_LoadTrackLight` (`func_80080F40`, `"%sTr%02d.lgt"`) with the comment-skipping number reader
`func_800757C4`, values in this order:

| Values | Stored | Meaning |
|--------|--------|---------|
| 4 × {distance, level} | `0x800E4340[i]` / `0x800E4360[i]` | depth-cue (fog) curve |
| 16 × RGB | `0x800DE508` (16 × 3 ints) | the light palettes of §1.8; the index of a palette equal to (0, 127, 0) is kept at gp+4772 (else −1) |
| 2 | `0x800D63CC`, `0x800D63D8` | minimum and maximum intensity (minimum 32–96, maximum 255 on disc): bias and span of the 8-level ramps built per palette by `func_80080850` |
| 1 | `0x800D6290` | sfx light mode |
| 2 × RGB | `0x800E5F28[0…5]` | sfx light colours 0 and 1 |

**Sfx light** (`func_80080DAC`, only when a (0, 127, 0) palette exists): the ramp of that palette is animated
between the two sfx colours — mode 0 = toggle every 10 ticks, 1 = toggle every 5, 2 / 3 = triangle-wave pulse
(`func_80080CC0` with rate 2 / 1). So road quads with palette 1 (the green (0, 127, 0) entry in every retail file)
are the blinking lights. On disc all 7 files use mode 0; colours (0, 0, 0)/(127, 0, 0) on track 00, (74, 66, 123)/(34, 30, 55) on
07, (0, 127, 0)/(127, 0, 0) on the other five.

### 2.2 `ZTR<NN>.QPS/.QAS/.QPL/.QAL` — AI speed tables ★★★
`AISpeeds_SetupSpeeds` (`func_80044670`) opens `"%sTr%02d.%s"` with extensions from two 5-byte-stride tables at
`0x800BC2E0`: index = `STYLE > 0` (`cfg` word `0x800F6E2C`, FE key 5 "STYLE"; set by `AISpeeds_StartUp`):

| STYLE | Speeds (gp+8) | Speed line (gp+0xC) |
|-------|---------------|---------------------|
| 0 | `QPS` | `QPL` |
| > 0 | `QAS` | `QAL` |

(The table also holds `qpa`/`qaa`, which the stride-5 index can never reach; no such files exist.) A missing file is
replaced by a zeroed buffer — "Speeds Buffer" of `(slices/2 + 1) · 2` bytes, "Spd Line" of `slices` bytes — exactly the
unpacked sizes of all 28 files.
- **Speeds**: one byte per pair of slices, read at `(slice/2)·2` as target speed `<< 16` (`AI_CalcDesiredSpeed`,
  `AI_GetSpeedFactor`, `AI_CalcAggressiveTopSpeed`); values 0–255. The odd byte of each pair is non-zero but never read
  (★★★, runtime-confirmed in an 8-car race).
- **Speed line**: one byte per slice; 0 = no preference, otherwise a lane number compared with the car's lane
  (`AI_CalcBestLineMerits`); values 0–16 (`QAL` is all 0 except on track 06).

### 2.3 `ZTR<NN>.HRZ` — horizon ★★★
Text, read by `Hrz_ReadHorizonData` (`func_80083B78`, `"%sTr%02d.hrz"`), 25 values in the order of the file's own
comments: black-horizon flag, mirror flag, radius, rotation (degrees → 16.16 fraction of a turn), flat-projection
distance, gouraud base, gouraud height (`h`); midpoint, pixmap top, pixmap bottom (each × 0x10000 / `h`); RGB of the
earth top, earth base, sky top; sky base at the sun side and opposite it — these last two are blended in 8 steps into a
16-entry sky table mirrored round the turn (`0x800DF230`). Six files have 25 values; **`ZTR08.HRZ` has 24**: the
black-horizon flag line is missing, so every value shifts by one (the game reads black-horizon = 1, mirror = 1000,
radius = 0, …, and one value past the end).

### 2.4 `ZTR<NN>0<k>.CAN` — animation scripts ★★★
`Anim_Init` (`func_80044968`, `"%s%02d.can"`, k = 0–4, stops at the first missing file) keeps up to 5 handles (PC
`_animScripts[5]`, type `Stm_AnimateInst`). A file is one `Stm_AnimateInst {u16 size, u8 type, u8 objectIndex, u16
count, u16 interval}` followed by `count` × `Stm_AnimateFrame {i32 x, y, z; i16 qx, qy, qz, qw}` — the same record as
the animated track instances (§1.4). All 35 files: `size` = file length = 8 + 20·count (1,188 frames), interval 6,
every quaternion unit length at 0x4000. Read by `Anim_GetTimedAnimPosRot` and siblings (PC `anim.c`).

## 3. Full-race runtime check (8 cars) ★★★
`tools/runtime/nfs2_race_setup.py` drives the menus while forcing the front-end words RACETYPE (0x800F6E20) = 1,
NUMCARS (0x800F6E74) = 8 and TRACK (0x800F6E44), holds accelerate and saves a DuckStation checkpoint 900 pad frames into
the race (car table 0x800F75E0 fully populated; ⚠️ the breakpoints stop inside the VSync interrupt, so the game's
`gp` 0x800D50A0 is used instead of the register). `tools/runtime/nfs2_watch_probe.py` then loads the checkpoint and
logs every PC and data address hitting GDB watchpoints (length ≤ 0x100 per watchpoint):
- **Track 05, speed tables** (first 0x100 bytes of each, 1,500 frames): 788 reads of the speeds table, all by
  `0x80041BE8` (`AI_CalcAggressiveTopSpeed`) and **all on even bytes** — the odd byte of each slice pair is never
  read; 462 reads of the speed line by `0x8003DD8C` (`AI_CalcBestLineMerits`).
- **Track 08, sfx records and slot +1020** (access watchpoints on the 4 resident sfx records of chunks 216/218/219 and
  on +1020 of 4 slots, 2,000 frames): **no access** to either while resident; the only hits are the chunk streamer
  (`func_800ABA20` from `LoadChunkFromBuffer`) overwriting one record's memory with a newly loaded chunk at frame 764
  and that new chunk's vis-list reader (`0x8004D820`). The +1020 word (PC `objBuf`, the field between `geomBuf` and
  `objDefBuf`) is never written by the PSX, so its contents are stale memory.

So on PSX: the odd speed bytes, the `sfxBuf` records and `objBuf` are unused (PC-only leftovers of the shared format).

