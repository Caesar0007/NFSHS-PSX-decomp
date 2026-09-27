# NFS3 track files — file set, loaders, TRK/COL records

Game: Need for Speed III: Hot Pursuit, PSX USA retail **SLUS-006.20**. Status: file set, loader map, track identity (menu → ID → files), both binary containers (`.TRK`, `.COL`)
with their records, and the `.CCM`, tutor `.BIN` and `.COP` files are established; the remaining details are listed
under *Open questions*. Tags per [METHOD.md](../METHOD.md).

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
The race track ID is config word `0x800F9F80`: **low nibble = file number, bit 4 = second layout (`b`)**.
File names are built as `<prefix>Tr<NN><v><suffix>` with `v = 'a' + (id >> 4)`; the streamed geometry uses
`zzTr` (`%szzTr%02d%c%s` when the suffix is `.trk`). Files keyed by the whole ID print it in decimal
(`ZTR16…` = ID 0x10).

**How the front end sets it ★★★.** `FRONT.BIN` hands race settings to the game as `{key, value}` records;
the key names (`CONTROL`, `RACETYPE`, `TRACK`, `WEATHER`, `REVERSE`, …, table at `0x80042B18`) and the
key → address table the game's setter uses (`func_80083F4C`, table `0x800F9CCC`) map TRACK to `0x800F9F80`
(runtime: written once, just before the race loads, at `0x80084100`; `tools/runtime/nfs3_boot_watch.py`).
The value comes from the menu's 14-entry track table at `0x80043938`, and the names from the game text
(`ZTEXT.ENG`, same order):

| Menu | Name | ID | Files | | Menu | Name | ID | Files |
|------|------|----|-------|-|------|------|----|-------|
| 0 | Hometown | 0x00 | 00A | | 7 | The Summit | 0x14 | 04B |
| 1 | Redrock Ridge | 0x01 | 01A | | 8 | Empire City | 0x02 | 02A |
| 2 | Atlantica | 0x03 | 03A | | 9 | The Room | 0x05 | 05A |
| 3 | Rocky Pass | 0x04 | 04A | | 10 | Caverns | 0x06 | 06A |
| 4 | Country Woods | 0x10 | 00B | | 11 | AutoCross | 0x07 | 07A |
| 5 | Lost Canyons | 0x11 | 01B | | 12 | Space Race | 0x08 | 08A |
| 6 | Aquatica | 0x13 | 03B | | 13 | Scorpio-7 | 0x15 | 05B |

So the `b` layouts are **separate named tracks that share scenery with their `a` partner**. The geometry shows it
directly: each b track follows its partner chunk-for-chunk at the start and the end and replaces the middle
(e.g. Lost Canyons = Redrock Ridge chunks 0–55, then 140 own chunks, then Redrock Ridge 167–182); Scorpio-7
(05B) shares nothing with The Room (05A). The per-ID AI/cop files (`Q*`, `.QTS`, `BEG/EXP.COP`) exist for the
nine main tracks: IDs 00–04 and 16, 17, 19, 20 (= 0x10, 0x11, 0x13, 0x14); ID 18 has only a `.QTS`; the bonus
tracks (05–08, 0x15) have none.

**02B is unreachable as a track ★★★.** No menu entry maps to 0x12. The only 02B file the game ever loads is
`ZTR02BR.PSH` (reflection maps): `func_80065EB0`, used only for `R.psh`, forces `02b` when the track is Empire
City (02) and WEATHER (`cfg[0x12]`) is on, i.e. wet-road reflections. Every other loader builds its letter
from `id >> 4`, so 02B's `.TRK`, `.COL`, `0.PSH`, `.DPQ`, `.HRZ`, `.CLR` and `A.VIV` are never opened.

Race options used by the track files (`0x800F9F44 + 4·k`, from the setter's table): `cfg[0x2]` SKILL,
`cfg[0x5]` COPS, `cfg[0xB]` MIRROR, `cfg[0xC]` REVERSE, `cfg[0xD]` TUTOR, `cfg[0xF]` TRACK, `cfg[0x12]` WEATHER,
`cfg[0x13]` TIME.

## File set and loaders
`v` = variant letter; `.<lang>` = ENG/FRE/GER/ITA/SPA.

| File | Magic / kind | Loader (raw VA) | Tag | Notes |
|------|--------------|-----------------|-----|-------|
| `ZZZTR<NN><v>.TRK` | `TRAC` v22, streamed | `func_800799A4` "BWorld Init" → `func_800C370C` | ★★★ container | §1 |
| `ZTR<NN><v>.COL` | `COLL` v11 | `func_80068018` "Opened track Persistent file and found %d collections" | ★★★ container | §2 |
| `ZTR<NN><v>.CCM` | binary | `func_800660A4` → `func_8006BB78(".ccm")` | ★★★ | trackside cameras, §4 |
| `ZTR<NN><v>0.PSH`, `…R.PSH` | SHPP shape files | `func_80067960` ("0.psh", "R.psh") | ★★★ container | textures / reflection maps; format as [NFS4_PSH.md](NFS4_PSH.md) (to re-verify on NFS3) |
| `ZTR<NN><v>A.VIV` | BIGF archive of `.CAN` | `func_8005B878` ("%sA.viv") | ★★★ container | camera animation scripts, §8 |
| `ZTR<NN><v>.DPQ` | text | `func_800A7250` ("%sTr%02d%c.dpq") | ★★★ | depth cue + car env-map zones, §10.2 |
| `ZTR<NN><v>.HRZ` | text | `func_800B84BC` ("%sTr%02d%c.hrz") | ★★★ | horizon and sky, §10.1 |
| `ZTR<NN><v>{D,N,W}.CLR` | text | `func_80080C18` ("%sTr%02d%c%c.clr") | ★★★ | car paint (HSV + reference) per condition, §10.3; also `carmenu.clr` |
| `ZTR<NN><v>{,N,NW,W}.BNK` | `BNKl` sound bank | ".bnk" builders | ★★★ container | per condition, §11 |
| `ZTR<NN><v>T{F,B}.BIN` | tutor prompts | `func_80081DB4` ("at"/"bt" + "f.bin"/"b.bin"), only when TUTOR is on | ★★★ | §5 |
| `ZTR<NN><v>.VIS` | text `#chunk` + list | **none**: never opened (runtime trace, §9) | ★★★ | exporter source of TRK sub-block 4 (§1.5) |
| `ZTR<NN>{F,R}.Q{A,S}{L,S}`, `.QBE`, `ZTR<NN>.QTS` | Huffman `30FB` | `func_8005791C` (extensions stored as "letter − 1") | ★★★ | AI speed / line tables, §7 |
| `ZTR<NN>{BEG,EXP}.COP` | cop triggers | `func_800520FC` ("%sTr%02d%s.cop"), only when COPS is on | ★★★ container | §6 |
| `ZTR<NN>CSP.<lang>`, `ZZZTR<NN>C.<lang>` | speech clip table + clips | `func_80081DB4`, `func_80083688` ("cop speech", streamed through a 32 KB "CopSpk Buf") | ★★★ | §11 |
| `ZZZTR<NN>A.TRJ`, `ZZZTR<NN>B.TRM` | `SCHl` EA audio stream | `func_800A01D4` | ★★★ container | rock / techno music streams, §11 |
| `ZTR<NN>{PGR,PGT,R<nn>,T<nn>,ROK,TEC,TOK,R0A,R0B}.MAP` | `PFDx` | `func_800A01D4`, `func_800A0590`, `func_800A0C70` | ★★★ container | interactive-music maps, §11 |

## 1. `.TRK` — streamed track geometry ★★★
### 1.1 Header (32 bytes) — `func_800C370C`, accessors `func_8009E694…8009E784`
| Off | Type | Field | Evidence |
|-----|------|-------|----------|
| 0 | char[4] | `TRAC` | compared (`func_800C7444`, 4 bytes) |
| 4 | u32 | version = **0x16** | compared; load fails otherwise |
| 8 | u32 | "MaxMetaChunkSize" | printed by name; = largest meta-chunk in all 15 files; the streaming buffer size |
| 0xC | u32 | "MaxGeomSize" | printed by name; = largest chunk in all 15 files |
| 0x10 | u32 | budget; **never read**: its accessor `func_8009E754` has no caller and no other load reaches the word (EXE-wide `jal`/`lw` scan) | ★★★ unread |
| 0x14 | u32 | budget; **never read** (accessor `func_8009E784` uncalled, same scan). The meta-count accessor `func_8009E6C4` is uncalled too | ★★★ unread |
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
| 4 | u16 | n0: **seam vertices**, stored relative to the *next* chunk's centre (the last chunk wraps to chunk 0) and re-based on load; they belong to every level (0 in 2,031 chunks) |
| 6, 8, 0xA | u16 × 3 | n1 ≤ n2 ≤ n3: vertex counts of the low / medium / high level of detail; a level uses the first `n0 + nK` vertices |
| 0xC … 0x16 | u16 × 6 | quad counts q0 … q5 |
| 0x18 | 8 B × (n0 + n3) | vertices |
| … | 6 B × q0 … q5 | six quad arrays, back to back; then 0–3 bytes of padding up to `rel` |

Level of detail: `func_80066AF8` picks a level from the chunk's squared distance, and the table at `0x800F6898`
maps it to `{vertex level, array}` = (1, 0), (2, 2), (3, 4). For each visible chunk the renderer (`func_800B1F1C`)
transforms `n0 + n_level` vertices and draws **two passes**: array k with ordering-table depth bias 125 (0x7D), then
array k+1 with bias 30 (0x1E). The odd arrays therefore sort in front of the main surface (the same bias mechanism
as NFS4's `goffsets`). Census (all 2,234 chunks): `n0 ≤ n1 ≤ n2 ≤ n3`; the block ends within 3 bytes of `rel`; every vertex
index of arrays 0/1 is below `n0 + n1`, of arrays 2/3 below `n0 + n2`, of arrays 4/5 below `n0 + n3`.

| Array | Level | Content |
|-------|-------|---------|
| q0, q1 | low | q0 = main geometry at low detail (presumably the trough, ★★); q1 = overlay quads (bias 30) |
| q2, q3 | medium | q2 = main geometry at medium detail (★★); q3 = overlay quads (bias 30) |
| q4, q5 | high | q4 = the trough exactly as covered by the sim slices (type 6) and surface words (type 5); q5 = overlay quads (bias 30) |

The overlay arrays hold 0.6 % of all quads (2,290 of 408,005) and use only materials below 374; drawn in front of
the surface, they are decals such as markings or shadows (★★ for that reading; the draw order is ★★★).

**Vertex** (8 B) ★★★: `{i16 x, y, z; u16 colour}`. The colour is RGB555, split into three 5-bit channels by
`func_800B16D4` (0x6317 = 23, 24, 24 → grey) and used for Gouraud shading. On load
(`func_80079F4C`, runtime-verified in §1.7), in this order: the four bound points become centre-relative;
x/y/z of all `n0 + n3` vertices are divided by 4 (`(v << 16) >> 18`); the first n0 vertices get
`(d + (d >> 7)) >> 10` added per axis, with d = next centre − this centre (16.16); and `func_80079EBC` divides
the object-definition vertices (type 8) by 4. Colours are untouched. World position = chunk centre + (loaded vertex << 10) (`func_80068B48`), so the
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
| 6 | 2,234 | 8 B `{u16 firstQuad, u8 quadCount, u8 n (4–9), i16 link[2]}` | ★★★ | **sim slices**: per chunk they partition q4 exactly (contiguous, total = q4, all chunks); the per-chunk counts sum to the COL slice count in all 15 files. `n` (byte 3) = **interactive-music event**: `func_8006BE14` reads it up to 16 slices ahead of the car and `func_8005FC14` posts it (min 4) as a PathFinder event (`SNDpathevent`, `func_800ECDD4`, range-checked against the event count, byte 7 = 16, of the loaded `PFDx` `.MAP`; §11.3). `link[2]` = global slice indices of alternative routes: when one is not −1, the "slice jump" code (`func_80069E14`) re-resolves the car onto whichever slice is closer. All 196 links on disc are valid slice indices (192 slices with one link, 2 with both) |
| 5 | 2,234 | 2 B `{u8 frame, u8 flags}` | ★★★ / ★★ | one word per q4 quad (count = q4 in all chunks), addressed as `type5 + 8 + 2·(firstQuad + lane)` by the sim code (`func_80068F48`, `func_80069E14`). `frame` indexes the chunk's type-0xD table (below it in all 225,739 words). `flags`: bits 0–5 = **surface id** (the car keeps it at +0x1C0/+0x1C4; getter `func_8006BD28`), bit 0x80 = triggers a ±3.5-unit height test in `func_80071874`, **bit 0x40 = check object collisions**: on such a quad the car gathers the nearby sim objects (type 0xB, `func_8006AA2C`) and tests contact (`func_80080664` → `func_80080468`, `func_8006834C`); 629 chunks with 0x40 quads have sim objects and the other 53 border chunks that do. Surface 0xE = **wall**: a sideways move onto it is refused (`func_80068F48`); groups {1, 7, 0xA, 0xC, 0xD} are tested together by `func_8006C044` / `func_800A5B08`. On disc: 0, 1, 2, 3, 5, 7, 0xA–0xF (0xE = 43 %) |
| 0xD | 2,234 | 12 B `{i16 normal[3], i16 direction[3]}` | ★★ | quad orientation frames, shared by quads through type 5's `frame`. Both vectors are unit length in 1.15 fixed point (all but 31 of 166,240 records); `normal` points up in 63 %, and the two are orthogonal in 79 % |
| 8 | 1,832 | `{u32 size, u16 vertexCount, u16 quadCount}` + vertices (8 B) + quads (6 B), padded to 4 | ★★★ | **object definitions** of the chunk: size exact for all 10,881 records and each chain ends at the block end |
| 7, 0x12, 0x13, 0x14 | 1,367 / 1,557 / 71 / 4 | instance records, below | ★★★ | object instances (drawn by `func_800B2C18`, which reads all four); 0x14 = "kOBJSFXINST" per the COL log string |
| 0xB | 632 | 20 B `{i32 point[3]; i16 radius, i16 serial; u8 ×4}` | ★★ | **sim objects**, one per kind-4 instance (§1.5.1); same shape as NFS4 `Trk_SimObject` |
| 9 | 1,345 | 4 B `{u8 vertex, u8 slice, u8, u8}` | ★★ | **road lines** (fetched in `func_800B4AF8`, built by `func_800B496C`): `slice` is relative to the chunk's first sim slice; each point is the chunk vertex ± the slice's `right` vector (top 5 bits of each s8), giving a painted line's two edges. Byte 2 = **line style** of the segment to the next point: 0xFF = no line, else k selects pixmap `0x8010BD04[k]`, which the loader at `0x800C3A40` fills from shapes `LIN0`…`LIN9` of `ZSFX.PSH` (48×16 textures); on disc: 0, 1, 2, 5, 6, 0xFF (`func_800B4090`). Byte 3 is never read (★★★ unread; the only type-9 lookup feeds these two functions). NFS4 `Trk_Line` has the same size |
| 0xA | 248 | 16 B `{i32 position[3]; u16 flareType, u16 0}` | ★★★ | **light flares** (NFS4 `Trk_SFX`): the world draw `func_80066F60` passes each visible chunk's list to `func_80066384` → `func_800B71CC` (projected from position − camera). Flare types 2/5/7/0xC/0x10 blink on a frame timer, 6 with a phase offset. Per-type colours and size come from a 17-entry table at `0x8010B250` `{u8 core rgb, pad; u8 halo rgb, pad; i32 size}` (1 = orange streetlight, 5/6 = red, 0xC/0xF = blue, 7 = green, 0x10 = yellow). On disc: types 1 (235), 2, 4, 5, 6, 7, 0xC, 0xF, 0x10; +14 always 0 |
| 0x11 | 36 | 16 B `{i32 position[3]; u16 soundId, u16 mode}` | ★★★ | **ambient sound emitters**: for each chunk in the camera chunk's visibility list, `func_800672C0` passes this list to `func_80067430`, which derives volume (0x10000 / distance², ≤ 127) and pan from the listener, then calls the sound player `func_80061720(0x11, soundId, …)`; mode 1 takes a random-interval path. On disc: one record per block (35×), two once; sound ids 0–20 |

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

### 1.7 Runtime check ★★★ (DuckStation, track 00A)
`tools/runtime/nfs3_track_probe.py` boots the retail disc in the modified DuckStation and drives the front end
by rewriting the pad record at `0x8012E2F0` on the `jr ra` of `func_800DE180` (Cross/Start pattern, race after
~7,000 ticks). It stops at `0x8007A728`, right after each chunk is copied, bound (`func_8007A198`) and relocated
(`func_80079F4C`), and saves checkpoint `nfs3_after_chunks`. `nfs3_track_probe2.py` resumes from that checkpoint,
holds accelerate and captures further chunks. `compare_nfs3_chunks.py` checks the dumps against this spec.

| Check | Result |
|-------|--------|
| TRK header (32 B) and the `StmChunkF` / `StmCenter` / `StmMetaI` tables in RAM | byte-identical to the file |
| chunk source in the meta-chunk stream buffer | byte-identical to the file, 56 captures |
| loaded chunk vs the file after the predicted relocation (§1.4.1) | byte-identical, 56 captures covering 48 distinct chunks (0–30, 104–119), including the wrap-around seam of chunk 119 |
| every `Chunk_tChunkDat` slot (§1.5) | equals the parser's prediction in all 56 captures |
| material list (gp+844) | 403 entries, each pointing at its 10-byte record in the loaded COL |
| slice array | 959 × 36 B, byte-identical to the file's type-0xF payload |
| whole COL buffer (`0x800247EC`; gp+884 = its +0x10) | identical except the reused 16-byte header and the object-definition vertices, which are exactly the file's divided by 4 |
| material and slice counts the game uses | 0x193 = 403 and 0x3BF = 959, the `.COL` counts |

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
| 0xF | 15 | 36 B | `func_8006869C` "Opened track sim file and found %d slices" | **track slices**, below |
| 0x14 | 0 | | log only | "kOBJSFXINST_COLLECTION" (not on the NFS3 disc) |

**Material** (COL type 2, 10 B) — same layout as NFS4 `Trk_Material`:

| Off | Type | Field | Tag |
|-----|------|-------|-----|
| 0 | u16 | shape index in the track's `ZTR<NN><v>0.PSH` | ★★★ `func_80067A8C` indexes the pixmap table with it; with the animation frames it stays below the PSH shape count in all 15 tracks (5,521 records) |
| 2 | u8 | flags, read per quad by both track renderers (`func_800B16D4`, `func_800AFB5C`; runtime read-watch found no other reader, and no other 0x20 test in the EXE follows a material load): **0x04 = animated** (frame = (timer / interval) mod frameCount, the pixmap advances 16 B per frame; set exactly when +7 > 0, all 5,521 records); **0x40 = one-sided** (the quad goes through the `nclip` back-face test; without it both sides are drawn); **0x10 = force double-sided** (overrides 0x40, chunk renderer only); **0x20 = never read** (exporter flag). Counts: 0x40 × 1,122, 0x20 × 858, 0x10 × 289, 0x04 × 40 | ★★★ |
| 3 | u8 | `uvFlag`: flip/rotate bits; `& 0x5E` creates a derived pixmap (bits 0x02/0x04/0x08 select the variant, 0x10/0x40 transform) | ★★★ `func_80067A8C` |
| 4 | u8 × 3 | r, g, b tint (178,178,178 in 79 %; 0,0,0 in 15 %) | ★★ (NFS4 lineage) |
| 7 | i8 | animation frame count (0 = static) | ★★★ loop bound in `func_80067A8C` |
| 8 | u8 | animation interval (divisor of the frame timer; non-zero for all 40 animated materials) | ★★★ |
| 9 | u8 | 0 | ★★★ census |

**Track slice** (COL type 0xF, 36 B) — census over all 17,818 slices; readers found statically and with runtime read
watchpoints (`tools/runtime/nfs3_watch_probe.py`). NFS4 `Trk_NewSlice` (32 B) is its descendant:

| Off | Type | Field | Tag |
|-----|------|-------|-----|
| 0 | i32 × 3 | centre, 16.16 world position (lane positions are built from it, `func_8006ADC8`) | ★★★ |
| 12 | s8 × 3 | normal (up), length ≈ 127 in every slice; scaled by a height offset in `func_8006ADC8` | ★★★ |
| 15 | s8 × 3 | forward, length ≈ 127 | ★★ |
| 18 | s8 × 3 | right, length ≈ 127; lane positions step along it (`func_8006ADC8`) and its top 5 bits give road-line half-widths (`func_800B496C`) | ★★★ |
| 21 | u8 | **acoustic class** left (high nibble) / right (low nibble): the environment-audio tick `func_800A10D4` takes the smaller nibble as an index into a per-track table (`0x80109690[track]`), switching to the covered variant when +30 says covered. NFS4 kept this byte as `acousticType` but no longer reads it | ★★★ |
| 22 | u16 | owning chunk index (all slices; slice *i* lies inside that chunk's sim-slice range); used to find and force-load the chunk (`func_80068E68`, `func_8006BE14`) | ★★★ |
| 24 | u16 | **legal-path lane mask**: bit `14 − lane` set = lane allowed (`func_8005B25C` builds the car's bit, `func_8005B29C` tests it). The wrong-way / off-path checker `func_8004A22C` penalises a car whose lane bit is missing ahead. Wider than the +31 lane counts (only 645 slices match NFS4's `[7−L, 6+R]` rule; e.g. 0x03C0 = lanes 5–8 with +31 = 0x11) | ★★★ |
| 26, 28 | u16 × 2 | **left / right drivable extents**, `<< 8` = 16.16 world units: `func_80054800` treats a car whose lateral offset passes −(35.0 + left) or +(35.0 + right) as off the road (NFS4 `leftDrive` / `rightDrive`) | ★★★ |
| 30 | u8 | **cover** left / right nibbles: value 2 = covered (tunnel). A covered slice 8 ahead of the car replaces the sky with a flat dark quad (`func_8006BD70` → `func_800B97F8`) and selects the covered acoustic variant. Other values (0, 1, 4, 5) are not distinguished by any code | ★★★ |
| 31 | u8 | **lane counts**: high nibble = lanes left of centre, low nibble = right (`func_8006ADC8`) | ★★★ |
| 32, 33 | u8 × 2 | **lane width** left / right, `<< 15` = world units: `func_8006ADC8` places the outer lane edge at centre ± right × laneCount × laneWidth (NFS4 `avgPavedWidthLf/Rt`) | ★★★ |
| 34 | u16 | 0; never read (runtime read-watch, 2,000 frames) | ★★★ |

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
| flares (type 0xA, 16 B `{pos, type}`) + 17-entry colour table | `Trk_SFX` (16 B), type 0xA | same size and type number |
| ambient sound emitters in each chunk (type 0x11) | per-track `.AUD` file | moved out of the geometry |
| music section per sim slice (byte 3) → PathFinder `.MAP` | — | |

Other moves: NFS3's `.DPQ` carries the car env-map zone list that NFS4 moved to its text `.ENV`.

## 4. `.CCM` — trackside cameras ★★★ (9 files, 86 cameras)
Loaded by `func_8006B8C0` (via `func_8006BB78`). Header `{u32 1, u32 count}`, then `count` × 28-byte records;
file size = 8 + 28 · count in every file.

| Off | Type | Field | Tag |
|-----|------|-------|-----|
| 0 | i32 × 3 | position, 16.16 world | ★★★ the loader finds the nearest slice to it (`func_800686EC` / `func_8006879C`) |
| 12 | i16 × 4 | orientation quaternion (x, y, z, w; 0x4000 = 1.0, unit length in all 86) | ★★★ turned into a 3×3 matrix by `func_80095388` |
| 20 | i16 | **field of view** in degrees (47–78): unless kind bit 1 is set, `func_8006E30C` turns it into the projection distance (gp+964, from sin/cos of the angle) | ★★★ |
| 22 | u16 | camera kind (0 × 33, 1 × 27, 3 × 26): **bit 0 = track the car** (clear: the quaternion's matrix fixes the view direction), **bit 1 = keep the default lens** (ignore the FOV). So 0 = fixed aim, 1 = tracking, 3 = tracking with the default lens | ★★★ |
| 24 | i32 | slice index, **written at load** (file value −1) | ★★★ |

After loading, the records are sorted by slice, and `func_8006BA90` builds a camera schedule at `0x800F7380`
(12-byte entries `{i16 kind, u8 index, …, i32 slice}`): each camera becomes a kind-2 entry at its slice and the
gaps are filled with evenly spaced kind-1 (automatic) entries. The view code (`func_8006E30C` →
`func_8006B730` → `func_8006B63C`) fetches the active camera's position, matrix, angle and kind. (The
nfs3-clean comments call these records "sound spots"; the quaternion → matrix use says camera.)

## 5. `T{F,B}.BIN` — driving-tutor prompts ★★★ (18 files, 712 prompts)
`func_80081DB4` loads `<prefix>Tr<NN>` + `at`/`bt` (track bit 4) + `f.bin`/`b.bin` (REVERSE, `cfg[0xC]`), only
when the TUTOR option (`cfg[0xD]`) is on. The per-frame reader is `func_8008288C`.

A sequence of records, ended by −2:

| Field | Type | Meaning |
|-------|------|---------|
| slice | i32 | where the prompt belongs (all valid; `F` files ascending, `B` files descending) |
| lead | i32 16.16 | seconds of warning: the prompt fires once the car is within lead × speed of the slice (0.5–3 s on disc) |
| ids | i32 × n | message ids 0–17, 1–4 per record: each plays speech clip **id + 36** of `ZZZTR<NN>C.<lang>` (clip table `ZTR<NN>CSP.<lang>`, §11; `func_800826CC`). With MIRROR on, ids go through the swap table `0x800F9810` (0↔1, 2↔3, 4↔5, 16↔17: left/right prompt pairs); `0x800F97F8` gives each id a category 1–12 (−1 for 16/17), used alongside |
| end | i32 | −1 |

The reader adds lap × ring length to the slice (the lap counter stops at NUMLAPS) and mirrors it from the ring
end when REVERSE is on. (The nfs3-clean comment calls this reader "cop radio chatter".)

## 6. `.COP` — police pursuit triggers ★★★ container (18 files, 1,384 records)
`func_800520FC` loads `<prefix>Tr<id in decimal><BEG|EXP>.cop` when COPS (`cfg[0x5]`) is on; SKILL
(`cfg[0x2]`) = 0 picks BEG, otherwise EXP. Both branches use the full track ID (a branch-delay-slot load; the
nfs3-clean reconstruction wrongly reads `cfg[5]` in the EXP branch). Files exist for IDs 00–04, 16, 17, 19, 20.

`{i32 count}`, then records whose size is chosen by their type (`func_8005AB1C`):

| Type | Size | On disc | NFS4 struct | Fields after `{type, slice}` (NFS3 census) |
|------|------|---------|-------------|--------------------------------------------|
| 1 | 20 B | 490 | `trigger_roadblock_t` | i32 dir (±1), numCars (1; −1 in 48), spikeBelt (1/0) |
| 2 | 20 B | 245 | `trigger_simple_t` | i32 dir (±1), side (always 2), moving (always 0) |
| 3 | 72 B | 649 | `trigger_offroad_t` | i32 dir (−1/0/1); i32 position[3]; 3×3 i32 orientation (16.16); maxSpeed (50–100); releaseTime (96 or 90); endSlice |

Every record starts `{i32 type, i32 slice}`; all 1,384 slices are valid for the track, and every file ends
exactly after its last record. Records are nearly in slice order (31 backsteps: lap wrap-arounds such as a
type-1 record at slice 50 after the end of the list, and a few local swaps).

Trigger rule (`func_8005ACA4`): each player keeps a cursor into the list; a record fires when the car's slice
equals the record's slice, the type is not 2, and more than 0xA00 frame ticks have passed since that record
last fired (per-record timestamps at `+408` of the manager `0x800F4FE8`). The field names follow NFS4, whose structs have the same sizes and type numbers (NFS3 has no type 5);
the NFS3 values agree with them (unit orientation matrices, speeds, slice-like end values). Type 2 records are
looked up separately (`func_8005AEC8(…, 2)`, up to 4 consecutive) as spawn points.

## 7. AI speed / line files (`Q*`) ★★★ (Huffman-packed, see [NFS4_Q_CODECS.md](NFS4_Q_CODECS.md))
Loaded by `func_8005791C` (called from `func_800578EC`). The extensions are stored in the EXE **with every
character minus 1** (`func_800736F0` adds 1 back), which is why they never show up as plain strings. Each pair is
indexed by `STYLE > 0` (`cfg[3]`; table `0x800F4FA8` in 12-byte steps). The direction letter is `f`, or `r` when
REVERSE (`cfg[0xC]`) is on. If a file is missing, the game allocates a zeroed buffer of the listed size, named
by the allocation tag.

| File | STYLE = 0 / > 0 | Name pattern | Tag | Unpacked size (all files) | Reader |
|------|-----------------|--------------|-----|---------------------------|--------|
| racer speeds | `QSS` / `QAS` | `Tr<id><f/r>` | "racer speeds" | slices/2 + 1 (18 of 18) | `func_80057E40`: one u8 per two slices, target speed `<< 16` |
| traffic speeds | `QTS` | `Tr<id>` (no direction) | "Traffic Speeds" | slices/2 + 1 (9 of 10) | |
| speed line | `QSL` / `QAL` | `Tr<id><f/r>` | "Spd Line" | slices (18 of 18) | |
| best line | `QBE` (both) | `Tr<id><f/r>` | "best" | 3 × slices (18 of 18) | `func_80057E00`: per slice `{s8 lateral << 14, u8 << 12, u8 << 14}` (16.16); a missing file is seeded per slice by `func_80057DB8` |

The one size mismatch is `ZTR16.QTS` (Country Woods): 727 entries where 1,399 slices need 700, so it was made
for a longer earlier version of the track; the extra entries are never reached. The runtime file-open trace
(§9) shows `zTr00f.qas`, `zTr00.qts`, `zTr00f.qal` and `zTr00f.qbe` opened for a default race; `QSS`/`QSL` are the
STYLE = 0 set, so every `Q*` file on the disc is reachable.

## 8. `<v>A.VIV` — camera animation scripts (`.CAN`) ★★★ container
`func_8005B878` loads the BIGF archive, copies it to its own buffer and looks up `<name>00.can` … `<name>09.can`
(`%s%02d.can`, `func_800DC150`) into a 10-entry pointer table at `0x800F5954`. Scripts are played through 32
animation slots of 20 bytes (`{script, start time, …}`, `func_8005B9EC`); the callers are the view code
(`func_8006E30C` and neighbours), so these are camera paths, as in NFS4.

Every track's archive holds the same eight scripts: 00, 01, 02, 03, 06, 07, 08, 09 (02B: only 02 and 03), each
starting with a u16 equal to its own size. Scripts 01, 02, 03, 06, 08 and 09 are byte-identical on all tracks;
00 (10 versions) and 07 (6 versions) are track-specific.

**Script body ★★★** (all 114 scripts): the same layout as a kind-3 animated instance (§1.5.1):
`{u16 size, u8, u8, u16 frameCount, u16 interval}` + `frameCount` × 20-byte `Anim_tFrame`
`{i32 x, y, z; i16 qx, qy, qz, qw}`. Size = 8 + 20 · frameCount in every script, interval is always 6, and all
6,953 quaternions are unit length (0x4000). Bytes 2–3 are unused (0/0, or leftover values in scripts 02/03).
NFS4 keeps the same idea with a 12-byte header.

## 9. Runtime file-open trace ★★★
`tools/runtime/nfs3_open_trace.py` boots the disc, drives the menus into a default race (Hometown, day, no cops)
and logs every name passed to the file layer (`func_800DB910` load, `func_800DADAC` open). Track files opened:
`ztr00a.bnk`, `zTr00csp.eng`, `zTr00a.hrz`, `zTr00a.dpq`, `zTr00ad.clr`, `zTr00aA.viv`, `zTr00a0.psh`,
`zTr00aR.psh`, `zTr00a.col`, `zTr00a.ccm`, `zzzTr00a.trk`, then in the race `zTr00f.qas`, `zTr00.qts`,
`zTr00f.qal`, `zTr00f.qbe` and the music map `ztr00r0a.map`. `.VIS` is never opened (it is the exporter source
of TRK type 4). `.COP` and the tutor `.BIN` load only with COPS / TUTOR on.

## 10. Text parameter files (`.HRZ`, `.DPQ`, `.CLR`) ★★★
All three are read with `func_800B8388`: it skips `/* … */` comments and returns the next integer (`,` and
whitespace separate values). Values are read strictly in order; the comments are for people only.

### 10.1 `<v>.HRZ` — horizon and sky (`func_800B84BC`; 15 files)
| # | Values | Stored | Meaning |
|---|--------|--------|---------|
| 1 | 1 | gp+2508 | mirror flag |
| 2 | 1 | gp+2524 | make the sky's base flush with the horizon |
| 3 | 1 | gp+2504 | 0 = gouraud sky, 1 = textured (forced to 0 when WEATHER is on) |
| 4 | 1 | gp+2512 | horizon rotation in degrees (converted to 4096-per-turn units) |
| 5 | 1 | gp+2516 (`<< 5`) | height of the horizon's bottom above screen centre |
| 6 | 1 | gp+2520 (`<< 5`) | horizon height |
| 7 | RGB | `0x801261DC` | background colour behind horizon and sky |
| 8 | 3 × RGB | `0x801261E0/E4/E8` when WEATHER is off | gouraud sky: base front, base back, top |
| 9 | 3 × RGB | same slots when WEATHER is on | gouraud sky with weather |
| 10 | 3 × RGB | `0x801261E0`, `0x801261EC`, `0x80126188` when TIME = night | night: flat sky, horizon shading, world ambient (otherwise the ambient is 128, 128, 128) |
| 11 | RGB + C | `0x801267E0`; `C << 7` → `0x801266EC` | world colour with weather and its strength (read only with WEATHER on, else cleared) |
| 12 | 1 | — | "magic cookie" 123456789, never read |

The game reads 3 + 3 + 3 triples whatever the condition and keeps the set that applies. Special case: track 0x15
(Scorpio-7) sets the ambient red to 0x58. 12 files have 41 values; 06A, 07A and 08A have only RGB in block 11
(40 values), which is harmless because weather is not offered on those tracks.

### 10.2 `<v>.DPQ` — depth cue and car env-map zones (`func_800A7250`; 15 files)
| Values | Stored | Meaning |
|--------|--------|---------|
| 1 | gp+2328 | depth-cue (fog) start distance |
| RGB | gp+2332…2334 | depth-cue colour |
| up to 50 × `{slice, tex, extra, quad}` | table `0x80109FC4`, 6-byte entries `{i16 slice, i16 tex, u16 extra << 8 | quad}` | car SIDE env-map zones; a negative slice ends the list (stored as 0x7FFF) |
| same | table `0x8010A0F0` | car TOP env-map zones |

The zone list is NFS4's `.ENV` content (there a separate text file); the entry struct is NFS4's
`DrawC_tEnvMap {short slice, tex, extra}`, and the two zone indices live in the car at +210/+212 (NFS4
`eIndexEnvMap`/`eIndexShadow`, here named SIDE/TOP by the file comments).

**Zone lookup ★★★** (`func_80097F14`, 0x80098540): the zone index is the first entry whose `slice` is
greater than the car's slice, so an entry covers the slices from the previous entry's `slice` up to its own; the
`-1` terminator (0x7FFF) covers the rest of the track.

**Zone use ★★★** (`func_800A9F98`, per car per frame, from the car draw `func_800985D0`):
- `tex` selects one of the four reflection images `ref1`…`ref4` of the track's `<v>R.PSH` (every R.PSH holds
  exactly these four; `func_80067834` uploads them to VRAM (640, 256) and keeps 16-byte descriptors at
  `0x800F6FEC`, 12-byte prepared textures at `0x80109F88`). `0` = no reflection on that face.
- `quad` splits the road across: when the car's lateral quad index (its position struct +112, i.e. car +120;
  0 = leftmost, reset to the middle quad) is **below** `quad`, `extra` is used instead of `tex`. With `quad = 0`
  the test never passes, which is the file comment's "If QUAD is 0 then EXTRA is ignored".
- SIDE: image = `tex − 1` (negative → none). TOP: image = `|tex| − 1`; a **negative** TOP `tex` changes the map's
  horizontal scroll from `(car[+196] >> 6) & 63` to `(car[+196] >> 3) & 63`, i.e. 8× faster (used for tunnel
  roofs: `-3`, `-4`).

Census (all 15 files, no leftover values): SIDE `tex` ∈ {0, 1, 3, 4}, TOP `tex` ∈ {−4, −3, 0, 2, 4},
`extra` ∈ {1 (SIDE), 2 (TOP)}, `quad` ∈ 4…9 in the 15 split zones; 02B, 05A, 06A, 07A, 08A have empty lists.

### 10.3 `<v>{D,N,W}.CLR` and `ZCARMENU.CLR` — car paint (`func_80080C18`; 46 files)
Chosen by condition: `n` when TIME = night, else `w` with WEATHER, else `d`; the menus load `carmenu.clr`. The
game reads 88 entries of 4 values into `0x800F964C` (11 cars × 8 paints, in the order F355, CORV, COUN, NAZC,
F550, DIAB, JAGR, MCLK, BONS, "Diablo SV logo", "bonus car side"); all 46 files have exactly 352 values.

An entry is `{hue, saturation, value, reference}` (bytes), **not RGB**: the car renderer passes the first three to
the HSV → RGB routine `func_800813D0` and recolours only the "paintable" palette entries (red = blue, green
higher), scaling them by `value / reference` (car paint code at `0x80095FE8`, entries fetched with `func_80080DCC`). The 4th value (48–192) is
the brightness of the key colour in the car texture.

## 11. Track audio ★★★ (sound banks, speech, music maps, music streams)
These are EA's shared audio formats (the same `iSND`/`SND` library as the PC game; names below follow the
PC reconstruction in `nfs3-sound/nfs3snd/`, cross-checked against the PSX code and all files on the disc).

### 11.1 Sound banks `BNKl` ★★★ (95 files, 454 patches, 550 samples)
Header `{char[4] 'BNKl', u16 version = 2, u16 count, u32 dataStart, u32 slot[count]}`. Each non-zero slot is an
offset relative to the slot itself and points at a `PT` patch; the patches end at `dataStart` (86 banks within 3
bytes of padding), and the sample data runs from `dataStart` to the end of the file. Track banks come per
condition: `ZTR<NN><v>.BNK` (day), `…N.BNK` (night), `…NW.BNK` (night + weather), `…W.BNK` (weather); the runtime
trace loaded `ztr00a.bnk` for a day race.

**`PT` patch** (`iSNDgettag`, `iSNDplaytaggedpatch`): `{'P', 'T', u8 = 1 on PSX (the PC library requires 0),
u8 flags}` (flags bit 1 adds 4 more header bytes; bit 0 is set at run time once the patch is resolved), then a
tag list:

| Tag byte | Meaning |
|----------|---------|
| `0xFC` | padding, skipped |
| `0xFF` | end of the list |
| `0xFD` | start of a sample ("timbre"); its sample-header tags follow |
| `0xFE` | end of a split: play the timbre if the request falls in its ranges, then reset the attributes |
| other | `{tag, u8 length, value}`; length 0xFF = a 4-byte big-endian length follows; values of up to 4 bytes are big-endian integers |

Tags below 0x26 set per-timbre playback attributes (PC `ISndTaggedAttrs.word[tag]`; defaults in brackets):
1/2 velocity range [0, 127] and 3/4 key range [0, 127] (the play request's byte 6 is the velocity and byte 5
the key number: EA's own checks in the PC EXE print "VELOCITY OF %i OUT OF RANGE" / "KEYNUM OF %i OUT OF RANGE"
for exactly those bytes, in `iSNDcheckplayopts` and `iSNDplaytaggedpatch`), 5 channel class [−1], 7 root key
[60], 0xA detune (× 100 cents), 0xC pan [64] and 0xD its randomisation, 0xE volume [127] and 0xF its
randomisation, 0x24 random pitch. The rest (0x06, 0x08–0x0B, 0x10–0x23) are copied into the voice record
(envelope, priority, modulation; `iSNDplaytaggedtimbre` in `nfs3snd/isnd.c` lists every destination).
Sample-header tags after `0xFD`: **0x82 channels** (2 on 27 samples, else 1), **0x84 sample rate** (4,000–32,000 Hz;
11,025 on 165), **0x85 sample count**, **0x88 absolute file offset of the sample data**; 0x8A = 0 and 0x92 = 1 on
every PSX sample. There is no codec tag (0x83): PSX samples are SPU ADPCM, 16 bytes per 28 samples per channel.
Census: all 454 patches parse and end inside the header; all 550 samples lie inside `[dataStart, EOF)`, and 534
start with the ADPCM zero frame; some samples are shared by several patches (`ZGEN.BNK`).

### 11.2 Speech ★★★
`ZZZTR<NN>C.<lang>` holds the track's **speech clips**: 227 one-patch `BNKl` banks back to back, indexed by
**`ZTR<NN>CSP.<lang>`** = 227 `{u32 offset, u32 size}` pairs that tile the clip file exactly (all 25 language
files; all 5,675 clips start with `BNKl`). **`ZSPEECH.IDX`** names them: 236 u16 offsets, then C strings: 9
language names ("ENGLISH ONE" … "ITALIAN"), then one English line per clip, so **clip k = string k + 9**. It is
opened by the front-end routine `func_8002A460` (`"%sspeech.idx"`), next to the speech loader `func_80083688`;
the race code plays clips by number only.

| Clips | Speaker | Content |
|-------|---------|---------|
| 0–4 | announcer | best lap, lap record, final lap, split time, checkpoint |
| 5–10 | announcer | "Lap two" … "Lap Seven" |
| 11–18, 19–26, 27–34 | announcer | finishing place, 1st … last (single player, player one, player two) |
| 35 | announcer | "Ghost car activated" |
| 36–53 | coach | tutor ids 0–17 (§5): easy / medium / hard left and right, into, caution, jump, dip, chicane, S curve, slow down, speed up, obstacle, hairpin, left, right |
| 54–57 | coach | brake, easy, medium, hard (no tutor id reaches them) |
| 58–121 | Cop 1 | 64 pursuit lines (warnings, "Busted", arrest, roadblock, collisions, scream) |
| 122–185 | Cop 2 | the same 64 lines, second voice |
| 186–226 | Super Cop | 41 lines, including licence-loss lines ("Licence revoked", "Game over bud") |

The tutor mapping confirms the numbering: the MIRROR swap pairs 0↔1, 2↔3, 4↔5, 16↔17 (§5) are exactly the
left/right phrase pairs.

### 11.3 Music maps `PFDx` ★★★ (67 `.MAP`)
EA's interactive-music ("PathFinder") database, installed by `SNDpathinit` (PSX `func_800ECB54`):

| Offset | Size | Field |
|--------|------|-------|
| 0 | 4 | `'PFDx'` |
| 4 | 1 | version, must be 0 |
| 5 | 1 | start node |
| 6 | 1 | node count N |
| 7 | 1 | event count E (16 in every file) |
| 8 | 3 | 0 |
| 0xB | 1 | event-row count R |
| 0xC | 28 × N | nodes |
| | R × E | event matrix: `next = matrix[node.row · E + event]` |
| | 4 × N | big-endian file offset of each node's section in the music stream |

**Node** (28 B, read by the path service `func_800EC7D4`): `{u8 row, u8 branchCount, u8 0xFF, u8 0xFF,
branch[8] × {s8 lo, s8 hi, u8 next}}`. When a node's section finishes, the next node is the event transition if
an event is pending (`SNDpathevent`, PSX `func_800ECDD4`), else the first branch whose `[lo, hi]` contains the
control level (`SNDpathcontrol`, `func_800ECD88`, 0–127), else the same node again; a node without branches and
without a pending event ends the music. The chosen node's section is queued at its offset. Census: every file's
size is exactly `12 + 28N + RE + 4N`, R = highest row + 1, every `next` < N, bytes 2/3 = 0xFF in all 8,607 nodes,
branch counts 0–3, ranges within 0–100 (typically 0–28 / 29–72 / 73–100).

**Game side** (`func_8005FC14`, per frame in a race): the control level is 100 while some active car in the list
`0x800F82D8` has flag bit 2 at +1440 and lies between 15 and 125 units from a player (75 once the music is up),
otherwise 0, so the music intensifies during a chase. Car +132 is that distance: `func_80086C04` writes
`max(|dx|, |dz|) + min(|dx|, |dz|) / 4` from the car's position (+152/+160) to the player car every frame, keeping
the nearer of the two players in split screen. Bit 2 of +1440 is **police lights on**: the car draw (`0x800982E8`) animates a light phase at +2128 (0–15, one
step per frame) only for police models (ids 11–17 of the name table `0x800F9B8C`: TALN, LAM, CROW, LROV, CHEV,
COP1, COP2) with this bit set, and −1 otherwise; the bit is set by the per-car pursuit controller (vtable
`0x80047490`, `func_8004FB7C`), which the factory `func_8004C4C0` attaches to cars whose roster kind has 0x08/0x10
(the same cars `func_80074404` puts in `0x800F82D8`). Police models also get the cop radio lines: `func_8005E434`
picks clips from the 3-byte rows `{Cop 1, Cop 2, Super Cop}` at `0x800F5DF4` by the car's voice (+552), e.g. row 0 =
clips 77 / 141 / 201, "You can't out run the police!". So the music turns up while a police car with its lights on
is within range. The events posted are the sim slice's music byte (§1.5, type 6;
values below 4 are raised to 4, keeping 0–3 for the driver's own state changes).

**Streams**: 48 of the 67 maps match a stream on the disc exactly (every node offset lands on an `SCHl` header):

| Maps | Stream |
|------|--------|
| `ZTR<NN>R0A/R0B/R01/ROK/PGR.MAP` | `ZZZTR<NN>A.TRJ` (rock) |
| `ZTR<NN>TEC/T0x/PGT.MAP` | `ZZZTR<NN>B.TRM` (techno) |
| `ZZMENU0–5.MAP`, `ZZSHOW.MAP`, `ZZCREDIT.MAP` | the `.MUS` of the same name |

The other 19 (`ZTR01R00–06`, `ZTR01T00/02–06`, `ZTR04R00–03`, `ZTR04TOK`, all ten `ZTR05*`) fit no stream on
this disc: leftovers for songs that were not shipped. Streams are EA ASF: `SCHl` (header, a `PT` tag list as in
11.1) / `SCCl` (count) / `SCDl` (data) / `SCEl` (end) segments (1,729 segments; every file ends exactly).
Selection (`func_800A01D4`; the song number is the track number, with b tracks folded onto their a partner):

| Music style (`0x80125938`) | Map | Stream |
|----------------------------|-----|--------|
| rock (0) | `tr<NN>r0a.map` / `r0b.map` / `rok.map` | `ZZZTR<NN>A.TRJ` |
| techno (1) | `tr<NN>tec.map` | `ZZZTR<NN>B.TRM` |

Special song numbers: 0x30 = attract show (`zshow.map` / `zshow2.map` + `zshow.mus`), 0x31 = credits
(`zcredit.map` + `.mus`), 0x63 = a random rock/techno pick. The `pgr`/`pgt` and `r<nn>`/`t<nn>` maps are chosen by
the other music entry points (`func_800A0590`, `func_800A0C70`).

## 12. Surface ids and acoustic classes ★★★ / ★★
### 12.1 Surface ids
Byte 1 of TRK type 5, bits 0–5 (§1.5), one per q4 road quad. The code names none of them, so the names below come
from the **textures painted on those quads** (quad material → COL material → `0.PSH` shape; census of all 225,739
road quads, the ten most-used textures per id inspected) and agree with the parameter tables and the
reverb gate (§12.2). No shipped file names them: the PSX EXE, the PC `nfs3.exe` 1.02, the PC track and
audio data and the debug-info `MRC.EXE` tool were all searched, so these names stay ★★. NFS4 (same `simQuad->surface` byte) treats 0 and 0xE as undrivable (`Newton_*`,
`Netwon_CheckForBadQuad`).

| Id | Name (★★ texture evidence) | Quads | Where | `0x800F7EBC` | `0x800FA844` | `0x800F7EFC` (16.16) | `0x800F7F3C` sound | `0x800F7F7C` sound |
|----|------|-------|-------|---|---|---|---|---|
| 0 | void / non-road (water, black fill, grates) | 11,991 | everywhere, 02B/05B most | 1 | 1 | 0 | 0 | 0 |
| 1 | asphalt (the lanes) | 39,094 | all but 06A/07A, lane middle | 0 | 0 | 0 | 0 | 0 |
| 2 | gravel / rough rock | 2,411 | 00A, 03B, 06A | 1 | 0 | 0.70 | 7 | 3 |
| 3 | grass | 7,334 | 00A–04A verges | 1 | 1 | 0.60 | 8 | 11 |
| 5 | rock floor / packed dirt | 9,767 | 06A (Caverns), 07A, 01, 03A | 0 | 1 | 0.40 | 6 | 3 |
| 7 | wooden planks | 224 | 00, 03 bridges | 0 | 0 | 0.20 | 0 | 0 |
| 10 | concrete / pavement, shoulder, painted road | 29,863 | all asphalt tracks | 1 | 1 | 0.20 | 0 | 0 |
| 11 | planks and cobbles | 191 | 03 | 1 | 1 | 0.50 | 0 | 0 |
| 12 | wooden planks (edges) | 1,079 | 00, 03 | 1 | 1 | 0.40 | 0 | 3 |
| 13 | dirt / sand | 19,691 | 01 (Redrock Ridge), 07A (AutoCross), 04A | 1 | 1 | 0.60 | 6 | 3 |
| 14 | wall (any scenery) | 97,801 | everywhere, 43 % | 0 | 1 | 0 | 0 | 3 |
| 15 | snow | 6,293 | 00B (Country Woods), 04B (The Summit) | 1 | 1 | 0.60 | 9 | 10 |

`0x800F7F3C`/`0x800F7F7C` feed the tyre/road sound mode (6 = dirt, 7 = gravel, 8 = grass, 9 = snow by the table
above); `0x800F7EFC` is used by the physics at `func_80076FC0` (0 on asphalt and walls, 0.6–0.7 off-road). Only
0xE is named by code (wall: sideways moves onto it are refused); ids 4, 6, 8, 9 have table entries but no quads
on disc. The road group {1, 7, 0xA, 0xC, 0xD} of `func_8006C044`/`func_800A5B08` is exactly the paved, wooden
and (on dirt tracks) dirt driving surfaces.

### 12.2 Acoustic classes → SPU reverb ★★★
COL slice +21 holds a class per side (high nibble left, low nibble right; §2). `func_800A10D4` (per frame, for the
view car) takes the larger of the two classes, adds 1 when either side's cover (+30) is 2 (tunnel), and looks the
result up in a per-track 4-byte table `0x80109690[TRACK]` = `{mode open, mode tunnel, depth open, depth tunnel}`.
The mode is a **PsyQ SPU reverb mode**: the size table it is checked against, `0x80109624` = 0x80, 0x26C0, 0x1F40,
0x4840, 0x6FE0, 0xADE0, 0xF6C0, 0x18040, 0x18040, 0x3C00, is exactly libspu's reverb work-area size for
OFF, ROOM, STUDIO_A, STUDIO_B, STUDIO_C, HALL, SPACE, ECHO, DELAY, PIPE. If the reserved reverb RAM
(`0x8012593C`, at least 0x1F40 or reverb stays off) is too small, `0x8010964C` steps down to the next smaller
mode. The result goes to `SpuReverbAttr` at `0x80109760` (`{mask, mode, depth L, depth R}`), set through
`func_800D418C`/`func_800D598C`; the depth byte feeds `func_800EEECC`. The slices ahead of the car are scanned
too, so the change is anticipated. In a tunnel the reverb applies only while the car is on surface 1, 7, 0xA or
0xC (road or wooden bridge); on other surfaces it is off.

| Class | Slices (sides) | Mostly | Default table `0x80109658` (open / tunnel, depth) | Redrock Ridge `0x80109674` |
|-------|----------------|--------|------|------|
| 0 | 15,622 | open road | OFF / OFF | same |
| 1 | 3,880 | | STUDIO_A / STUDIO_A, 4 / 16 | same |
| 2 | 4,608 | | ROOM / ROOM, 4 / 16 | ROOM, 8 / 16 |
| 3 | 4,740 | | STUDIO_B / STUDIO_B, 8 / 32 | STUDIO_B, 32 / 64 |
| 4 | 4,817 | tunnels (2,232 of 2,531 slices covered) | STUDIO_C / STUDIO_C, 31 / 127 | same |
| 5 | 1,779 | caves (06A: 1,073), covered | SPACE / SPACE, 31 / 127 | STUDIO_B, 127 / 127 |
| 6 | 190 | 03B only, covered | STUDIO_C / STUDIO_C, 31 / 127 | PIPE, 16 / 16 |

Only track 1 (Redrock Ridge) has its own table; all other ids share `0x80109658`. Special case: on track 0x13
slices 318–360 the reverb is off unless the car is on surface 0xA.

## Open questions
None: every NFS3 track file, record and field on the disc is accounted for above (★★ marks the few names
that rest on data evidence rather than code).

## Tools
- `tools/nfs3_trk.py` — `trk`, `col`, `census` (container validation above).
- `tools/psx_iso.py` — extraction.
