# Conversion methods

Each converter gets: direction, inputs → outputs, what is preserved, what is **lost or
synthesized**, validation status, and tool location.

## NFS3 → NFS4 track (authoritative core exists)
- Tool: [`tools/nfs3_to_nfs4.py`](tools/nfs3_to_nfs4.py).
- Direction: one NFS3 PSX layout (`TRK` + `COL`, with `PSH`/`DPQ` companions) → one selected NFS4
  track slot (`GRP` + copied `0.PSH`/`R.PSH` + converted `.ENV`). This is intentionally a slot
  overlay: keep the target NFS4 track's `.BIN`, AI, audio and other auxiliary files until converters
  for those families exist.
- Example:
  `python tools/nfs3_to_nfs4.py C:\Temp\nfs3_disc 00A output --target 00 --variants`
- Preserved / translated: chunk centres and bounds, high-detail road strips, high-detail overlay
  quads, materials and texture indices, vertex lighting (the NFS3 colour word split as the NFS3
  renderers do: bits 10–14 = r, 5–9 = g, 0–4 = b, each `<< 3`; quantized only when a track has more
  than 256 colours), collision surfaces, sim slices, persistent road slices (`pavedProfile` is the
  same lane mask in both games), visibility, road lines, light flares (NFS3 types mapped by colour
  onto NFS4 `Flare_gType` kinds), sim objects, object definitions, static/animated object instances,
  track/reflection textures, DPQ environment-map zones and the `.COP` triggers (same record layout).
  All 10,906 NFS3 definitions and 10,906 instances across the retail set tile and remap exactly into
  the generated NFS4 object tables.
- NFS4's 256-vertex chunk limit is enforced. Strips share their vertex rows between consecutive
  slices, so a chunk normally keeps the NFS3 vertex count; where the topology still exceeds 256,
  lateral road resolution is reduced deterministically (314 of 174,000 road quads over the 15 retail
  layouts, 303 of them on 01B) and reported by the CLI. Every kept strip quad reproduces its NFS3 `q4`
  quad vertex-for-vertex (round-trip check on 00A, 02A, 06A).
- Visibility rows are trimmed to the 32 nearest neighbours (NFS3 lists reach 45 entries; NFS4
  stores 36 but corrupts entries 32–35 through its 64-byte row stride).
- Explicit approximations/losses (reported by the CLI): NFS3 kind-4 collision-linked objects are
  emitted as visible static NFS4 type-1 instances rather than breakable type-5 instances; NFS3 chunk
  ambient emitters are moved into all four NFS4 `.AUD` condition files with retail-derived default
  range/timing fields; `.QBE`/`.QCR` are valid RefPack files containing a neutral centre racing line
  and zero curvature rather than converted NFS3 AI strategy; the synthesized four-condition TrackSpec
  uses NFS3 HRZ/DPQ colours and depth distance but deliberately disables texture-indexed horizons;
  music/animation/replay auxiliaries are not generated; NFS3's alternative-route slice links and
  per-slice interactive-music events have no NFS4 equivalent and are dropped (reported).
- Validation: all **15/15** USA-retail NFS3 layouts convert; all **2,234/2,234 chunks** pass
  `tools/nfs4_grp_validate.py` with zero structural or semantic failures. Runtime test (2026-09-28):
  NFS3 `00A` installed into NFS4 slot 06 on a rebuilt test image; unpatched retail NFS4 completed all
  120 `Chunk::InstanceGroup` calls, material/slice/object initialization and returned from
  `Track_Init("zTr06.grp")`. `gNumSlices` was 959 and simulation advanced 5,160 ticks during 1,500
  post-init pad frames. Review 2026-09-29 (colour split, flare kinds, row sharing, visibility
  trim): re-run on a fresh
  test image (`psx_iso_inject.py`, 00A → slot 06 with variants): `Track_Init("zTr06.grp")` completed
  every stage and returned, `tools/runtime/compare_track_init.py` passed 8/8 against the converted
  GRP (header, centres, 959 slices, 97-entry light table, 120 chunk metas, quad counts, visibility
  rows, no overlap-bug chunks), and the simulation advanced 5,159 ticks over 1,500 post-init pad
  frames with Cross held. Manual visual-fidelity inspection is still required.
- Test images: `tools/psx_iso_inject.py <NFS4.IMG> <out.bin> <converted dir>` replaces the slot's
  files in a copy of the retail image (in place or appended, Mode 2 Form 1 EDC/ECC regenerated —
  byte-exact against retail sectors) and writes the `.cue`.

The older research prototype at `C:\Temp\claud\nfs3_to_nfs4_converter` is retained as an experiment
archive, but it is not the format authority. Its self-audits predate the loader/runtime-confirmed
specs and accept obsolete constructs (including a custom GRP `0x30` UV table and an OpenGL-oriented
X-axis flip) that the retail NFS4 loader does not define.

## Planned
| Conversion | Why | Depends on |
|------------|-----|------------|
| PSH ⇄ PNG (all titles) | asset inspection, modding | PSH family doc; `gimex_decoder.py` covers NFS4 decode |
| Q* compress/decompress (round-trip) | every other converter needs it | Q* family doc; `refpack.py`, `nfs4_codecs.py`, `unhuff_port.py` |
| VIV unpack/repack (byte-identical) | archive editing | VIV family doc |
| NFS4 GRP/zScene → glTF/OBJ | open-format export | GRP + CAR docs |
| NFS2 ⇄ NFS3 track | same engine lineage; tests the lineage claim | NFS2/NFS3 track docs |
| XA/DCT → standard video | preservation | existing jPSXdec path for XA |
| NFS4 → NFS3 cars/tracks (reverse direction) | proves both sides are understood | all of the above |
