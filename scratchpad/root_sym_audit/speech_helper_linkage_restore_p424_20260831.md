# Speech helper natural-linkage restoration

Date: 2026-08-31

## Defect and evidence

Retail `spchpick.obj` calls the exported helpers by their natural source names:
`VoxEvent_GetFilterLengthFlag` and `iSPCH_GetOffset16`. The corresponding
`spchdata.obj` implementations had instead been declared with address-suffixed
assembly names. Detailed gates tolerated the relocation labels, but the whole
reconstruction retained four unresolved speech call relocations.

`spchdata.c` now defines both helpers with their natural identifiers. Zero-code
co-equal symbols retain the address-suffixed oracle/config keys needed to keep
duplicate static helper copies distinct. The source/oracle lane provides the
reverse aliases, and the shared declarations now carry the actual return types
and arities.

## Proof

- `VoxEvent_GetFilterLengthFlag_8010073C`: PASS, 3 instructions.
- `iSPCH_GetOffset16_80100760`: PASS, 7 instructions.
- `iSPCH_OrderSentences`: PASS, 83 instructions.
- `iSPCH_ChooseSentence`: PASS, 104 instructions.
- Undefined-call audit: 15,781 call relocations, zero undefined.
- Both relink lanes: GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols.
- Phantom audit: all 3,491 oracle names exactly owned, no hidden phantoms or
  unmatched ownership gap.
- Focused type graph: all nine speech TUs remain explicitly `SYM_UNTYPED`; no
  false claim of recoverable retail type records is introduced.

Durable evidence:
`spchpsxz_helper_linkage_p424_20260831.tsv` and
`speech_helper_linkage_relink_p424_20260831.json`.
