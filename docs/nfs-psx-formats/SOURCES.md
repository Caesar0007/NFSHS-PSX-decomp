# Sources

Disc images and game data are **never committed**. Paths below are the working copies.
Share = `\\192.168.100.6\Qdownload-5\PSX`.

## Disc images

| Game | Build | Location | Notes |
|------|-------|----------|-------|
| NFS1 | USA retail | `C:\Temp\_from_github\Road & Track Presents - The Need for Speed (USA).cue` | exe work: `C:\Temp\nfs1-clean` (NFS1.EXE, FRONT.CPE, Ghidra `nfs1.c`) |
| NFS2 | USA retail | share `Need for Speed II (USA).cue` · local `C:\Temp\nfs2-clean\` | |
| NFS2 | Europe retail | `C:\Temp\nfs2psx-decomp\cdimage\` | PAL, 6 languages |
| NFS2 | Beta 1997-02-26 | share `Need For Speed 2 (Beta - Feb 26 1997)` | pre-retail format deltas |
| NFS3 | USA retail | share `NFS3.cue` / `NFS3-Retail-Usa` | SLUS-006.20 |
| NFS3 | Beta 1998-02-24 "Reviewable" | share `PSX - Need For Speed III Hot Pursuit 2-24-98 Beta Reviewable.cue` | CloneCD (.ccd/.img/.sub) |
| NFS4 | USA retail + regionals | share `NFS4-Retail-{Usa,Au,En-Es-It,En-Sw,Fr-De,J}` | local `C:\Temp\nfs4iso\NFS4.IMG` + original NFS4.CPE/.SYM/.MAP |
| NFS4 | Prototype 1999-02-23 | share `Need for Speed - High Stakes (Feb 23, 1999 prototype).7z` | |
| NFS4 | "cd-e" | share `NFS4-cd-e` | MOVIES/*.XA samples came from here |
| NFS5 | — | **uploading** (user, 2026-09-27) — expected on the share soon | Porsche Unleashed (USA) / Porsche 2000 (EU); not in Redump set |

PC counterparts (useful oracles, not in scope): `share nfs3-pc.iso`, `C:\Temp\_nfs3pcbeta\EA PC Preview.iso`, `C:\Temp\nfs4-pc`.

## Redump set (verified dumps, zipped)
`\\192.168.100.6\Qdownload\Minerva_Myrient\Redump\Sony - PlayStation` — preferred source for
checksummed reference images.

| Game | Redump entries |
|------|----------------|
| NFS1 | Road & Track Presents - The Need for Speed (USA) · (Europe) (En,De) · **Over Drivin' DX (Japan)** · Over Drivin' DX - Rally Edition (Japan) |
| NFS2 | Need for Speed II (USA) · (Europe) (En,Fr,De,Es,It,Sv) · **Over Drivin' II (Japan)** |
| NFS3 | Need for Speed III - Hot Pursuit (USA) · (Europe) (En,Fr,De,Es,It,Sv) · **Over Drivin' III - Hot Pursuit (Japan)** + (Demo) |
| NFS4 | Need for Speed - High Stakes (USA) · (Australia) · Road Challenge (Europe) ×3 language sets · **Over Drivin' IV (Japan)** + (Demo) |
| NFS5 | **none** — Porsche Unleashed / Porsche 2000 absent from this set too |

Japanese "Over Drivin'" releases and the demos are cheap sources of format variants (region
text/fonts, trimmed content, pre-final builds).

## Extracted trees
- NFS4: `C:\Temp\nfs4_extracted` — 702 files (232 VIV, 139 PSH, 40 GRP, 40 AUD, 31 DCT, 29 QDA, 29 QCS, 22 QPS, 18 BIN, 13 BNK, …)
- NFS3: `C:\Temp\claud\nfs3_re_project\extracted` — one track's set (TRK COL GEO HRZ DPQ VIS CCM MAP PSH GRP QAS QAL QBE QSL QSS QTS PKL OBJ COP) — **partial**, full disc not extracted
- NFS1 / NFS2 / NFS5: not yet extracted

## Prior specs (to be migrated into `formats/`)
- **NFS4 byte-level spec** — `C:\Temp\_from_github\pcsx-redux\nfs4\NFS4_DISC_FORMATS_BYTELEVEL.md` (3749 lines) + `NFS4_DISC_FORMATS_SPEC.md`; loader decompiles in `...\nfs4\decomp\` (`INDEX.md`). ⚠️ Its GRP §2.2 is superseded by the 2026-04-29 GRP-100% analysis (`C:\Temp\claud\SESSION_2026-04-29_NFS4.md`, `C:\Temp\claud\grp_analysis\NFS4_GRP_Deep_Analysis.xlsx`) and its §6 DCT and §2.6 GEO descriptions were corrected later.
- **NFS4 tooling** — same dir: `gimex_decoder.py` (PSH), `bnk_patch_walker.py`, `huffman_via_emu.py`, `unhuff_port.py`, `nfs4_codecs.py` (B-tree), `refpack.py`.
- **NFS3→NFS4 converter specs** — `C:\Temp\claud\nfs3_to_nfs4_converter\` (`ZTRNN_BIN_FORMAT_SPEC.md`, `QDA_QCS_FORMAT_SPEC.md`, `DCT_FORMAT_SPEC.md`, `AUXILIARY_FILES_SPEC.md`, `NFS3_DEEP_INVENTORY.md`, `CRITICAL_FORMAT_CORRECTIONS.md`, …).
- **LibOpenNFS** (MIT) — github.com/OpenNFS/LibOpenNFS; NFS4 PS1 structs copied to `C:\Temp\claud\grp_analysis\` (SerializedGroupOps.*, NFS4PS1Loader.*). Parsers for NFS1–NFS5 PC/PS1 — cross-check source.
- **NFS4-Utils (Delphi)** — the user's own viewers/tools (DTC viewer etc.).
- **Movies** — NFS4 `.XA` = standard Sony STRv2 + XA-ADPCM (jPSXdec-confirmed; not EA eavideo).

## Code oracles (loader authority)
- NFS4: `C:\Temp\nfs4-decomp` (byte-matched source) + SYM `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt` + disasm `C:\Temp\symdump-disasm\disasm-v4.txt`
- NFS3: `C:\Temp\nfs3-clean` (reconstructed, Ghidra `nfs3-f.c`, IDA `NFS3-F.IDA.c`)
- NFS2: `C:\Temp\nfs2-clean`, `C:\Temp\nfs2psx-decomp`, IDA `NFS2-F.IDA.c`; PC beta `nfsw.exe` with full Watcom debug info (named loaders)
- NFS1: `C:\Temp\nfs1-clean` (Ghidra `nfs1.c`)
