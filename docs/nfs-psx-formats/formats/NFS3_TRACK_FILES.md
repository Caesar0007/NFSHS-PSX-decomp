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
| `ZTR<NN><v>A.VIV` | BIGF archive | `func_8005B878` ("%sA.viv") | seen | |
| `ZTR<NN><v>.DPQ` | text | `func_800A7250` ("%sTr%02d%c.dpq") | ★ | depth-cue distance + colour, car env-map zones `{slice, tex, extra, quad}` (the NFS4 `.ENV` content lives here) |
| `ZTR<NN><v>.HRZ` | text | `func_800B84BC` ("%sTr%02d%c.hrz") | ★ | horizon/sky parameters, commented |
| `ZTR<NN><v>{D,N,W}.CLR` | text | `func_80080C18` ("%sTr%02d%c%c.clr") | ★ | car colour table per condition (day/night/weather); also `carmenu.clr` |
| `ZTR<NN><v>{,N,NW,W}.BNK` | sound bank | ".bnk" builders | seen | |
| `ZTR<NN><v>T{F,B}.BIN` | tutor prompts | `func_80081DB4` ("at"/"bt" + "f.bin"/"b.bin"), only when TUTOR is on | ★★★ | §5 |
| `ZTR<NN><v>.VIS` | text `#chunk` + list | **none** (no reference in the EXE) | ★★★ | exporter source of TRK sub-block 4 (§1.5) |
| `ZTR<NN>{F,R}.QAL/.QAS/.QBE` | Huffman `30FB` | "%sTr%02d%s.qbe", "qal", "qas" | seen | codec as [NFS4_Q_CODECS.md](NFS4_Q_CODECS.md) |
| `ZTR<NN>{F,R}.QSL/.QSS`, `ZTR<NN>.QTS` | Huffman `30FB` | **no reference found** | ✗? | likely unused; confirm with a runtime file-open trace |
| `ZTR<NN>{BEG,EXP}.COP` | cop triggers | `func_800520FC` ("%sTr%02d%s.cop"), only when COPS is on | ★★★ container | §6 |
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
| 6 | 2,234 | 8 B `{u16 firstQuad, u8 quadCount, u8 n (4–9), i16 link[2]}` | ★★★ | **sim slices**: per chunk they partition q4 exactly (contiguous, total = q4, all chunks); the per-chunk counts sum to the COL slice count in all 15 files. `n` (byte 3) = **interactive-music section**: `func_8006BE14` reads it up to 16 slices ahead of the car and `func_8005FC14` passes it (min 4) to the PathFinder music player (`func_800ECDD4`, which range-checks it against byte 7 = 16 of the loaded `PFDx` `.MAP`). `link[2]` = global slice indices of alternative routes: when one is not −1, the "slice jump" code (`func_80069E14`) re-resolves the car onto whichever slice is closer. All 196 links on disc are valid slice indices (192 slices with one link, 2 with both) |
| 5 | 2,234 | 2 B `{u8 frame, u8 flags}` | ★★★ / ★★ | one word per q4 quad (count = q4 in all chunks), addressed as `type5 + 8 + 2·(firstQuad + lane)` by the sim code (`func_80068F48`, `func_80069E14`). `frame` indexes the chunk's type-0xD table (below it in all 225,739 words). `flags`: bits 0–5 = **surface id** (the car keeps it at +0x1C0/+0x1C4; getter `func_8006BD28`), bit 0x80 = triggers a ±3.5-unit height test in `func_80071874`, bit 0x40 open. Surface 0xE = **wall**: a sideways move onto it is refused (`func_80068F48`); groups {1, 7, 0xA, 0xC, 0xD} are tested together by `func_8006C044` / `func_800A5B08`. On disc: 0, 1, 2, 3, 5, 7, 0xA–0xF (0xE = 43 %) |
| 0xD | 2,234 | 12 B `{i16 normal[3], i16 direction[3]}` | ★★ | quad orientation frames, shared by quads through type 5's `frame`. Both vectors are unit length in 1.15 fixed point (all but 31 of 166,240 records); `normal` points up in 63 %, and the two are orthogonal in 79 % |
| 8 | 1,832 | `{u32 size, u16 vertexCount, u16 quadCount}` + vertices (8 B) + quads (6 B), padded to 4 | ★★★ | **object definitions** of the chunk: size exact for all 10,881 records and each chain ends at the block end |
| 7, 0x12, 0x13, 0x14 | 1,367 / 1,557 / 71 / 4 | instance records, below | ★★★ | object instances (drawn by `func_800B2C18`, which reads all four); 0x14 = "kOBJSFXINST" per the COL log string |
| 0xB | 632 | 20 B `{i32 point[3]; i16 radius, i16 serial; u8 ×4}` | ★★ | **sim objects**, one per kind-4 instance (§1.5.1); same shape as NFS4 `Trk_SimObject` |
| 9 | 1,345 | 4 B `{u8 vertex, u8 slice, u8, u8}` | ★★ | **road lines** (fetched in `func_800B4AF8`, built by `func_800B496C`): `slice` is relative to the chunk's first sim slice; each point is the chunk vertex ± the slice's `right` vector (top 5 bits of each s8), giving a painted line's two edges. Byte 2 = **line style** of the segment to the next point: 0xFF = no line, else an index into the 4-byte table at `0x8010BCFC` (`func_800B4090`); values 0, 1, 2, 5, 6, 0xFF. Byte 3 is never read (★★★ unread; the only type-9 lookup feeds these two functions). NFS4 `Trk_Line` has the same size |
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
| 2 | u8 | flags, read per quad by both track renderers (`func_800B16D4`, `func_800AFB5C`; runtime read-watch found no other reader): **0x04 = animated** (frame = (timer / interval) mod frameCount, the pixmap advances 16 B per frame; set exactly when +7 > 0, all 5,521 records); **0x40 = one-sided** (the quad goes through the `nclip` back-face test; without it both sides are drawn); **0x10 = force double-sided** (overrides 0x40, chunk renderer only); 0x20 = no reader found. Counts: 0x40 × 1,122, 0x20 × 858, 0x10 × 289, 0x04 × 40 | ★★★ (0x20 ★★) |
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
| 20 | i16 | angle in degrees (47–78), converted to 4096-per-turn units and fed to sin/cos: presumably the field of view | ★★ |
| 22 | u16 | camera kind: 0 × 33, 1 × 27, 3 × 26; bit 1 selects a separate path in the view code | ★★ |
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
| ids | i32 × n | message ids 0–17, 1–4 per record |
| end | i32 | −1 |

The reader adds lap × ring length to the slice (the lap counter stops at NUMLAPS) and mirrors it from the ring
end when REVERSE is on. (The nfs3-clean comment calls this reader "cop radio chatter".)

## 6. `.COP` — police pursuit triggers ★★★ container (18 files, 1,384 records)
`func_800520FC` loads `<prefix>Tr<id in decimal><BEG|EXP>.cop` when COPS (`cfg[0x5]`) is on; SKILL
(`cfg[0x2]`) = 0 picks BEG, otherwise EXP. Both branches use the full track ID (a branch-delay-slot load; the
nfs3-clean reconstruction wrongly reads `cfg[5]` in the EXP branch). Files exist for IDs 00–04, 16, 17, 19, 20.

`{i32 count}`, then records whose size is chosen by their type (`func_8005AB1C`):

| Type | Size | On disc | NFS4 name |
|------|------|---------|-----------|
| 1 | 20 B | 490 | roadblock |
| 2 | 20 B | 245 | simple |
| 3 | 72 B | 649 | off-road |

Every record starts `{i32 type, i32 slice}`; all 1,384 slices are valid for the track, and every file ends
exactly after its last record. Records are nearly in slice order (31 backsteps: lap wrap-arounds such as a
type-1 record at slice 50 after the end of the list, and a few local swaps).

Trigger rule (`func_8005ACA4`): each player keeps a cursor into the list; a record fires when the car's slice
equals the record's slice, the type is not 2, and more than 0xA00 frame ticks have passed since that record
last fired (per-record timestamps at `+408` of the manager `0x800F4FE8`). The field layout inside the type-1/3
bodies is not traced yet (NFS4 lineage: same sizes and type numbers).

## Open questions (next steps)
1. TRK: type-5 flag bit 0x40 and the surface-id names (sound / grip tables), the line-style table at `0x8010BCFC`.
2. COL: material flag 0x20; slice +15 forward vector's readers; the surface-id and acoustic-class names.
3. `.COP` type-1/3 record bodies; `.CCM` kind values; tutor message ids → voice clips.
4. `A.VIV` contents; confirm QSL/QSS/QTS and VIS are never opened (runtime CD file-open trace).

## Tools
- `tools/nfs3_trk.py` — `trk`, `col`, `census` (container validation above).
- `tools/psx_iso.py` — extraction.
