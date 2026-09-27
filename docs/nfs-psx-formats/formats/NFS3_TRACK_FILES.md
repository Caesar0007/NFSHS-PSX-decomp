# NFS3 track files — survey (file set, loaders, containers)

Game: Need for Speed III: Hot Pursuit, PSX USA retail **SLUS-006.20**. Status: **survey** — file set,
loader map and the two binary containers (`.TRK`, `.COL`) are established; the per-type record layouts
inside them are the next step (see *Open questions*). Tags per [METHOD.md](../METHOD.md).

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

### 1.4 Chunk
| Off | Type | Field | Evidence |
|-----|------|-------|----------|
| 0 | u32 | chunk size | = distance to the next chunk, all 2,234 chunks |
| 4 | u32 | chunk size again | equal in every chunk (NFS4 keeps this duplicated word as "value A") |
| 8 | i16 | sub-block count (4–12) | loop bound of `func_8009E870` |
| 0xA | i16 | (read by `func_8009E91C` in the binder) | open |
| 0x10 | 4 × {i32 x, y, z} | bounding points | `func_8009E940`; centre-relative after load (`func_80079F4C`) |
| 0x40 | u32 | offset of the sub-block offset table, relative to +0x40 | `func_8009E840`/`func_8009E870` |
| 0x44 | … | geometry block: counts, then 8-byte vertices at +0x58 (chunk+0x40+0x18), then five arrays of 6-byte entries | `func_8009E850`, `func_8007A198`; ★ provisional (the count arithmetic closes for ~95% of chunks) |
| table | u32[count] | sub-block offsets, relative to the chunk | |

On load, vertex coordinates are divided by 4 in place (`(v << 16) >> 18`, `func_80079F4C` and
`func_80079EBC`).

### 1.5 Sub-blocks — 8-byte header `{u32 length, u16 type, u16 count}`
`func_8009E870(chunk, type)` finds a sub-block by type. The chunk binder `func_8007A198` fills the 0x58-byte
"Chunk_tChunkDat" (size printed by name) with the sub-blocks below.

| Type | In chunks | Element size (length−8)/count | Known |
|------|-----------|-------------------------------|-------|
| 4 | all 2,234 | 2 (+ pad) | **visibility list**: u16, low 10 bits = chunk index, range-checked ("Bad data in visibility list - out of range!"); byte-identical to the `.VIS` text rows in 1,382 of 1,388 rows (6 rows of `00B` differ: stale VIS) |
| 5 | all | 2 | count is below the geometry block's vertex count; 2 bytes per element |
| 6 | all | 8 | |
| 0xD | all | 12 | |
| 8 | 1,832 | variable (48–200) | |
| 7 | 1,367 | 16–20 | |
| 0x12 | 1,557 | 16–20 | |
| 9 | 1,345 | 4 | |
| 0xB | 632 | 20 | |
| 0xA | 248 | 16 | |
| 0x13 | 71 | 16 | |
| 0x11 | 36 | 16 | |
| 0x14 | 4 | 16 | |

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
| 2 | 15 | 10 B | `func_80067A48` | open |
| 8 | 10 | variable | kept in `gp+824`; vertices scaled by `func_80079EBC` | "kOBJECTDEF_COLLECTION" (object definitions) |
| 7 | 9 | variable (u16 record size at +0) | kept in `gp+828` | "kINSTANCE_COLLECTION" (object instances) |
| 0x12 | 2 | | kept in `gp+832` | open |
| 0xF | 15 | 36 B | `func_8006869C` "Opened track sim file and found %d slices" | track slices |
| 0x14 | 0 | | log only | "kOBJSFXINST_COLLECTION" (not on the NFS3 disc) |

## 3. Lineage to NFS4 ★★
- `.TRK` is the direct ancestor of the NFS4 `.GRP`:
  - the same "BWorld"/chunk vocabulary;
  - a header holding {max meta-chunk size, max geometry size, two more budgets, metaChunkCount = ceil(chunks/8), chunkCount};
  - chunks that repeat their first word;
  - the 4-point bound block;
  - a visibility list of u16 chunk indices with flag bits (the `.VIS` source uses 0x800 like NFS4);
  - and typed sub-blocks.
- NFS3 streams meta-chunks of 8 chunks from CD. NFS4 loads the whole GRP and widens the element
  header from 8 to 16 bytes (`{type, length, 0xCDCDCDCD, count}`).
- Slices are type 0xF in both games (NFS3 36 bytes in `.COL`; NFS4 32 bytes in the persistent group).
- NFS3's `.DPQ` carries the car env-map zone list that NFS4 moved to its text `.ENV`.

## Open questions (next steps)
1. Record layouts for TRK sub-blocks 5/6/7/8/9/0xA/0xB/0xD/0x11–0x14 and the geometry block: trace the
   consumers of each `Chunk_tChunkDat` slot bound in `func_8007A198`.
2. COL types 2, 7, 8, 0x12 and the 36-byte slice (`func_8006869C` consumers; compare with NFS4
   `Trk_NewSlice`).
3. TRK header +0x10/+0x14, chunk +0xA.
4. Variant meaning (front-end track table) and the track-ID special case for 02b.
5. `.CCM`, `T{B,F}.BIN`, `.COP`, the `A.VIV` contents; confirm QSL/QSS/QTS and VIS are never opened (runtime
   CD file-open trace).
6. Runtime validation (DuckStation, as done for NFS4): dump `Chunk_tChunkDat` for a loaded chunk.

## Tools
- `tools/nfs3_trk.py` — `trk`, `col`, `census` (container validation above).
- `tools/psx_iso.py` — extraction.
