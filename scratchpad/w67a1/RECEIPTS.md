# W67-A1 RECEIPTS — BYTE-TRUTH EXTRACTION ENGINE (2026-08-15)

## What was built
- `bytetruth.py` — SN-LNK .OBJ parser (NFS3 tools_psyq_extract.py lineage) EXTENDED with:
  full patch-EXPRESSION decode (const/sym-idx/sect-base/+,-,*,/ trees rendered with real
  symbol names), symbol-index table (XDEF+XREF), per-fn span carve incl. named locals,
  reloc-masked word compare vs retail rom/nfs4-f.exe (t_addr 0x80010000 +0x800),
  masks REL32=full REL26=0x03FFFFFF HI16/LO16/GPREL16=0xFFFF (w62 RELOP anti-vacuity:
  any diff OUTSIDE the relocated field = REAL drift), retail-symbol sub-labels inside
  spans (localizes debug-stripped statics), annotated per-fn truth files.
- Primary source = C:/Temp/nfs4-clean/psyq43/extracted (per user redirect);
  SpongeBob drop = cross-check layer (copied to libs/).

## Anti-vacuity validation (before any publishing)
- MoveImage (sealed): 46w, 8 relocs -> reloc-only, drift=[]. PASS.
- CD_get_intr: no vendor XDEF (BIOS.obj debug-stripped statics) -> handled by
  retail-VA sub-labels; its span content covered under exports, reloc-only.
- Trailing-bytes parse guard (NFS3 precedent) active; every target obj parsed clean.

## Deliverables
- BYTETRUTH.md — per lib/member/fn verdict tables + per-lib analyses + totals.
- truth/<LIB>/<fn>.txt — 242 annotated vendor ground-truth files (disasm + vendor
  reloc exprs + retail word column + =/R/! flags + retail static labels).
- PROGRESS.md — per-lib landing lines (published incrementally, LIBETC first).

## Headline results
1. **A2 UNBLOCKED**: `_intrhand` ground truth live (truth/LIBETC/SetIntrMask.txt);
   whole INTR statics chain reloc-only: _initIntr/_intrhand/_set_intr_callback/
   StopCallback/RestartCallback/_bzero_w.
2. **LIBETC INTR = intr.c v1.75** (byte-identical member in BOTH drops); retail is a
   v1.75-derived build MINUS the Stop/RestartCallback thunks + GetIntrMask (0x78 elided);
   MAP's Stop/RestartCallback = the real impls (vendor statics), matched reloc-only.
3. **LIBGPU zero drift; sys.c v1.140 confirmed**; 27 SYS statics annotated (04Y now has
   vendor ground truth — every remaining SYS diff is OUR codegen, never revision skew).
4. **LIBMATH: retail == psyq43 LIBMATH.LIB verbatim** (all 20 linked fns) — 04X vendor
   object identity PROVEN and the drop identified.
5. **LIBCD floors CD_sync/CD_ready/CD_cw reloc-only** (bios.c v1.86). ONLY genuine
   drift in the whole set: CDREAD member (CdRead/CdReadSync = later revision, matches
   W60 12G per-fn 2.8.1 splice evidence).
6. **CD_init discovered unnamed in retail @0x80108140** (probe reloc-only, 120w).
   ORCHESTRATOR ACTION: add `CD_init = 0x80108140; // type:func` to symbol_addrs
   (4-layer rename discipline not needed — new name, no existing oracle).
7. **ASPSX 2.81 vs 2.77**: SpongeBob drop = 2.81 + REBUILT members (SYS .text differs,
   same $Id); retail matches the psyq43 (ASPSX 2.77-era) originals everywhere tested.
8. Retail per-fn ELISIONS mapped (lib revision tells): LIBMCRD MemCardOpen/Close;
   LIBPAD PadChkVsync/PadChkMtap/PadInfoComb/_padSetCmd/_padChkVsync/PadEnableCom;
   LIBCD CD_vol/CdLastCom/CdComstr/CdIntstr/CdMix; LIBETC thunks+GetIntrMask.

## Totals
identical=67 reloc-only=171 genuine-drift=4 (2 explained-thunks + 2 CDREAD) absent=252
=> 238/242 retail-anchored vendor fns byte-match reloc-masked.

## Files touched
scratchpad/w67a1/ only (engine, reports, truth/, libs/ copies). No recon/, no tools/,
no configs/ edits. Commits: `w67a1:` x4.
