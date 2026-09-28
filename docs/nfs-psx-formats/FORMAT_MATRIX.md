# Format matrix

Legend: ★★★/★★/★ = best confidence reached (see METHOD.md) · `seen` = present on disc, not studied ·
`—` = not used by that title · `?` = not surveyed yet. NFS4 statuses come from the prior byte-level
spec + later corrections; they get re-verified as each family is migrated into `formats/`.

| Family | Purpose | NFS1 | NFS2 | NFS3 | NFS4 | NFS5 | Spec |
|--------|---------|------|------|------|------|------|------|
| VIV (BIGF) | EA archive | ? | ? | seen | ★★★ | ? | — |
| VIV (C0FB) | compact EA archive (per-track anim scripts) | ? | ? | ? | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md) |
| Q* codecs (RefPack 0x10, Huffman 0x30/32/34, B-tree 0x46) | compression wrapper (`unpackz`) | ? | ? | seen | ★★★ | ? | [NFS4](formats/NFS4_Q_CODECS.md) |
| PSH (SHPP/GIMX) | textures / sprites | ? | ? | seen | ★★★ | ? | [NFS4](formats/NFS4_PSH.md) |
| QPS | B-tree-packed PSH (loading screens) | ? | ? | ? | ★★★ | ? | [NFS4](formats/NFS4_PSH.md) |
| TRI (NFS1: RoadSection + `OBJS` + `TRKD` records + `CRCF`) | NFS1 track geometry | ★★★ container, nodes, cross-sections, objects, speed table | — | — | — | — | [NFS1](formats/NFS1_TRACK_FILES.md) |
| FAM / INF / LGT / LGS (NFS1) | animated objects (`0x77777777` offset container of `ORIX` models + `SHPP` textures), horizon script, per-point lighting, light script | ★★★ | — | — | — | — | [NFS1](formats/NFS1_TRACK_FILES.md) §2–5 |
| `CRCF` trailer (NFS1) | CRC-16 (0xA001 table, init 0xFBEA) on every data file / BIGF entry | ★★★ 1,052/1,052 | — | — | — | — | [NFS1](formats/NFS1_TRACK_FILES.md) §6 |
| GRP (SerializedGroup) | track geometry container | — | — | — (ancestor = TRK) | ★★★ | ? | [NFS4](formats/NFS4_TRACK_GRP.md) |
| TRK (`TRAC` v22) | streamed track geometry: meta-chunks of 8 chunks, typed sub-blocks | ? | ★★★ container (6 B verts, 8 B quads) | ★★★ container + core records | — | ? | [NFS3](formats/NFS3_TRACK_FILES.md), [NFS2](formats/NFS2_TRACK_FILES.md) |
| COL (`COLL` v11) | persistent track data: typed collections (materials, slices, objects, instances) | ? | ★★★ container | ★★★ container, materials, slices, objects | — | ? | [NFS3](formats/NFS3_TRACK_FILES.md), [NFS2](formats/NFS2_TRACK_FILES.md) |
| VIS / DPQ / HRZ / CLR (text) | vis-list source; depth cue + env zones; horizon; car colours | ? | ? | ★★★ (VIS = TRK type 4 source, never opened) | — | ? | [NFS3](formats/NFS3_TRACK_FILES.md) |
| CCM (trackside cameras) / T{F,B}.BIN (tutor prompts) | NFS3 track extras | ? | ? | ★★★ | — | ? | [NFS3](formats/NFS3_TRACK_FILES.md) |
| MAP (PFDx) / TRJ, TRM, MUS (SCHl) | interactive music (PathFinder maps + ASF streams) | ? | ? | ★★★ | — | ? | [NFS3](formats/NFS3_TRACK_FILES.md) |
| ZTR<NN>.BIN (TrackSpec) | sky/fog/horizon/weather/night config | ? | ? | ? | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md) |
| CAR / GEO (zScene) | car geometry | ? | ? | ? | ★★★ | ? | — |
| QBE / QCR | AI racing line / curvature (Huffman) | ? | ? | seen | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md) |
| QDA / QCS | car data / curve-speed tables (compressed) | ? | ? | seen | ★★ | ? | — |
| BNK (BNKl) | sound bank, TLV patch records | ? | ? | ★★★ (+ speech clips, ZSPEECH.IDX) | ★★★ | ? | [NFS3](formats/NFS3_TRACK_FILES.md) |
| AUD | ambient positional sounds | ? | ? | ? | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md) |
| ENG.VIV inner (.bnk/.h/.ltb/.ctb/.cfg) | per-car engine audio | ? | ? | ? | ★★ | ? | — |
| PFN (FNTP) | fonts | ? | ? | ? | ★★★ | ? | — |
| COP | cop / pursuit triggers | ? | ? | ★★★ container | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md), [NFS3](formats/NFS3_TRACK_FILES.md) |
| FOG | fog keys {slice, distance} | ? | ? | ? | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md) |
| KIL / ENV (text) | kill list; car env-map/shadow zones | ? | ? | ? | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md) |
| MIS / TRN | missions; tournaments | ? | ? | ? | ★★ | ? | — |
| CAN / SCN / RHO | anim scripts (C0FB archive), scenes, replay cameras | ? | ? | ? | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md) |
| DCT | EA BS-frame preview video | ? | ? | ? | ★★ | ? | — |
| XA (STRv2 + XA-ADPCM) | FMV | ? | ? | ? | ★★★ | ? | — |
| Text (.ENG/.FRE/… , ZTEXT/ZPTEXT.MET) | localisation | ? | ? | ? | ★★ | ? | — |
| DAT / CSV | misc tables | ? | ? | ? | ★ | ? | — |
| FRONT.BIN | FE overlay (SimpleMem heap image) | ? | ? | ★★ (overlay in reserved hole) | ★★★ | ? | — |
| Memory-card save | save format | ? | ? | ? | ? | ? | — |

## Next surveys (in order)
1. NFS3: track containers + core records done ([NFS3_TRACK_FILES.md](formats/NFS3_TRACK_FILES.md)); next = remaining TRK/COL records, then the non-track families.
2. NFS2 USA → same; NFS2 beta for pre-retail deltas.
3. NFS1 USA → census (likely distinct 3DO-lineage formats).
4. Migrate NFS4 families into `formats/` one at a time, re-verifying each field against
   the matched source (the decomp repo gives exact loader code).
5. NFS5 once an image is obtained.
