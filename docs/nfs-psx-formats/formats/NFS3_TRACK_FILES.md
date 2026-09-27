# NFS3 track files — file set, loaders, TRK/COL records

Game: Need for Speed III: Hot Pursuit, PSX USA retail **SLUS-006.20**. Status: file set, loader map, both binary containers (`.TRK`, `.COL`) and the core TRK records (chunk,
geometry/LOD, vertices, quads, materials, visibility, sim slices, object definitions and instances) are established;
the remaining records are listed under *Open questions*. Tags per [METHOD.md](../METHOD.md).

## Sources and code oracle
- Disc: share `NFS3.bin` (USA retail), extracted with `tools/psx_iso.py` (MOVIES skipped) → 774 files.
- Code oracle: `C:\Temp\nfs3-clean` — stripped binary, so no names; the raw disassembly
  `nfs3-raw-L.txt` is the authority. Its analysis image `NFS3-F.EXE` is **byte-identical to the
  disc `SLUS_006.20` with the disc `FRONT.BIN` written at 0x80010008** (checked), so every VA below is valid for
  this disc.
- The reconstructed C++ in `nfs3-clean/functions/` gives the shape, but its descriptive comments come from Ghidra and
  are not reliable here. Two examples found during this survey:
  - `func_800799A4` is described as "streaming audio"; it is the track (BWorld) init.
  - `func_800660A4` passes the track ID to `FUN_80065db0` as a folded constant 0; the raw loads
    config word `0x800F9F80`.
  Everything below is taken from the raw oracle.
- Names in quotes are the EXE's own log/debug strings, which survive in the stripped binary and are the only
  name evidence (NO-AUTO-NAMING rule).

## Track identity ★★★ (`func_80065DB0`, `func_80065E18`, `func_80065EB0`)
The race track ID is config word `0x800F9F80`: **low nibble = track number, bit 4 = layout variant**.
File names are built as `<prefix>Tr<NN><v><suffix>` with `v = 'a' + variant`; the streamed geometry
uses `zzTr` (`%szzTr%02d%c%s` when the suffix is `.trk`). One special case: track 2 with config word
`0x800F9F8C` set is forced to `02b` (`func_80065EB0`).

| Track | Variants on disc | Notes |
|-------|------------------|-------|
| 00–04 | a, b | b starts at a's first chunk centre and shares 15–95 chunk centres with a, but is a longer, different layout (not a reversed a) |
| 05 | a, b | b shares no chunk centre with a |
| 06, 07, 08 | a | |
| 16, 17, 19 | — | AI/cop data only (`Q*`, `BEG/EXP.COP`, `.QTS`); 18 has only `.QTS` |

Which menu track selects which ID/variant is not yet traced (front-end table; the ten front-end names are
`trkHom trkRed trkAtl trkRoc trkCnt trkLst trkAqu trkSum trkEmp trkRec`).

## File set and loaders
`v` = variant letter; `.<lang>` = ENG/FRE/GER/ITA/SPA.

| File | Magic / kind | Loader (raw VA) | Tag | Notes |
|------|--------------|-----------------|-----|-------|
| `ZZZTR<NN><v>.TRK` | `TRAC` v22, streamed | `func_800799A4` "BWorld Init" → `func_800C370C` | ★★★ container | §1 |
| `ZTR<NN><v>.COL` | `COLL` v11 | `func_80068018` "Opened track Persistent file and found %d collections" | ★★★ container | §2 |
| `ZTR<NN><v>.CCM` | binary, 176 B–… | `func_800660A4` → `func_8006BB78(".ccm")` | seen | |
| `ZTR<NN><v>0.PSH`, `…R.PSH` | SHPP shape files | `func_80067960` ("0.psh", "R.psh") | ★★★ container | textures / reflection maps; format as [NFS4_PSH.md](NFS4_PSH.md) (to re-verify on NFS3) |
| `ZTR<NN><v>A.VIV` | BIGF archive | `func_8005B878` ("%sA.viv") | seen | |
| `ZTR<NN><v>.DPQ` | text | `func_800A7250` ("%sTr%02d%c.dpq") | ★ | depth-cue distance + colour, car env-map zones `{slice, tex, extra, quad}` (the NFS4 `.ENV` content lives here) |
| `ZTR<NN><v>.HRZ` | text | `func_800B84BC` ("%sTr%02d%c.hrz") | ★ | horizon/sky parameters, commented |
| `ZTR<NN><v>{D,N,W}.CLR` | text | `func_80080C18` ("%sTr%02d%c%c.clr") | ★ | car colour table per condition (day/night/weather); also `carmenu.clr` |
| `ZTR<NN><v>{,N,NW,W}.BNK` | sound bank | ".bnk" builders | seen | |
| `ZTR<NN><v>T{B,F}.BIN` | 16-byte records `{i32, 16.16, i32, -1}` | `func_80081DB4` ("b.bin", "f.bin") | ★ | |
| `ZTR<NN><v>.VIS` | text `#chunk` + list | **none** (no reference in the EXE) | ★★★ | exporter source of TRK sub-block 4 (§1.5) |
| `ZTR<NN>{F,R}.QAL/.QAS/.QBE` | Huffman `30FB` | "%sTr%02d%s.qbe", "qal", "qas" | seen | codec as [NFS4_Q_CODECS.md](NFS4_Q_CODECS.md) |
| `ZTR<NN>{F,R}.QSL/.QSS`, `ZTR<NN>.QTS` | Huffman `30FB` | **no reference found** | ✗? | likely unused; confirm with a runtime file-open trace |
| `ZTR<NN>{BEG,EXP}.COP` | binary | `func_800520FC` ("%sTr%02d%s.cop") | seen | cop data |
| `ZTR<NN>CSP.<lang>`, `ZZZTR<NN>C.<lang>` | speech | `func_80081DB4`, `func_80083688` ("cop speech") | seen | |
| `ZZZTR<NN>A.TRJ`, `ZZZTR<NN>B.TRM` | `SCHl` EA audio stream | "%szztr%02da.trj", "%szztr%02db.trm" | seen | track music |
| `ZTR<NN>{PGR,PGT,R<nn>,T<nn>,ROK,TEC,TOK,R0A,R0B}.MAP` | `PFDx` | "%str%02d….map" | seen | interactive-music maps |

## 1. `.TRK` — streamed track geometry ★★★
### 1.1 Header (32 bytes) — `func_800C370C`, accessors `func_8009E694…8009E784`
| Off | Type | Field | Evidence |
|-----|------|-------|----------|
| 0 | char[4] | `TRAC` | compared (`func_800C7444`, 4 bytes) |
| 4 | u32 | version = **0x16** | compared; load fails otherwise |
| 8 | u32 | "MaxMetaChunkSize" | printed by name; = largest meta-chunk in all 15 files; the streaming buffer size |
| 0xC | u32 | "MaxGeomSize" | printed by name; = largest chunk in all 15 files |
| 0x10 | u32 | (accessor `func_8009E754`) | meaning open |
| 0x14 | u32 | (accessor `func_8009E784`) | meaning open |
| 0x18 | u32 | meta-chunk count | = ceil(chunkCount / 8) in every file |
| 0x1C | u32 | "NumChunks" | printed by name |

### 1.2 Tables (read whole at init, names from the allocation strings)
| Table | Size | Content |
|-------|------|---------|
| "StmChunkF" | metaCount × u32 | file offset of each meta-chunk |
| "StmCenter" | chunkCount × 3 × i32 | chunk centre, 16.16 fixed point; subtracted from chunk data on load (`func_80079F4C`) |
| "StmMetaI" | chunkCount × u16 | meta-chunk holding the chunk; = chunk / 8 in every file (`func_8009E800`) |

The first meta-chunk starts at the next 4-byte boundary after the tables.

### 1.3 Meta-chunk (8 chunks, streamed) — `func_80079C58` → `func_800C3990`
A chunk request looks up its meta-chunk, seeks to `StmChunkF[meta]` and reads `MaxMetaChunkSize` bytes into
the stream buffer (allocated from header +8 in `func_800799A4`).
| Off | Type | Field |
|-----|------|-------|
| 0 | u32 | meta-chunk size (file space ends ≤ 3 bytes later: padding) |
| 4 | u32 | chunk count (8; the last meta holds the remainder) |
| 8 | u32 | 0 in every file |
| 12 | u32[count] | chunk offsets, relative to the meta-chunk start (first = 12 + 4·count) |

### 1.4 Chunk ★★★
| Off | Type | Field | Evidence |
|-----|------|-------|----------|
| 0 | u32 | chunk size | = distance to the next chunk, all 2,234 chunks |
| 4 | u32 | chunk size again | equal in every chunk (NFS4 keeps this duplicated word as "value A") |
| 8 | i16 | sub-block count (4–12) | loop bound of `func_8009E870` |
| 0xA | i16 | first sim slice of the chunk = running sum of the preceding chunks' type-6 counts | all chunks; kept by the binder (`ChunkDat+0x54`); NFS4 `firstSimSliceInd` |
| 0xC | i16 | chunk index | all chunks; NFS4 `chunkInd` |
| 0xE | i16 | 0 | all chunks |
| 0x10 | 4 × {i32 x, y, z} | bounding points, absolute 16.16 | `func_8009E940`; made centre-relative on load (`func_80079F4C`) |
| 0x40 | | geometry block, §1.4.1 (its first word also locates the sub-block table) | |
| … | u32[count] | sub-block offset table at `chunk + 0x40 + geometry.rel`; offsets relative to the chunk | `func_8009E870` |

#### 1.4.1 Geometry block (chunk + 0x40) — `func_8009E850`, `func_8007A198`, renderer `func_800B1F1C`
| Off | Type | Field |
|-----|------|-------|
| 0 | u32 | `rel`: offset of the sub-block offset table, relative to this block |
| 4 | u16 | n0: vertices common to every level (0 in 2,031 chunks) |
| 6, 8, 0xA | u16 × 3 | n1 ≤ n2 ≤ n3: vertex counts of the low / medium / high level of detail; a level uses the first `n0 + nK` vertices |
| 0xC … 0x16 | u16 × 6 | quad counts q0 … q5 |
| 0x18 | 8 B × (n0 + n3) | vertices |
| … | 6 B × q0 … q5 | six quad arrays, back to back; then 0–3 bytes of padding up to `rel` |

The renderer takes a detail descriptor `{vertex level, array}`, draws array k with `q[k]` quads, and transforms
`n0 + n_level` vertices. Census (all 2,234 chunks): `n0 ≤ n1 ≤ n2 ≤ n3`; the block ends within 3 bytes of `rel`; every vertex
index of arrays 0/1 is below `n0 + n1`, of arrays 2/3 below `n0 + n2`, of arrays 4/5 below `n0 + n3`.

| Array | Level | Content |
|-------|-------|---------|
| q0, q1 | low | q0 = main geometry at low detail (presumably the trough, ★★); q1 = extra quads |
| q2, q3 | medium | q2 = main geometry at medium detail (★★); q3 = extra quads |
| q4, q5 | high | q4 = the trough exactly as covered by the sim slices (type 6) and surface words (type 5); q5 = extra quads |

The odd arrays hold 0.6 % of all quads (2,290 of 408,005) and use only materials below 374; which polygons the exporter put there (walls,
decals?) is still open.

**Vertex** (8 B) ★★★: `{i16 x, y, z; u16 colour}`. The colour is RGB555, split into three 5-bit channels by
`func_800B16D4` (0x6317 = 23, 24, 24 → grey) and used for Gouraud shading. On load, x/y/z are divided by 4 in place
(`(v << 16) >> 18`, `func_80079F4C`). World position = chunk centre + (loaded vertex << 10) (`func_80068B48`), so the
stored units are 1/256 of the 16.16 world unit.

**Quad** (6 B) ★★★: `{u16 material, u8 v[4]}`. Triangles repeat an index (773 of 408,005 quads). `material` indexes
COL type 2 (§2): in all 15 files every index is below that file's material count. Vertex indices are u8, so a chunk
holds at most 256 vertices.

### 1.5 Sub-blocks — 8-byte header `{u32 length, u16 type, u16 count}`
`func_8009E870(chunk, type)` finds a sub-block by type; `func_8007A198` binds them into the 0x58-byte
"Chunk_tChunkDat" (size printed by name). Stores in `jal` delay slots capture the previous call's result, which gives
this slot map:

| ChunkDat | Content | | ChunkDat | Content |
|----------|---------|-|----------|---------|
| +0x00 | chunk | | +0x2C | type 0x11 |
| +0x04 | geometry block | | +0x30 | type 0xA |
| +0x08 | type 8 | | +0x34 … +0x48 | quad arrays q0 … q5 |
| +0x0C | type 7 | | +0x4C | type 4 list (header + 8) |
| +0x10 | type 0x14 | | +0x50 | type 4 count (truncated at the first bad entry) |
| +0x14 | type 0x12 | | +0x54 | chunk +0xA (first sim slice) |
| +0x18 | type 0x13 | | +0x1C | type 6 |
| +0x20 | type 0xD | | +0x24 | type 5 |
| +0x28 | type 0xB | | | |

| Type | In chunks | Record | Tag | Meaning / evidence |
|------|-----------|--------|-----|--------------------|
| 4 | 2,234 | u16 | ★★★ | **visibility list**: low 10 bits = chunk index, range-checked ("Bad data in visibility list - out of range!"); identical to the `.VIS` text rows in 1,382 of 1,388 rows (6 rows of `00B` are stale) |
| 6 | 2,234 | 8 B `{u16 firstQuad, u8 quadCount, u8 n (4–9), i16 link[2]}` | ★★★ | **sim slices**: per chunk they partition q4 exactly (contiguous, total = q4, all chunks); the per-chunk counts sum to the COL slice count in all 15 files. `link` is −1/−1 except in a few slices (branch links?). Read by `func_80068F48` / `func_8006BE14` |
| 5 | 2,234 | 2 B | ★★ | one surface word per q4 quad (count = q4 in all chunks); addressed as `type5 + 8 + 2·(firstQuad + i)` by `func_80068F48` |
| 0xD | 2,234 | 12 B | ★ | read with type 5 / q4 by the sim code (`func_80069E14`, `func_80068F48`); layout open |
| 8 | 1,832 | `{u32 size, u16 vertexCount, u16 quadCount}` + vertices (8 B) + quads (6 B), padded to 4 | ★★★ | **object definitions** of the chunk: size exact for all 10,881 records and each chain ends at the block end |
| 7, 0x12, 0x13, 0x14 | 1,367 / 1,557 / 71 / 4 | instance records, below | ★★★ | object instances (drawn by `func_800B2C18`, which reads all four); 0x14 = "kOBJSFXINST" per the COL log string |
| 0xB | 632 | 20 B `{i32 point[3]; i16 radius, i16 serial; u8 ×4}` | ★★ | **sim objects**, one per kind-4 instance (§1.5.1); same shape as NFS4 `Trk_SimObject` |
| 9 | 1,345 | 4 B | ★ | NFS4 type 9 = centre/edge lines (same size) |
| 0xA | 248 | 16 B | ★ | NFS4 type 0xA = light flares `Trk_SFX` (same size) |
| 0x11 | 36 | not size-prefixed; varies | ★ | open |

#### 1.5.1 Instance records (TRK 7/0x12/0x13/0x14, COL 7/0x12) ★★★
`{u16 size, u8 kind, u8 objectDef, …}`, walked by `size`. `objectDef` is below the object-definition count of the
same container (chunk type 8 or COL type 8) in all 10,906 records.

| Kind | Size | Payload after the 4-byte header |
|------|------|---------------------------------|
| 1 | 16 | i32 position[3] (16.16) |
| 4 | 20 | i32 position[3]; i32 sim-object index: a chunk has as many kind-4 instances as type-0xB records (all chunks), and the indices are exactly 0 … n−1 |
| 3 | 8 + 20·frames | u16 frameCount, u16 interval; then frames of 20 B = NFS4 `Anim_tFrame` {i32 x, y, z; i16 qx, qy, qz, qw} (all 26 records exact) |

### 1.6 Census ★★★
All 15 files pass every check in `tools/nfs3_trk.py census`: magic/version, meta count = ceil(chunks/8),
`StmMetaI` = chunk/8, table end → first meta, meta headers, chunk size fields, sub-blocks inside their chunk,
header +8 / +0xC = largest meta / chunk.

| File | Chunks | Metas | | File | Chunks | Metas |
|------|--------|-------|-|------|--------|-------|
| 00A | 120 | 15 | | 03B | 180 | 23 |
| 00B | 175 | 22 | | 04A | 186 | 24 |
| 01A | 183 | 23 | | 04B | 216 | 27 |
| 01B | 212 | 27 | | 05A | 73 | 10 |
| 02A | 154 | 20 | | 05B | 69 | 9 |
| 02B | 189 | 24 | | 06A | 101 | 13 |
| 03A | 166 | 21 | | 07A | 112 | 14 |
| | | | | 08A | 98 | 13 |

## 2. `.COL` — persistent track data ★★★ (container)
`func_80068018` loads the whole file, logs the collection count, then dispatches each collection on its
type (jump table at `0x80047CE0`, types 2–0x14).

| Off | Type | Field |
|-----|------|-------|
| 0 | char[4] | `COLL` |
| 4 | u32 | 11 |
| 8 | u32 | file size (= actual size, all 15) |
| 12 | u32 | collection count |
| 16 | u32[count] | collection offsets, relative to +16 |

Each collection starts with the same 8-byte header as a TRK sub-block: `{u32 length, u16 type, u16 count}`.

| Type | Files | Element | Handler | Name / role |
|------|-------|---------|---------|-------------|
| 2 | 15 | 10 B | `func_80067A48` → `func_80067A8C` | **materials**, below |
| 8 | 10 | as TRK type 8 (§1.5) | kept in `gp+824`; vertices scaled by `func_80079EBC` | "kOBJECTDEF_COLLECTION" (object definitions; all 25 records exact) |
| 7 | 9 | instance records (§1.5.1) | kept in `gp+828` | "kINSTANCE_COLLECTION" (object instances; all kind 3 = animated) |
| 0x12 | 2 | instance records (§1.5.1) | kept in `gp+832` | persistent instances of the 0x12 kind (all kind 3) |
| 0xF | 15 | 36 B | `func_8006869C` "Opened track sim file and found %d slices" | track slices |
| 0x14 | 0 | | log only | "kOBJSFXINST_COLLECTION" (not on the NFS3 disc) |

**Material** (COL type 2, 10 B) — same layout as NFS4 `Trk_Material`:

| Off | Type | Field | Tag |
|-----|------|-------|-----|
| 0 | u16 | shape index in the track's `ZTR<NN><v>0.PSH` | ★★★ `func_80067A8C` indexes the pixmap table with it; with the animation frames it stays below the PSH shape count in all 15 tracks (5,521 records) |
| 2 | u8 | flags (values 0, 0x10–0x70 step 0x10, 4, 0x24) | ★ meaning open (NFS4: 0x02 multi-palette, 0x04 animated, 0x80 scrolling) |
| 3 | u8 | `uvFlag`: flip/rotate bits; `& 0x5E` creates a derived pixmap (bits 0x02/0x04/0x08 select the variant, 0x10/0x40 transform) | ★★★ `func_80067A8C` |
| 4 | u8 × 3 | r, g, b tint (178,178,178 in 79 %; 0,0,0 in 15 %) | ★★ (NFS4 lineage) |
| 7 | i8 | animation frame count (0 = static) | ★★★ loop bound in `func_80067A8C` |
| 8 | u8 | animation interval | ★★ (NFS4 lineage) |
| 9 | u8 | 0 | ★★★ census |

## 3. Lineage to NFS4 ★★
`.TRK` + `.COL` are the direct ancestors of the NFS4 `.GRP`; most NFS4 structures exist here first, some as the
live form of what NFS4 keeps only vestigially.

| NFS3 | NFS4 | Change |
|------|------|--------|
| TRK header {max meta size, max chunk size, 2 budgets, metaCount = ceil(chunks/8), chunkCount} | `TrackHeader` (only `chunkCount` read) | budgets became dead metadata once streaming was dropped |
| meta-chunks of 8 chunks streamed from CD | whole GRP loaded at once | |
| sub-block header `{u32 length, u16 type, u16 count}` (8 B) | `{type, length, 0xCDCDCDCD, count}` (16 B) | same type enum: 2 materials, 4 visibility, 5 sim quads, 6 sim slices, 7 instances, 8 object definitions, 9 lines, 0xA flares, 0xB sim objects, 0xF slices |
| chunk header {size, size, count, firstSimSliceInd, chunkInd, 0, 4 × i32 xyz bound points} | chunk meta `0x1C` {A, A, small count, firstSimSliceInd, chunkInd, pad, boundPts, chunkboundPts} | NFS4's unexplained "value A ×2" and "small count 4–9" are most likely NFS3's chunk size ×2 and sub-block count (★) |
| geometry header {u32 rel, n0, n1, n2, n3, q0 … q5} | quad counts `0x1B` (12 × i16) | NFS4's open s[0] (1,600–3,000, s[1] = 0) is NFS3's u32 offset to the sub-block table; s[2..5] = n0 … n3 |
| six quad arrays, low / medium / high detail × {main, extra} | `0x19` holds only `[c0][c1][c4][c5]` | NFS4 dropped the medium level: its c2/c3 space holds exporter heap fill |
| vertex `{i16 x, y, z; RGB555 colour}` | `CCOORD16 {x, y, z, light index}` | per-vertex colour became an index into the light table |
| `Trk_Quad` `{u16 material, u8 v[4]}`, world = centre + (vertex << 10) | same | |
| material (COL type 2, 10 B) | `Trk_Material` (10 B) | same layout |
| sim slice (type 6, 8 B) partitions the high-detail quads | `Trk_NewSimSlice` (5 B) | |
| visibility list u16, `.VIS` text source, flag 0x800 | same list, bits 0x800/0x1000/0x2000/0x4000 | |
| instance `{u16 size, u8 kind, u8 def}` kinds 1/3/4; animated = 20-byte frames | kinds 1/2/5/9/3/7/8; `Anim_tFrame` 20 B | NFS4 widened the animated header by 4 bytes |

Other moves: NFS3's `.DPQ` carries the car env-map zone list that NFS4 moved to its text `.ENV`.

## Open questions (next steps)
1. TRK type 5 (surface word), type 0xD (12 B), type 0x11, the extra quad arrays (q1/q3/q5), sim-slice byte 3 and links.
2. COL slices (type 0xF, 36 B) and the material flag byte +2 (compare with NFS4 `Trk_NewSlice` / `Trk_Material`).
3. TRK header +0x10/+0x14.
4. Variant meaning (front-end track table) and the track-ID special case for 02b.
5. `.CCM`, `T{B,F}.BIN`, `.COP`, the `A.VIV` contents; confirm QSL/QSS/QTS and VIS are never opened (runtime
   CD file-open trace).
6. Runtime validation (DuckStation, as done for NFS4): dump `Chunk_tChunkDat` for a loaded chunk.

## Tools
- `tools/nfs3_trk.py` — `trk`, `col`, `census` (container validation above).
- `tools/psx_iso.py` — extraction.
