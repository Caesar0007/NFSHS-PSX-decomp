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
| GRP (SerializedGroup) | track geometry container | — | — | ★★ (converter output) | ★★★ | ? | [NFS4](formats/NFS4_TRACK_GRP.md) |
| TRK / COL / GEO / HRZ / DPQ / VIS / CCM / MAP | NFS2-engine track set | ? | ? | ★★ | — | ? | — |
| ZTR<NN>.BIN (TrackSpec) | sky/fog/horizon/weather/night config | ? | ? | ? | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md) |
| CAR / GEO (zScene) | car geometry | ? | ? | ? | ★★★ | ? | — |
| QBE / QCR | AI racing line / curvature (Huffman) | ? | ? | seen | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md) |
| QDA / QCS | car data / curve-speed tables (compressed) | ? | ? | seen | ★★ | ? | — |
| BNK (BNKl) | sound bank, TLV patch records | ? | ? | ? | ★★★ | ? | — |
| AUD | ambient positional sounds | ? | ? | ? | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md) |
| ENG.VIV inner (.bnk/.h/.ltb/.ctb/.cfg) | per-car engine audio | ? | ? | ? | ★★ | ? | — |
| PFN (FNTP) | fonts | ? | ? | ? | ★★★ | ? | — |
| COP | cop / pursuit triggers | ? | ? | seen | ★★★ | ? | [NFS4](formats/NFS4_TRACK_AUX.md) |
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
1. Extract NFS3 USA retail fully → census every extension, fill the NFS3 column.
2. NFS2 USA → same; NFS2 beta for pre-retail deltas.
3. NFS1 USA → census (likely distinct 3DO-lineage formats).
4. Migrate NFS4 families into `formats/` one at a time, re-verifying each field against
   the matched source (the decomp repo gives exact loader code).
5. NFS5 once an image is obtained.
