# Game/PSX PASS-lock carrier resolution — twenty-fourth wave

Scope: two byte-matched functions reconstructed from their SYM locals and
natural aggregate/indexed source forms.

## Natural source restoration

### `Hrz_GetHorizonPixMap`

Nine decompiler-only address walkers and byte offsets were replaced by direct
indexed accesses to `gHorizonPixmap` and `gHorizonExtraSkyPixmaps`. The function
now contains exactly its sole SYM local, `i`, and remains PASS 45/45.

### `Weather_Init`

The weather-position initialization and drawn-flag clearing loops now use the
SYM locals `i` and `sv` directly. Eight decompiler pointer/index/random staging
names were removed. The two aggregate-copy base values `pmVar4` and `pmVar5`
remain explicitly classified: the existing receipt proves that the duplicated
address evaluation supplies the retail register copy and movstrsi scratch pool.
The function remains PASS 211/211.

## Audit movement

- declaration-clean functions: 368 -> 370
- generic extra source-local names: 415 -> 396
- explicit source-only codegen carriers: 238 -> 240
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0.

## Whole-translation-unit regression gates

- `hrzsku.cpp`: 20/22 PASS; unchanged locked failures:
  `Hrz_BuildHorizon` FAIL 12 and `Hrz_BuildSky` FAIL 146.
- `weather.cpp`: 25/25 PASS.
- vtable indexing audit: PASS across 926 files.

No unmatched function body was edited.
