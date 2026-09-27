# NFS PSX file formats & conversion methods (NFS1 → NFS5)

Reverse-engineering the **on-disc file formats** of the PlayStation Need for Speed
series, and documenting **conversion methods** between them (and to/from open formats).

| # | Title | PSX release | Engine lineage |
|---|-------|-------------|----------------|
| NFS1 | Road & Track Presents: The Need for Speed | 1996 | 3DO/PC port, pre-EA-PSX-engine |
| NFS2 | Need for Speed II | 1997 | EA Canada PSX engine v1 |
| NFS3 | Need for Speed III: Hot Pursuit | 1998 | NFS2 track format + new renderer |
| NFS4 | Need for Speed: High Stakes | 1999 | GRP SerializedGroup tracks, zScene cars |
| NFS5 | Need for Speed: Porsche Unleashed | 2000 | (not yet surveyed) |

This folder lives inside the `nfs4-decomp` matching-decomp repo because NFS4 is the
best-understood title: its SYM + byte-matched source give **loader-confirmed** ground truth
that anchors the cross-game format lineage. The docs here are **independent of the matching
build** — nothing in `docs/` is compiled, linked, or scored.

## Layout
- [SOURCES.md](SOURCES.md) — every disc image, beta, prototype, extracted tree, and prior spec
- [METHOD.md](METHOD.md) — how a format is reversed, confidence tags, validation rules
- [FORMAT_MATRIX.md](FORMAT_MATRIX.md) — format family × game, status at a glance
- [CONVERSIONS.md](CONVERSIONS.md) — conversion methods (NFS3→NFS4 tracks exists already)
- `formats/` — one spec per format family, written cross-game (e.g. `VIV_BIGF.md` covers
  every title that uses BIGF, with per-game deltas)

## Ground rules
1. **Loader code is the authority.** A field is only ★★★ when a decompiled/matched loader
   reads it (or a sample-diff proves it arithmetically). Community specs are leads, not truth.
2. **Per-game deltas, not per-game copies.** A family doc states the shared layout once and
   lists what changes per title/region/beta.
3. **Betas and prototypes are first-class.** Format changes between beta and retail are how
   the lineage is dated — record them.
4. **Conversions must round-trip or say why not.** Every converter documents what is lost.
5. Never commit disc images, extracted game data, or copyrighted assets — only specs,
   tools, and tiny synthetic test vectors.

## Status
Project started 2026-09-27.
- **NFS4 track formats: complete** — every per-track file documented, checked on every retail instance,
  and the GRP loader output confirmed byte-exact in a running game (`tools/runtime/`).
  Specs: `formats/NFS4_TRACK_FILES.md` (index), `NFS4_TRACK_GRP.md`, `NFS4_TRACK_AUX.md`,
  `NFS4_TRACK_TEXTURES.md`, `NFS4_PSH.md`, `NFS4_Q_CODECS.md`.
- NFS1/NFS2/NFS3/NFS5 surveys not yet started (NFS5 image pending upload).
