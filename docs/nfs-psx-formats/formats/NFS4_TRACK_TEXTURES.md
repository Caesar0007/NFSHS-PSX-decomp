# NFS4 track textures: `ZTR<NN>{0,N0,S0,W0}.PSH` and `ZTR<NN>R.PSH`

Container format = EA `SHPP`/`GIMX` shape file, see [NFS4_PSH.md](NFS4_PSH.md). This page covers how a track uses them. ★★★ = loader-confirmed
(`TexturesLoadInitial`, `track.cpp:302`) and checked on all 40 retail GRP/PSH pairs.

## Variant selection
| Condition | File |
|-----------|------|
| night and weather | `ZTR<NN>S0.PSH` |
| night | `ZTR<NN>N0.PSH` |
| weather | `ZTR<NN>W0.PSH` |
| clear day | `ZTR<NN>0.PSH` |

Same 2×2 selection as the GRP, FOG, AUD and TrackSpec variants. **If the file fails to load, the loader
spins forever** (`do {} while (true)`), so a missing texture file hangs the game.

## Loading
- The file is loaded with `loadshapeadr`; `gInitialArt.shapeCount = shapecount(file)`.
- `LoadShapesAndMakePmx(file, gInitialArt.pPmx, 0x40, 0x100, 0)` uploads every shape to VRAM starting
  at x = 256 and builds one pixmap (`Draw_tPixMap`) per shape; the file buffer is then freed.
- The **spike-belt pixmap** is appended as one extra shape (index = the file's shape count), so
  materials can address `shapeCount` itself.
- `Hrz_GetHorizonPixMap` then derives the horizon pixmap.
- `ZTR<NN>R.PSH` (reflection maps) is optional; when present it is uploaded at x = 0x3E0 (992) into
  `Track_gReflectionMaps` via `LoadShapesAndMakePmx_EnvMap`.

## Link to materials
A GRP material's `shapeIndex` (plus `textureCount − 1` for animated materials) indexes these shapes;
multi-palette materials (flag 0x02) remap through `Track_GetProperMultiPalShapeIndex`. Materials with
flip/rotate `uvFlag` bits create derived pixmaps appended after the base set (`Track_ProcessFlipAndUVFlags`).
Census: in every track and variant, the highest shape a material uses is below the variant's shape count.

| Track | Shapes D / N / S / W | Materials | Highest shape used |
|-------|----------------------|-----------|--------------------|
| 00 | 209 / 209 / 200 / 200 | 372–374 | 199 |
| 02 | 258 / 258 / 258 / 249 | 478 | 214 |
| 03 | 206 / 202 / 202 / 189 | 434–440 | 188–192 |
| 04 | 184 / 179 / 183 / 177 | 331–336 | 172–177 |
| 05 | 145 / 145 / 145 / 136 | 243 | 135 |
| 06 | 181 / 181 / 181 / 178 | 340 | 177 |
| 07 | 181 / 181 / 181 / 171 | 302 | 170 |
| 08 | 117 / 117 / 117 / 110 | 217 | 109 |
| 09 | 130 / 130 / 130 / 117 | 183 | 116 |
| 10 | 120 / 120 / 120 / 120 | 182 | 113 |
