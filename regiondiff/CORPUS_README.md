# regionrecon -- per-version workspaces for the functions that DIFFER from base

Base = NFS4-B-USA.EXE == nfs4-f.exe (the matched decomp project, 3490 named
fns). Each NFS4-R-<region>/ holds ONLY that version's differing functions:

  functions/<name>.s   m2c-dialect asm sliced from that region's EXE
                       (objdump -z, COP2 fixups, jump tables resolved,
                       boundary merges applied, data tails trimmed)
  c/<name>.c           m2c fork decompile; header = identity line
                       (class, VAs, base name) + callers + string evidence
  INDEX.tsv            class / region_va / base_va / name / rows / callers /
                       strings;  MERGED-INTO:x = slice absorbed into x

Classes: CHANGED (differs from base -- keeps the ground-truth base name),
REGION-ONLY (no beta counterpart -- func_<va>, identify via callers/strings).

## State (2026-08-16): every workspace decompiles with 0 failures
  AU 172 files (152 CHANGED / 32 REGION-ONLY / 10 merged)
  FR-DE, UK-ES-IT, UK-SW 171 files (151/20/22)  JPN 169 (151/18/22)
  USA 151 files (133 CHANGED / 18 REGION-ONLY / 22 merged)

## variants.tsv -- the reconstruction work plan (relocation-masked dedup)
218 distinct differing functions; 207 have ONE source variant across all
their regions (inter-region deltas are pure relocation -> one reconstruction
serves every version), 11 have real inter-region logic differences:
  3-variant: DoLanguageScreen (FR-DE / UK-ES-IT / UK-SW language menus),
             Initialize__11tScreenMain, Redraw__14tFEApplication (PAL/JPN/US
             display timing)
  2-variant: memcard family (JPN+USA vs PAL), Movie_Play, DrawCar,
             MenuNFS4_DrawTextBox, __15tGlobalMenuDefs (JPN menu defs), etc.
=> 232 unique source variants total (vs 1005 naive per-region slots).

## Reconstruction protocol (matching-decomp discipline)
1. Take the variant's .c draft + the base project's sealed source for that
   function (CHANGED fns: the delta vs base source is usually a few lines --
   diff the two m2c drafts first).
2. Reconcile against the .s (the raw oracle for args/delay-slots/signedness).
3. Gate byte-exact per the nfs4-decomp lane (ccpsx/psyqproof) against the
   region EXE bytes; region relocs resolve through symbols, so one source
   variant gates against every region that shares it.
4. REGION-ONLY fns: identify via the recorded callers (e.g. 80075F28 <-
   AudioClc_SoundCars, 8009A5AC <- AudioCmn_Reset/CopSpeak = the retail
   CopSpeak replacement) before writing the reconstruction.

Pipeline: regiondiff.py (identify) -> regionrecon.py (slice+decompile) ->
regionfix.py (repairs + variants.tsv). All re-runnable from scratch.
