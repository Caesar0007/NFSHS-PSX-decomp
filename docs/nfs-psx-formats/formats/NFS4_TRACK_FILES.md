# NFS4 track file set — overview & loader map

Games: NFS4 (High Stakes / Road Challenge, PSX 1999). Reference data: pristine files extracted
from the retail image (`tools/psx_iso.py get NFS4.IMG <dir>`); **do not use** `C:\Temp\nfs4_extracted`
for track 00 — `ZTR00.GRP/.ENV/ZTR000.PSH` there were overwritten by NFS3→NFS4 converter output.

Loader authority = the byte-matched recon in `nfs4-decomp/recon/` (file:line below).

## Tracks on disc
10 track numbers: `00 02 03 04 05 06 07 08 09 10` (no 01). Every track has the same file set.
Path prefix comes from `Track_MakeTrackPathName` / `Track_MakeTrackDataPathName`
(`track.cpp:105,115`, format `"%sTr%02d%s"`); on disc the names carry a `Z` prefix (`ZTR<NN>…`).

| File | Variants | Purpose | Loader (recon) | Spec |
|------|----------|---------|----------------|------|
| `ZTR<NN>.GRP` | `N` night, `S` storm, `W` weather/wet; base = day/clear | track geometry, visibility, materials, objects, sim surface | `Track_Init` `track.cpp:870`; selection `bworld.cpp:988,1134` | [NFS4_TRACK_GRP.md](NFS4_TRACK_GRP.md) |
| `ZTR<NN>0.PSH` | `N0`, `S0`, `W0` | track textures (SHPP/GIMX) | `TexturesLoadInitial` `track.cpp:302` (`0/S0/N0/W0.psh`) | [TEXTURES](NFS4_TRACK_TEXTURES.md) |
| `ZTR<NN>R.PSH` | — | reflection/env-map textures | `track.cpp:352` (`r.psh`) | [TEXTURES](NFS4_TRACK_TEXTURES.md) |
| `ZTR<NN>.FOG` | `N`, `S`, `W` (only track 00 on disc has variants) | fog keys | `textureprocess.cpp:301-332` | [AUX](NFS4_TRACK_AUX.md#fog--fog-trigger-keys-) |
| `ZTR<NN>.ENV` | — | car env-map + shadow zones (**text**) | `drawc.cpp:225` (`DrawC_ReadLightingData`) | [AUX](NFS4_TRACK_AUX.md) |
| `ZTR<NN>.BIN` | — | TrackSpec: sky, fog, horizon, weather, night, colour | `trackspec.cpp:438` | [AUX](NFS4_TRACK_AUX.md) |
| `ZTR<NN>.KIL` | — (only 2 tracks) | object kill list | `KillFile_OpenRead` `track.cpp:1043-1063` | [AUX](NFS4_TRACK_AUX.md) |
| `ZTR<NN>.COP` | — | cop / pursuit triggers | `aicop.cpp:57` | [AUX](NFS4_TRACK_AUX.md) |
| `ZTR<NN>.QBE` / `.QCR` | uncompressed dev names `.bes` / `.crv` | AI racing line / curvature (Huffman-packed) | `aidatarecord.cpp:191-208` | [AUX](NFS4_TRACK_AUX.md) |
| `ZTR<NN>00..03.AUD` | 4 per track | ambient positional sounds | `audedit.cpp:38` | [AUX](NFS4_TRACK_AUX.md) |
| `ZTR<NN>A.VIV` | — | canned animation scripts `tr00aNN.can` (C0FB archive) | `anim.cpp:41,55` | [AUX](NFS4_TRACK_AUX.md) |
| (in `ZCAMERA.VIV`) `trNN.rho`, `trNNr.rho` | replay | replay cameras (32 slots) | `replay.cpp:614-619` | [AUX](NFS4_TRACK_AUX.md) |
| (in scene VIV) `trNNMM.scn` | — | scripted scenes | `scene.cpp:92` | [AUX](NFS4_TRACK_AUX.md) |

Names referenced by code but **absent from the retail disc**: `Tr%02d.trf` (`aiinit.cpp:173`),
`Tr%02d%c.ctk` (`aidatarecord.cpp:231`), and the uncompressed `.bes`/`.crv` — dev-build leftovers.

Global track-related files: `ZFETRK.TRK`, `ZFETRKB.TRK` (front-end track list), `ZTOURN*.TRN` (tournaments).

## Variant selection
`bworld.cpp:1134-1144` picks `S.grp`, `N.grp`, `W.grp` or `.grp`; `textureprocess.cpp:320-332` does the
same for `.fog`; `track.cpp:309-319` for `S0/N0/W0/0.psh`. Census: the 4 GRP variants of a track share
an identical chunk structure (same chunkCount, metaChunkCount); lighting tables and materials differ.
