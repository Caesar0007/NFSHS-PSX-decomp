# game/psx final function-local dispositions (P438, 2026-08-31)

The live `audit_sym_source.py recon/game/psx` review queue contained nine
source-local names absent from the reliable SYM declaration records.  Each was
re-tested against the authoritative function oracle in the current exact basin;
the retained source names now carry explicit `SYM-CODEGEN-CARRIER` receipts
rather than generic review dispositions.

## Current-basin experiments

- `Draw_kCtrlSkidmark::skidIdx`: natural indexed chunk access previously
  measured 227 diffs and 354/353 instructions; the explicit descending byte
  cursor remains PASS at 353/353.
- `Flare_Sun::trackSpec`: repeating direct `Flare_TrackSpecRows` expressions is
  FAIL 9 at 188/187; one staged shared base is PASS at 187/187.
- `Hrz_BuildHorizon::iv`: reusing the strength-reduced `iVar15` is FAIL 3 at
  472/473; a fresh `i*4` at the colour-table site emits retail's independent
  `sll` and is PASS at 473/473.
- `RaceStatistics::rows`: repeating the natural lap-row expression is
  count-exact but FAIL 10 at 475/475; keeping the shared product is PASS.
- `DrawW_OnyxLinePrim::g2`: direct `geomVertices[0..7]` access is count-exact
  but FAIL 70 at 507/507; the second word-base preserves retail's reduced-giv
  class and is PASS.
- `DrawW_SubdividFacet::q1/q2`: inlining `q+1` and `q+2` is count-exact but
  FAIL 276 at 588/588; explicit staged children preserve the retail local-qty
  set and are PASS.
- `DrawW_SubdividFacet::n0/t4`: direct early `v4 = &r_div->v[n]` without the
  snapshot/byte-offset pair is count-exact but FAIL 26 at 588/588; the staged
  pair is PASS.

These results do not assert that unrecovered compiler-shaping spellings were
retail source names.  They explicitly preserve the evidence boundary: the SYM
does not name them, the retail instruction stream requires their current value
lifetimes with this compiler reconstruction, and the natural alternatives are
quantified above.

## Closure proof

The generated sibling ledger `game_psx_strict_p438_20260831.md` reports:

- 395/395 SYM functions mapped to demangled source definitions;
- 395 declaration-clean mapped functions;
- zero missing SYM names;
- zero extra source-local names;
- zero type-comparison or function-storage findings;
- zero functions needing mapping review.

Whole-TU authoritative gates remain exact: `draww.cpp` 35/35, `flare.cpp`
27/27, `hrzsku.cpp` 22/22, and `overlays.cpp` 5/5 PASS.
