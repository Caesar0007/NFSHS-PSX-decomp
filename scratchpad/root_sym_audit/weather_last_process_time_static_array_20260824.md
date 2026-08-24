# `Weather_gLastProcessTime` static-array restoration — 2026-08-24

## Reliable evidence

The trusted Weather.obj record is `class STAT type ARY INT size 8 dims 1 2`
for `Weather_gLastProcessTime` at `0x8013DE54`.  Retail constant-index stores in
`Weather_Init` and `Weather_Restart` are one-instruction GP-relative accesses to
the two words, while `Weather_DoWeather` constructs an absolute base for its
runtime index.

The previous exact reconstruction represented the two words as external scalar
definitions plus an unsized array view.  Although those declarations aliased
one storage region, they contradicted the reliable file-static array record and
required the project's only explicit game/PSX global-storage override.

## Source correction

The owning definition is now exactly one file-static array:

```cpp
static int Weather_gLastProcessTime[2] __attribute__((section(".sbss")));
```

The explicit small-BSS placement is the compiler-native storage control that
reproduces retail's mixed access forms under the reconstruction's `-G4` build.
Constant `[0]` and `[1]` stores compile as GP-relative accesses even though the
whole object is eight bytes.  The existing unsized asm-label array view aliases
the same symbol for the runtime-index site and remains absolute.  There is one
real object, no element duplication, and no post-compile rewriting.

An attempted pair of assembler `.set` subobject aliases was rejected: maspsx
resolved those aliases before small-data classification and expanded the
constant stores as absolute pairs (Weather_Init FAIL 30, Weather_Restart FAIL
6).  That experiment was fully removed.

## Verification

- `Weather_Init`: PASS, 211/211 instructions.
- `Weather_Restart`: PASS, 31/31 instructions.
- `Weather_DoWeather`: PASS, 197/197 instructions.
- Full Weather.cpp debug type graph: `OK`; 68/68 named records exact and both
  anonymous records covered.
- Strict game/PSX declaration/storage audit: 395/395 declaration-clean, zero
  function type overrides, zero global storage overrides, zero global type
  findings; extra global carrier count decreases 55 -> 54 and measured global
  array carriers 12 -> 11.
- Full game/PSX board remains 385/395 PASS with zero compile failures.
- Both relink lanes: GREEN; real duplicates 0, hidden phantoms 0, genuine
  relocation-referenced unresolved names 0.
- Vtable indexing audit: PASS across 926 files.
- Production link succeeds at 1,239,008 bytes versus retail 1,239,040 bytes;
  the unrelated newly landed `fetourn.cpp` int-to-enum warning remains the only
  skipped reconstruction TU, and the legacy `-32` layout delta is unchanged.
