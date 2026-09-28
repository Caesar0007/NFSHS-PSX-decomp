# NFS1 (PSX) track files — survey

Game: Road & Track Presents The Need for Speed, PSX, **USA `SLUS-00204`** (disc `Road & Track Presents - The Need
for Speed (USA).bin`). Extracted data: `C:/Temp/nfs1_disc` (755 files, XA movies skipped). Code: the disc's
`SLUS_002.04` (load 0x80010000, size 0xCC800, entry 0x80097268) — byte-identical to `nfs1-clean/NFS1.EXE`; the
disc's `FRONT.CPE` is the same program in CPE form (835,620 of 835,620 bytes equal, same entry), not an overlay.
There is no symbol file; the Ghidra dump `nfs1-clean/nfs1.c` gives shape, and a raw objdump listing plus an
address-xref helper live in `C:/Temp/nfs1_analysis` (`nfs1-objdump.txt`, `xref.py`).
Tool: [`tools/nfs1_tri.py`](../tools/nfs1_tri.py).

Tags: ★★★ = proven on every file (and/or read in the loader); ★★ = strong evidence; ★ = observed only.

## Track set ★★★
15 tracks, each one `.TRI`: the three point-to-point routes in three segments — `ZAL1–3` (alpine), `ZCL1–3`
(coastal), `ZCY1–3` (city) — and six circuits `ZTR1–6` (the EXE names the track art `zrusty`, `zautumn`,
`zvertigo`, `zlostveg`). `ZTR5.TRI` and `ZTR6.TRI` are byte-identical.

Per track (loader format strings in brackets):

| File | Loader | Notes |
|------|--------|-------|
| `Z<t>.TRI` | `func_80037058` / `func_80036EE8` (`z%s.tri`) | track geometry, §1 |
| `Z<t><v>.PSH`, `.INF`, `.LGT`, `.LGS` (v = `'A'` + `DAT_8010d1ae`) | `func_800485D4` (`z%s%c.psh/.inf/.lgt/.lgs`) | textures; horizon script §3; per-point lighting §4; light script §5 (`ZTR1.LGT` without a letter is never loaded) |
| `Z<t>R.PSH` | `func_800485D4` (`z%sR.psh`) | |
| `Z<t>MP.PSH` | | map |
| `Z<t>_POR.FAM`, `Z<t>_PSH.FAM` | `func_8004F040` (`_POR.FAM`, `_PSH.FAM`) | animated 3-D objects (models + textures), §2; no FAM for `ZCL1` |
| `<t>traffic.cfg` | `func_8005B1F4` (`%straffic.cfg`) | **vestigial**: the name is `sprintf`ed into a stack buffer that is never used (no such file on the disc); `func_8004C4FC` then fills the traffic parameters at `0x80111ECC` with built-in constants |

## 1. `.TRI` ★★★ container
Read by `func_80037058` ("RenderInfo" block 0x16DB0) and `func_80036EE8`:

| Part | Size | Content |
|------|------|---------|
| RoadSection | 0x1621C | read whole ("RoadSection"), §1.1 |
| `OBJS` block | 17,036 | 12-byte header `{char[4] tag, u32 17036, u32 0}` + body ("RoadObjects"); the tag reads `OBJS` in ZAL3/ZTR5/ZTR6 and byte-reversed `SJBO` in the other twelve |
| TrackSlices | n × 288 | n `TRKD` records: `{'TRKD', u32 276, u32 0}` + 276 bytes ("TrackSlices") |
| `CRCF` | 12 | `{'CRCF', u32 12, u32 crc}` — ends the file, §6 |

### 1.1 RoadSection ★★★ layout
| Off | Content |
|-----|---------|
| 0 | u32 17 (version) |
| 4 | i16 a, i16 n — n = number of `TRKD` blocks (circuits: a = n = 128 / 256; routes: a = 0) |
| 0x24 | u32 = n · 288 (TrackSlices size) |
| 8 | i32 0x60000 = **node spacing** 6.0 (16.16): the median distance between consecutive nodes is 393,216 on every track. Not read by the game (§7) |
| 0xC, 0x10, 0x14 | i32 × 3 = **track origin**: equal to node 0's x, y, z on all tracks except the city routes, where node 0 is shifted by x − 5.0. Not read by the game (§7) |
| 0x28 | u32 33–63 = **rail texture** (PC spec: `rail_tex_id`). On the 12 tracks with roadside panels it equals the highest panel texture + 0x20. On the city routes (no panels) it is the highest strip texture, apart from one stray 49 on ZCY1 (48). Not read by the game (§7) |
| 0x2C | u32 × 600: offset of each `TRKD` record inside TrackSlices = `i · 288` for all 600 entries (also past n); used by `func_800367D0` / `func_80036A88` |
| 0x98C | **road nodes**: 2,400 × 36 bytes (`DAT_800dc560`), 4 per `TRKD` block (4n used, the rest zero); indexed `(i & mask) · 0x24` with mask = 4n − 1 (`DAT_800dc530`) |
| 0x15B0C | **per-block speed table**: 600 × 3 bytes `{u8 opponent target speed, u8 speeding threshold, u8 traffic speed cap}` (all `<< 16`), indexed by node / 4 (`DAT_800db698`); see §1.2 |
| 0x16214 | u32 64 = number of object definitions = 16-byte-record index of the placement list in the `OBJS` body |
| 0x16218 | u32 1000 = placement capacity: sizes the "SignStatus" array (2 bytes per placement) |

**Road node** (36 B) — readers found by scanning every node pointer in the Ghidra body; statistics over all 22,648
used nodes:

| Off | Type | Meaning | Tag |
|-----|------|---------|-----|
| 0, 1 | u8, u8 | left / right road edge distance: the lateral centre shift is `(b1 − b0) · 0x1000` (typical 40) | ★★ |
| 2, 3 | u8, u8 | left / right outer distances (read as a pair by the car/collision code; typical 64) | ★ |
| 4 | u8 | **lane counts**: low nibble = lanes on the driving side, high nibble = oncoming lanes; lane width = `0x80111C90[b1 >> 3][nibble]` (the table `func_8005B1F4` builds as edge distance / lane count); the traffic and cop AI step cars between lanes with it | ★★ |
| 5 | u8 | **edge type**, high nibble = left side, low nibble = right side, values 0 / 1. It is read by the road-edge collision `FUN_800311F4` and by the car–wall callback `0x8001CB1C` (installed by `FUN_80038908`, so Ghidra misses it). 0 = hard wall: the plane sits at the outer distance (byte 2 / 3) + 1.0, and hitting it plays the impact sound. 1 = soft edge: the plane sits at + 3.25, with no impact sound. Byte 7 = 5 is treated like 0 | ★★ |
| 6 | u8 | **off-road surface**, high nibble = left, low nibble = right (values 0–2). When the car is past the road edge (byte 0 / 1), `FUN_800311F4` stores the nibble in car+0x4B0; on the road the value is 0. It indexes the 3-entry surface table `0x800F7EB4`, 16 B each: `{grip /256, drag /256, rolling resistance, off-road flag}`. `FUN_80030008` fills the table per track group: entry 0 = road `{0x100, 0x100, 0x3333, 0}`; entries 1 and 2 = e.g. `{0xCC, 0xF00, 0x5999, 1}`, and all three become `{0x180, 0x80, 0x1999, 1}` when flag 0x20 is set | ★★ |
| 7 | u8 | **cross-section type** (0–16; 3 on 18,192 of 22,648 nodes). The renderer `FUN_80037900` uses `0x800BD868[type][32 distance slots]` to pick one of 30 strip templates (`0x800C0D18 + 0x4C · t`: `{u32 points, u32 quads, …, +0x48 first strip}`), usually a near / middle / far detail level per type. Each strip is `0x800BE858 + 16 · k`: `{u8 corner point ×4 (row · 11 + point), u8 strip number = texture slot in the TRKD header, u8 flag, u16 0, draw routine, u32 rows}`. The same byte drives the car's **echo** (`FUN_80030FE8` → `FUN_8003C4D0`): 4, 7, 9, 12, 13 switch the reverb on (`FUN_800B9B7C`), 8 sets only the second flag, 5 makes the echo oscillate, 14 / 15 pan it fully left / right (wall on one side) | ★★★ |
| 8, 0xC, 0x10 | i32 × 3 | x, y, z — the node position (compared with car positions) | ★★★ |
| 0x14 | i16 | angle (14-bit turn), interpolated between consecutive nodes (`× 0x400`): pitch | ★★ |
| 0x16 | i16 | angle (14-bit), mostly 0: bank; `s16 >> 6 ≠ 0` cancels a lateral correction | ★★ |
| 0x18 | i16 | **heading** (14-bit turn; `<< 2` / `<< 10` for 16 / 24-bit angles) | ★★★ |
| 0x1A | u16 | flags, read only by the cop-car code (`FUN_80055394`): bit 1 (when oncoming lanes exist) chooses which side the cop is placed on, bit 2 suppresses the chase-state flag 0x20000 | ★ |
| 0x1C | i16 × 3 | unit vector, length 32,767 in all nodes; (1, 0, 0) for heading 0 → the lateral (right) vector | ★★★ |
| 0x22 | i16 | 0 in all nodes | ★★★ |

### 1.2 `TRKD` records — road cross-sections ★★★
`func_80036AD0` checks the tag (`'TRKD'` = 0x444B5254, retrying the read otherwise) and `func_800367D0` expands block
`b` into a 0x21C-byte slot of a 32-block ring buffer ("Slices0"/"Slices1", 0x4380 bytes each):

| Off (data) | Size | Content |
|------------|------|---------|
| 0 | 12 | per-block header, copied into the slot unchanged; read by the road renderer through `func_80037498` (slot address), see below |
| 12 + 66·k | 66 | node `4b + k` (k = 0–3): **11 points** as `i16 (dx, dy, dz)`, scale × 0x200 |

Point 0 = node position + d0; points 1–5 chain outward from point 0 (each = previous + d), points 6–10 restart from
point 0 and chain the other way. The output is 11 × `{i32 x, y, z}` per node (0x84 bytes). Geometry check over all
22,648 nodes: in 19,421 points 1–5 lie on one side of the node's lateral vector and 6–10 on the other (the rest
are nodes whose outer points climb — walls, tunnels).

**Block header** (12 bytes, ★★):

| Off | Content |
|-----|---------|
| 0 | 0 in all blocks |
| 1 | **roadside panel**: bit 7 = draw on one side, bit 6 = on the other, bit 5 = mirror the texture, bits 0–4 + 0x20 = texture index (`FUN_80046484`); 0 in 2,940 blocks (none), 0xFF on ZTR1 |
| 2–11 | **texture index for each of the 10 strips** between the 11 points (pointer table `0x801063B0`, picked per strip by the renderer's strip template). Values come in triples (e.g. `3, 4, 18, 19, 20`: texture × 3 + variant) |

**Speed table** (RoadSection +0x15B0C, ★★): at load, `func_80037058` scales byte 0 of blocks 7 and up by a difficulty factor from `0x800BD778` / `0x800BD7F0`. Byte 0 caps the opponent target speed (`FUN_80059D68`, `FUN_8005BCC8`, scaled again per opponent class). Byte 1 is the player-speed threshold that starts a cop chase (`FUN_80055394`). Byte 2 is the traffic speed limit (`FUN_80053CD8` → `FUN_8005BB50`). On the circuits bytes 1 and 2 are the constants 9 and 5, because the circuits have no traffic or cops.

### 1.3 `OBJS` body — roadside objects ★★★
The body (17,024 bytes, "RoadObjects", `DAT_800dc654`) has two parts:
- 64 object **definitions** of 16 bytes each;
- a **placement** list of 16-byte entries, starting at record `RoadSection+0x16214` = 64 (byte 1024, `DAT_800dc6ac`) and ending in node −1. `FUN_800365AC` walks it, capped at 16,000 bytes.

Definition (16 B):

| Off | Content |
|-----|---------|
| 0 | flags: bit 2 = animated texture (frame = `(time / b9) % b8`, frames 4 bytes apart) |
| 1 | **kind** = number of projected vertices it uses: 1 = 3-D model from the `.FAM` (§2; `FUN_8004FE0C` with instance table `0x800F74B8 + b2 · 0x10`), 4 = one-quad billboard, 6 = two-quad object with two textures |
| 2 | texture byte offset into the pointer table `0x80100A2C` (plus a view offset, `& 0x1FC`); for kind 1 = FAM entry index |
| 3 | second texture (kind 6) |
| 4 | i32 width, 16.16 (also the collision size, `>> 9`) |
| 8 | i32 depth / second width, 16.16; when animated: `u8 frame count, u8 frame period` |
| 0xC | i32 height, 16.16 |

Placement (16 B):

| Off | Content |
|-----|---------|
| 0 | i32 road-node index (sorted ascending) |
| 4 | u8 definition index (< 64) |
| 5 | u8 rotation: `b5 · 0x10000` is added to the node heading `· 0x400` (1/256-turn steps) |
| 6, 7 | u16 (0 on 7,867 placements, else 0x8023, 0xE0A2, 0xF005, 0xD046, 0xE000, 0xF000, 0x101F, 0xD000): **unused by the game**. No read at any width anywhere in the code, and no read in a runtime watch (§7) |
| 8 | u8 flag: 0 selects the alternate view-offset table (`0x800BE5F4` vs `0x800BE580`); also tested by the renderer's draw loop |
| 9 | u8 (1, 4, 255, 0): **unused by the game** (as bytes 6–7; the byte-9 read in `FUN_80046618` is the definition's frame period, not the placement) |
| 10 | i16 × 3 x, y, z offset from the node, `× 0x100` |

Knock-down state is kept per placement in "SignStatus" (`DAT_800dc248`, 2 B each). `FUN_8001F0F0` is the car–object collision test.
Census: 9,411 placements; on every track all are sorted, with def < 64; the highest count is 998 (ZAL1).

`nfs1_tri.py census`: all 15 files match exactly (5,662 `TRKD` records, 9,411 placements).

## 2. `.FAM` — animated 3-D objects ★★★
Two parallel files per track: `_POR` holds the models and `_PSH` their textures. Each is a nested **offset container**:
`{u32 0x77777777, u32 count, u32 offset[count]}`. The offsets are relative to that container. `FUN_8004C2E4` relocates
them recursively: an entry that is itself a `0x77777777` container is relocated too, and offset 0 = null.
`FUN_8004C3F0(c, i)` returns entry i. Every `FAM` ends with a `CRCF` chunk (§6).
- `_POR` entry = an **`ORIX` model**, see below.
- `_PSH` entry = an `SHPP` texture pack, uploaded by `FUN_8004E72C`.

The entry count per track/segment comes from the table `0x800C1698[track · 3 + segment]` (index 0x15 when flag 0x20 is set; one entry for the ZAL1 trestle, up to seven for ZTR1). For entry i, the loader counts the placements whose definition has kind 1 and b2 = i. It then creates that many instances (at most 12) of model i with texture i, at `0x800F74BC + i · 0x40`.
`nfs1_tri.py fam`: all 28 files parse, and each entry ends at the next entry's offset.

### `ORIX` model ★★★
This is the PSX form of NFS1-PC's `ORIP`. `FUN_80081610` (`oriload`) warns if the version is not 800 and turns every
offset into a pointer. `FUN_800819AC` allocates an instance ("ORI_INST").
- Header (0x78 bytes; offsets are from the tag).
- Sections follow each other with no gaps in all 39 models: polygons, UVs, textures, group, labels, vertices, index pool, and the entry ends at `+4 size + 12`.

| Off | Content |
|-----|---------|
| 0 | `'ORIX'` |
| 4 | u32 size (entry length − 12) |
| 8 | u32 version 800 |
| 0xC | u32 (runtime instance counter; the file holds `'JCTS'`) |
| 0x10, 0x14 | u32 vertex count (twice) |
| 0x18 | vertex table: `{i32 x, y, z}` (PC: fixed point, 4 fraction bits for props, 7 for cars; unit metre) |
| 0x1C, 0x20 | UV count, UV table `{i32 u, v}` (texels, 0–0x3A); 0 in most models |
| 0x24, 0x28 | polygon count, polygon table (16 B each, below) |
| 0x2C | char[12] object name (`_TRESTLE`, …) |
| 0x38, 0x3C | texture count, texture table: 24 B `{u32 0, u32 0, char[4] name (= the `SHPP` entry name, e.g. `TRS1`), u32 1, u8 r, g, b, x flat colour (`FUN_800B5788`), u32 0}` |
| 0x40, 0x44 | "texture number" count (0), table pointer (PC `tex_nmb`, 20 B each) |
| 0x48, 0x4C | render-order count (1), render-order table: 28 B `{char[8] "NON-SORT", u32 0, u32 0, u32 pool index, u32 polygon count, u32 0}` = the polygon draw list |
| 0x50 | index pool (u32 vertex / UV / polygon indices) |
| 0x54, 0x58 | FX-polygon count (0), FX-polygon table (PC `fxp`) |
| 0x5C, 0x60 | label count, label table: 12 B `{8 bytes id (0x280 here, a string on PC), u32 value}` — PC: polygons whose texture changes at run time |
| 0x64 | joint-matrix count (0; "INVMATRX" 0x24 each when used) |
| 0x68, 0x6C, 0x70 | joint end, joint count (6 on two ZTR1 models), joint table: 8 B `{u32 id, char[4] "J00n"}` (for `InitJLD`) |

Polygon (16 B; PC `OripPolygon` is 12 B without the constant 12): `{u8 type, u8 flags, u16 texture, u32 12, u32 vertex list, u32 UV list}`.
- **type**: 0x84 = quad, 0x8C = quad with bit 3 set.
- **flags**: 0, 1, 2, 3, 16, 18. The PC spec names them: bit 0 = two-sided, bit 1 = flip normal, bit 4 = use UVs. With bit 4 the UV list is its own pool range; otherwise it equals the vertex list and the whole texture is mapped.
- **vertex list** and **UV list**: word indices into the pool, relocated to pointers by `oriload`.

The census is in [`nfs1_orix_probe.py`](../tools/nfs1_orix_probe.py): 39 models (ZTR5 = ZTR6), 260 quads; for every model the sections chain, every vertex index is in range, and the group lists every polygon exactly once.

## 3. `.INF` — horizon script ★★★
Text, parsed by `FUN_80034ADC` with the number reader `FUN_8003D428` (it skips `#` comment lines). The file holds 19 numbers, in this order:
- vert offset near / far, zoffset near / far, height near / far, radius near / far (each stored `<< 16`);
- colour top (r g b), colour bottom (r g b);
- dithering flag, ratio of the blend;
- ring y offset and ring height (each halved);
- one trailing unlabelled value.

`FUN_800348C0` then builds the horizon ring from the `.PSH`.

## 4. `.LGT` — per-point track lighting ★★★
`{u32 nodes, u32 level, u8 light[nodes][11]}` (`FUN_8003D1F8`):
- nodes = 4n;
- level = 335 / 256 / 175 for the A / B / C variants (stored in `DAT_800dc644`; no reader found);
- one byte for each of a node's 11 cross-section points (§1.2).

The road renderer (`nfs1.c` ~22065) converts each byte to a vertex colour in two steps. First the byte goes through the per-channel curves `0x800F7B88` (with an r/g/b offset). The result then indexes the depth-cue table `0x800F984C[depth + level · 113]`. This only happens when the block's ScriptLight flag 0x80 is set; otherwise the level is 0. All 46 files: body = 11 × nodes.

## 5. `.LGS` — light script ★★★
Text with C comments, parsed by `FUN_8003D510` in this order:
1. depth-cueing curve: 4 points `X0,Y0 … X3,Y3`. `FUN_8003D24C` expands it into the 113 × 256 table `0x800F984C`.
2. 6 numbers: dynamic-channel start RGB and end RGB.
3. context count, then per context:
   - first block, last block;
   - a flag (`kUseAC` = 64, `kUseAC + kSwitchAC` = 96);
   - two RGB triples.

   These fill the per-block "ScriptLight" array: n × 4 bytes `{flag (default 0x80), 0, colour index a, colour index b}`.

## 6. `CRCF` — file checksum ★★★
Every data file ends with `{'CRCF', u32 12, u32 crc}`. `FUN_80015858` checks the tag, and `FUN_800158D4` compares
the value with `FUN_800B4850(data, size − 12)`. That is a reflected, table-driven CRC-16:
- table `0x800D9C58` = poly 0x8005 reflected (0xA001), i.e. the CRC-16/ARC table;
- but **init 0xFBEA**, and no final XOR.

On a mismatch the loader retries ("CRC reload %s %d").

Verified matches:
- all 702 standalone files with a `CRCF` chunk (TRI, PSH, FAM, INF, LGS, LGT, VB/VH, PFN, STATS);
- all 350 entries inside the 33 `BIGF` archives (`.VSM`/`.WSM`/`.VIV`), where each entry carries its own `CRCF`.

Files without a `CRCF` chunk: `FRONT.CPE`, `SLUS_002.04`, `*.CNK`, `*.PAD`, `LICENSEA.DAT`, `SYSTEM.CNF`.
`nfs1_tri.py crc <dir>` checks all of them.

## 7. Runtime check (DuckStation) ★★★
The scripts are in [`tools/runtime`](../tools/runtime); the runtime copy used GDB port 2350.
- `nfs1_pad_probe.py`: pad injection goes through the PsyQ pad driver copy into `0x800F7B3C` (breakpoint 0x800AD68C).
- `nfs1_race_setup.py`: gets into a ZTR1 race and saves checkpoint `nfs1_race`.
- `nfs1_watch_probe.py`: read watchpoints while driving. The car starts in **neutral**: tap R1 or L1 to shift up (R2/L2 = reverse) and hold **Square** to accelerate.

Results:
- RoadSection in RAM = file byte-for-byte after load. With the default difficulty the speed-table scaling leaves byte 0 unchanged.
- The lane table `0x80111C90[k][j]` = `j · 256 / k` for k = 1–3, as read from `func_8005B1F4`.
- While driving node 19 → 97 (2,500 frames), RoadSection +8..+0x14, +0x28 and the `.LGT` level word `0x800DC644` got **no reads**.
- Placements 80–95 (about 5,000 reads) were read only at bytes 0, 4, 5, 8, 10, 12 and 14. **Bytes 6, 7 and 9 were never read.**
- Nodes 40–47, driving on the road: bytes 0, 1, 4, 7, 8–0x18, 0x1C–0x20 were read. Byte 4 was read by `0x8001C17C` and the AI (`0x80056230`); byte 1 by the edge test `0x8003136C`. Bytes 2, 3, 5, 6 and +0x1A were not read, as expected on the road on a circuit with no cops. The off-road watch (steering left) was stopped before it finished.

## 8. Cross-check with the PC format (TNFS SE)
[AndyGura/nfs-resources-converter](https://github.com/AndyGura/nfs-resources-converter) (`resources/TNFS_SE.md`) documents the PC `TRI` and `ORIP`. The PSX `.TRI` has the same layout except that on PSX RoadSection +0x16218 is the constant 1000 (the PC field is `num_props`). The PC names agree with the code-derived meanings above:

| PSX (this doc) | PC field |
|----------------|----------|
| +4 a, +6 n | `loop_chunk`, `num_chunks` |
| +8 = 0x60000 | (read as u16 6 at +10) |
| +0xC origin | `position` |
| +0x28 | `rail_tex_id` |
| +0x15B0C speed table | AIEntry `top_speed` / `legal_speed` (cop threshold) / `safe_speed`, m/s |
| node b0/b1, b2/b3 | `left/right_verge`, `left/right_barrier` (u8, 3 fraction bits) |
| node b4, b5, b6 | `num_lanes`, `fence_flag`, `verge_slide` |
| node b7 | `item_mode` (tunnels, cobbles, waterfall / water audio…) |
| node +0x1A | `unk1` (unknown on PC too) |
| placement bytes 6–9 | `flags` (unknown on PC too) |
| TRKD header b1 | `fence` (PC: 2 side bits + 6-bit texture; PSX code uses bit 5 as the mirror flag) |
| definition +8 / +9 | `frame_count` / `animation_interval` (ticks) |
| ORIX | `ORIP` (PC: version 0x2BC, 112-byte header, 12-byte polygons, 20-byte textures) |

[OpenNFS/LibOpenNFS](https://github.com/OpenNFS/LibOpenNFS) has NFS2–NFS5 parsers only; there is no NFS1 code.

## Next (paused 2026-09-27 on the user's call)
1. Finish the off-road runtime watch (node bytes 2, 3, 5, 6 read by `FUN_800311F4` / `0x8001CB1C`).
2. Placement bytes 6–9 and node +0x1A: never read by the PSX game (static + runtime); treat as tool data.
