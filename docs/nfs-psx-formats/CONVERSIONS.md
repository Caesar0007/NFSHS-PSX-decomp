# Conversion methods

Each converter gets: direction, inputs → outputs, what is preserved, what is **lost or
synthesized**, validation status, and tool location.

## NFS3 → NFS4 track (exists)
- Tool: `C:\Temp\claud\nfs3_to_nfs4_converter\converter.py` (+ `verify.py`, `audit.py`,
  `audit_all_tracks.py`); status per its README: 15/15 track layouts converted, 37/37 audits pass.
- Direction: NFS3 PSX NFS2-engine track set (TRK/COL/HRZ/DPQ/VIS/…) → NFS4 GRP SerializedGroup
  container (+ synthesized ENV, ZTR<NN>.BIN).
- Preserved: geometry, collision, lighting, texture references.
- Synthesized / lost: see the converter's `CRITICAL_FORMAT_CORRECTIONS.md`,
  `STRATEGY_B_REFINEMENT_LOG.md`, `EXTERNAL_VALIDITY_REPORT.md` — to be summarized here when the
  GRP and NFS3-track families are written up.
- Validation gap: file-level structure verified against real NFS4 GRPs (inner 0x1F block
  byte-identical); **in-game load test not yet recorded here**.

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
