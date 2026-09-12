# P914 DrawW compiler/declaration evidence

The production baseline uses the project's explicit `-G4` override and has
35 PASS functions / 361 matching branches, but stores the two 8-byte tables
in the wrong `.data` section. Whole-TU `-G8` alone produces native section
sizes while exposing six source-declaration-dependent misses.

The verified native-shaped candidate combines:

- `Cars_gList[9]` and `Cars_gHumanRaceCarList[9]`, as the actual owner and
  primary SYM records 1fea01 / 1fea82 declare. DrawW's old `[2]` was wrong.
- `gSkidMarkPixmap[2]`, correcting its explicitly false `[1]` workaround.
- The type-compatible incomplete caller declaration
  `extern u_char (*Night_gWeatherLightingTable[])[256]`. The owner remains
  `[2]`; DrawW's surviving SYM does not preserve its caller-bound spelling.
  This choice is compatible and instruction-backed, not uniquely token-proven.
- The missing MATRIX identity diagonal entries and explicit zero initialization
  of existing `stackSpeedUpEnbabledFlag`, restoring native data values/order.
- The installed compiler's `-G8` behavior, not an arbitrary section attribute.

With these coupled changes, all 35 functions and 361 branches PASS; both
`.data` (1,776 bytes) and `.sdata` (36 bytes) are fully native ROM/CPE exact.
All 14 named storage objects preserve their native types and scope. Total
storage remains 1,812 bytes. No source body, helper, asm, volatile, padding
object or post-compiler instruction rewrite is introduced.

## Actual default and GCC mechanism

`compiler_default.json` records an additional test on the actual PsyQ
`C:/Temp/psq43/COMPILER/CC1PLPSX.EXE`: removing the `-G8` argument entirely,
with every other compiler argument unchanged, produces the **same whole
object** as explicit `-G8`:
`fe87477c85ae3b3ebc54955743cb7ce6ebcf2408a60a4b6f5affce0d6b95d80d`.
The assembler side retains the tested 8-byte setting in this diagnostic.

The primary GCC 2.8.1 source explains the result:

- `config/mips/mips.h:3934` defines `MIPS_DEFAULT_GVALUE` as 8.
- `mips.c:3401` selects that default when no `-G` is supplied.
- `mips.h:2793` uses the declaration's known size for `SYMBOL_REF_FLAG`.
- `mips.c:5714` onward chooses small data when the positive size fits the
  threshold; incomplete extern arrays do not satisfy that size condition.

The six G8-only misses were HIGH/LO_SUM-to-`la` changes on the old small
foreign declarations, not evidence that the true data belongs in `.data`.
Native Cars bounds `[9]` make those declarations correctly large. The
incomplete Night caller interface preserves native HIGH/LO materialization.

Native own-object sizes alone constrain a uniform threshold to `8 <= G < 24`.
They do not uniquely recover a historical command line. The independently
observed installed default, full native data and whole-TU code results make
8 the supported conventional setting; original flag/token spelling remains
explicitly unproved.

## Debug and remaining dependency

All 35 actual debug declaration/type/dimension/block/PC-label records and all
35 instruction-to-source-line partitions are unchanged. Four unassembled
`.g.s` differences are exact `lui/addiu` versus `la` spellings, not scope
changes; scope_receipt.json records them separately and machine-code checks
still apply. The candidate changes only three LO16 input words to preserve
native targets when the two tables move to their real `.sdata` section.

The USA regional consumer already fails current headers on six removed
DrawW compatibility-view families. A bounded native-field repair is underway
separately; no incomplete regional graph or invented replacement view may land.
No production or normal output was changed by these diagnostics.
