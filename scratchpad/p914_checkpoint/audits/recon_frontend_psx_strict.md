# SYM-to-source declaration audit

Target: `C:\Temp\nfs4-decomp\recon\frontend\psx`
Trusted SYM: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`

This is a review queue, not an auto-fix list. Missing retail names are
strong evidence; extra source names can be matching carriers or decompiler
temporaries and must be tested against the function oracle before removal.
GCC-v2-mangled function/EXT names are used only as linkage keys; source
functions are mapped to their demangled C++ names and class scopes.

Strict source-identity mode: matching-only local/global/split-array
carrier annotations do not suppress missing, extra, or array-shape
findings. Carrier receipt categories remain listed for review, not
as original-name proof. Optimized/inline, ABI, canonical, host-only
and explicit type-override categories retain their separate rules
and still require their own evidence. This is not an SLD, foreign
header-interface, source-token, or complete runtime-layout seal.

## Summary

- SYM functions in target TUs: 85
- Mapped to reconstructed definitions: 85 (85 demangled class/name maps)
- Source definitions still using mangled linkage identifiers: 0
- Explicit deleting-destructor ABI carriers: 0
- Explicit cross-TU ownership closures: 0
- Declaration-clean mapped functions: 60
- Missing SYM names: 0
- Extra source-local names: 53
- Type-comparison findings: 0
- Recognized ABI/debug-equivalent type encodings: 37
  (c-struct-tag=14, generic-function-pointer=2, promoted-stack-argument=1, reference-as-pointer=4, source-typedef-tag=16)
- Function storage-class findings: 0
- Implicit aggregate special members (source body correctly absent): 0
- Explicit oracle-receipted carrier mappings: 0
- Explicit restored inline-local mappings: 0
- Explicit restored macro-local mappings: 0
- Explicit compact static-local mappings: 0
- Exact cross-build/canonical name recoveries: 0
- Explicit linkage-proven ABI parameters omitted from SYM: 0
- Explicit source-only codegen carriers: 53
- Explicit oracle-proven function type overrides: 1
- Functions needing mapping review: 0
- SYM object-owned data records in target TUs: 46
- Compact address-only data records mapped by exact name+VA: 0
- Mapped source global definitions: 28
- Special SYM vtable records mapped: 0/0
- Blob-backed object globals: 18
- Missing/extra global definitions: 0/0
- Global storage-class findings: 0
- Explicit oracle-proven global storage overrides: 0
- Global type findings: 2
- Recognized global debug-equivalent types: 0
  (none)
- Explicit measured global array carriers: 0
- Explicit source-only global/data-layout carriers: 0
- Explicit host-only fallback globals: 0
- Explicit linker-folded shared common globals: 0
- Explicit oracle-proven global type overrides: 0

## Review queue

### `DrawShape_SubtractNFS4RectEdges__FR4RECT` (0x8004be00, drawshp.cpp:23, map=exact)

- Extra source locals: `linkWord`, `prevPrim`

### `Movie_SetDecodeOffset__Fssss` (0x8004c8b0, movie.cpp:169, map=exact)

- Extra source locals: `r0`, `r1`

### `Movie_NextFrame__Fv` (0x8004cb30, movie.cpp:251, map=exact)

- Extra source locals: `deadfrm`, `ret`

### `Movie_Play__Fc` (0x8004cce4, movie.cpp:322, map=exact)

- Extra source locals: `deadfrm`, `dispRect`

### `strSetDefDecEnv__FP6DECENV` (0x8004cf14, movie.cpp:410, map=exact)

- Extra source locals: `bottom`, `img`, `mh`, `top`, `vb0`, `vb1`

### `strCallback__Fv` (0x8004d038, movie.cpp:479, map=exact)

- Extra source locals: `deadfrm`, `rem`

### `strNext__FP6DECENV` (0x8004d3d4, movie.cpp:566, map=exact)

- Extra source locals: `bottom`, `mh`, `st`, `wp`, `wt`

### `strSync__FP6DECENVi` (0x8004d5dc, movie.cpp:653, map=exact)

- Extra source locals: `mode`, `viewOff`

### `FeDraw_SetABRMode__Fi` (0x8004d6d8, mmeffect.cpp:20, map=exact)

- Extra source locals: `linkWord`

### `InitializeSpinningCars__Fv` (0x8004d850, psxfront.cpp:114, map=exact)

- Extra source locals: `carObj`

### `DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii` (0x8004e264, psxfront.cpp:557, map=exact)

- Extra source locals: `addwm1`, `c3`, `ibp`, `texX`, `wsel`

### `DrawShapeExtended__FiiiiiiP18tDrawShapeExtended` (0x8004e678, psxfront.cpp:1016, map=exact)

- Extra source locals: `bright`

### `ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii` (0x8004e77c, psxfront.cpp:1102, map=exact)

- Extra source locals: `one`

### `ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended` (0x8004ea88, psxfront.cpp:1180, map=exact)

- Extra source locals: `bright`

### `PSXDrawSquare__Fiiiii` (0x8004ec44, psxfront.cpp:1242, map=exact)

- Extra source locals: `link`

### `PSXDrawGouraudSquare__Fiiiiiiii` (0x8004ecdc, psxfront.cpp:1283, map=exact)

- Extra source locals: `otWord`

### `iMCRD_DoFileLoad` (0x8004f7a4, memcard.c:470, map=exact)

- Extra source locals: `ch`

### `MCRD_handlecardevents` (0x8004fe80, memcard.c:752, map=exact)

- Extra source locals: `g`, `idx`, `t`

### `iMCRD_LoadCard` (0x80050344, memcard.c:1163, map=exact)

- Extra source locals: `size`

### `iMCRD_HandleError` (0x800504cc, memcard.c:1251, map=exact)

- Extra source locals: `failed`, `gmi`, `scratch_i`, `tmp_int`

### `ascii2sjis` (0x800506f0, memcard.c:1480, map=exact)

- Extra source locals: `base`, `pk`

### `sjis2ascii` (0x80050810, memcard.c:1564, map=exact)

- Extra source locals: `kind`

### `initmdec` (0x800508c0, mdec.cpp:20, map=exact)

- Extra source locals: `area`, `bufsize`, `stride`, `stripsize`

### `VIDEO_create__Fiiiii` (0x80050cc8, video.cpp:29, map=exact)

- Extra source locals: `hzp`

### `VIDEO_updateframexy__Fiii` (0x80051040, video.cpp:160, map=exact)

- Extra source locals: `result`

## Implicit aggregate special members

## Explicit SYM carrier/optimization mappings


## Explicit restored inline-local mappings


## Explicit compact static-local mappings


## Exact cross-build/canonical name recoveries


## Explicit restored macro-local mappings


## Explicit linkage-proven ABI parameters omitted from SYM


## Explicit source-only codegen carriers

- `DrawShape_SubtractNFS4RectEdges__FR4RECT`: `linkWord`, `prevPrim`
- `Movie_SetDecodeOffset__Fssss`: `r0`, `r1`
- `Movie_NextFrame__Fv`: `deadfrm`, `ret`
- `Movie_Play__Fc`: `deadfrm`, `dispRect`
- `strSetDefDecEnv__FP6DECENV`: `bottom`, `img`, `mh`, `top`, `vb0`, `vb1`
- `strCallback__Fv`: `deadfrm`, `rem`
- `strNext__FP6DECENV`: `bottom`, `mh`, `st`, `wp`, `wt`
- `strSync__FP6DECENVi`: `mode`, `viewOff`
- `FeDraw_SetABRMode__Fi`: `linkWord`
- `InitializeSpinningCars__Fv`: `carObj`
- `DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii`: `addwm1`, `c3`, `ibp`, `texX`, `wsel`
- `DrawShapeExtended__FiiiiiiP18tDrawShapeExtended`: `bright`
- `ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii`: `one`
- `ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended`: `bright`
- `PSXDrawSquare__Fiiiii`: `link`
- `PSXDrawGouraudSquare__Fiiiiiiii`: `otWord`
- `iMCRD_DoFileLoad`: `ch`
- `MCRD_handlecardevents`: `g`, `idx`, `t`
- `iMCRD_LoadCard`: `size`
- `iMCRD_HandleError`: `failed`, `gmi`, `scratch_i`, `tmp_int`
- `ascii2sjis`: `base`, `pk`
- `sjis2ascii`: `kind`
- `initmdec`: `area`, `bufsize`, `stride`, `stripsize`
- `VIDEO_create__Fiiiii`: `hzp`
- `VIDEO_updateframexy__Fiii`: `result`

## Explicit oracle-proven function type overrides

- `DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii`: `prim`

## Object-owned global/storage review

- `mdec.cpp` blob-backed definitions: `gMDECinfo`, `g_mdecdrawsyncfailed`
- `memcard.c` blob-backed definitions: `gMemCardInfo`
- `movie.cpp` blob-backed definitions: `download`, `fp`, `gPlayerNum`, `movie24bit`, `movieframes`, `movieheight`, `movienames`, `moviewidth`, `skip_all`, `user_exit`
- `psxfront.cpp` blob-backed definitions: `creditShapeFile`, `gCarObj`, `gFadeBrightness`, `gHelpShapes`, `titleScreenDisplayed`
- `psxfront.cpp:70` `STR_FRMT` @ 0x80052a54: type SYM `char*` vs source `char*[2]`
- `psxfront.cpp:73` `rendering3DEnvironmentInitialized` @ 0x80052a60: type SYM `char` vs source `char[8]`
