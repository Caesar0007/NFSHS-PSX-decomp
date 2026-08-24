# Register-asm local audit closure (2026-08-24)

The strict game/common source audit previously reported the reliable
`Stats_TrackEndGame` locals `PlayerPosition` and `DesiredSlice` as missing.
Both declarations were already present in the exact reconstruction:

```cpp
register int PlayerPosition asm("$21");
register int DesiredSlice asm("$23");
```

Universal Ctags 6.x omits that GCC declaration form, so the findings were parser
false negatives rather than source defects. The tracked read-only audit now has
a narrow fallback for single function-local declarations ending in a literal
MIPS hard-register annotation. It binds each recovered declaration only to the
unique ctags function range containing its source line.

SYM-owned hard-register locals remain ordinary matched declarations. Names with
the same syntax but no SYM record are reported separately as explicit
reconstruction codegen carriers; in `Stats_TrackEndGame` these are `raceIndex`,
`sliceCar`, and `sliceTotal`.

Fresh strict game/common results:

- all 1,193 SYM functions map to source definitions;
- missing reliable SYM local names: 0 (previously 2);
- all 547 SYM-owned globals map to source definitions;
- missing globals: 0;
- function/global storage findings: 0/0;
- `Stats_TrackEndGame__Fv` remains PASS at 232/232 instructions;
- no reconstructed source file was changed by this audit correction.

The script change is source-audit-only. It does not rewrite, patch, or otherwise
modify compiler output; the preceding git revision is its recoverable backup.
