# NFS4 `.PSH` — EA shape file (`SHPP` / `GIMX`), and `.QPS`

Games: NFS4 ★★★ (other titles: to survey). Loader authority (nfs4-decomp recon):
`loadshapeadr` (`eaclib/psx/eacpsxz/loadshp.c`), `shapecount`/`shapepointer`/`shapename`
(`shpsubs.c`), `locateshape(z)` (`locatshp.c`), `shapedepth` (`shpdepth.c`), `getshapeclut`/
`shapetoclutid` (`shpclut.c`), upload `Texture_LoadPmx`/`Texture_Vramcf`/`Texture_GetTranslucencyMode`
(`game/psx/texture.cpp`). Tool: `tools/nfs4_psh.py` (`info`, `png`, `census`).

Census: all 161 shape files on the retail disc (139 `.PSH` + 22 `.QPS`), 10,003 shapes, validate with
no problems; exported images are visually correct (see below).

## Loading
`loadshapeadr(name)` appends `.psh` when the name has no extension and loads through `loadpackadr`,
so any shape file may be Q-packed as a whole. **`.QPS` = a B-tree-packed PSH** (all 22 loading-screen
files; see [NFS4_Q_CODECS.md](NFS4_Q_CODECS.md)).

## File header and directory ★★★
| Off | Type | Field |
|-----|------|-------|
| 0 | char[4] | `SHPP` |
| 4 | u32 | total file size (equals the file size in every retail file) |
| 8 | i32 | shape count (`shapecount`) |
| 12 | char[4] | `GIMX` (platform tag; every retail file) |
| 16 + 8i | char[4] | shape name (`shapename`) |
| 20 + 8i | i32 | shape offset from the file start (`shapepointer`) |

`locateshape` finds a shape by its 4-byte name, scanning the directory from the end.

## Shape = chain of blocks ★★★
Every block starts with a 16-byte header; the first block of a shape is the image.

| Off | Type | Field |
|-----|------|-------|
| 0 | u8 | block type |
| 1 | u24 | offset to the next block, relative to this one; 0 = last block |
| 4 | i16 | width |
| 6 | i16 | height |
| 8 | i16 | centerx |
| 10 | i16 | centery |
| 12 | u32 | bits 0–11 `shapex`, 12–13 reserved, 14 `transposed`, 15 `rotated`, 16–27 `shapey`, 28–31 `mipmaps` |
| 16 | … | block data |

### Image block
Pixel depth = `type & 3` for upload (0 = 4-bit, 1 = 8-bit, 2 = 16-bit direct); `shapedepth` maps
`type & 0x77`: 0x40 → 4, 0x41 → 8, 0x42 → 16, 0x23 → 16, 0x43 → 24, 0x44 → 1, 0x72 → 8, else 1.
Rows are padded to 16-bit units: stride = `((width · depth + 15) & ~15) / 8` bytes. Pixels are stored
**uncompressed** (the upload path has no decompression; no retail shape sets bit 0x80).
16-bit colour is PSX BGR555 (bit 15 = semi-transparency, value 0 = transparent).
VRAM position = (`shapex` + load x, `shapey` + load y): the atlas layout is baked into the file (track
textures load at x = 256, reflection maps at x = 992). `rotated` swaps the UV corners.
Retail census: 8,072 × 0x40 (4-bit), 1,654 × 0x41 (8-bit), 277 × 0x42 (16-bit).

### Chained blocks
| Type | Name | Meaning | Reader |
|------|------|---------|--------|
| `0x23` | palette | 16-bit image holding the CLUT; for 4/8-bit images it is the **next** block, used as 16 / 256 entries; +12 packs the CLUT VRAM x (bits 0–11) and y (bits 16–27) | `Texture_LoadPmx`, `shapetoclutid` (matches `type & 0xF7`) |
| `0x6B` `'k'` | translucency | blend mode = `(width >> 5) & 3` (3 is treated as 2); on `#CLD`, `#SMK` etc. | `Texture_GetTranslucencyMode` |
| `0x6F` `'o'` | (tool metadata) | on `!`-named multi-palette textures; always last in the chain | none in NFS4 |
| `0x7C` `'\|'` | (tool metadata) | 10 in `ZHUD.PSH`; always last | none in NFS4 |

Every one of the 9,726 paletted images on the disc has a `0x23` block with enough entries.

## Name conventions used by the track loader ★★★ (`LoadShapesAndMakePmx`, `track.cpp`)
- `!XYn` — multi-palette variant *n* of texture family `XY` (`n` = 0 is the original); GRP materials
  with flag 0x02 choose the variant through `interval`.
- `ZR??` (8-bit) / `ZZ??` — mipmap parent and its lower-resolution level; used only when fog is on.
- `#…` — keep a plain palette even when fog is on (like the first 12 shapes and all 8-bit shapes);
  other shapes get the fog-ramped palette.
