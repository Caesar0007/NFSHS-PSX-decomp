# Canonical libpad data-owner restoration

Date: 2026-08-31

## Defect and owner evidence

`recon/syslib/psx/libpad/PAD.c` was a reconstruction-only data aggregator.
It could not represent an original archive member: `libpad` contains no
`PAD.obj`, while the real `libapi/PAD.c` already reconstructs
`libapi.lib(PAD.obj)`.

Canonical PsyQ 4.3 `INDEX.tsv` assigns the contiguous public PAD dispatch and
engine-state run, `_padFuncNextPort` through `_padFixResult`, to
`libpad.lib(PADMAIN.obj)`. Retail keeps the cached interrupt/SIO pointers and
VSync flag immediately after that run and PADMAIN exclusively operates them.
The same index assigns `_waitTime` and `_startTime` to
`libpad.lib(WAITRC2.obj)` in that order.

The 28 definitions are now in those two true owners. The synthetic libpad
`PAD.c`, its oracle stub, objdiff row, and linker collection entries are
removed.

## Matching proof

Every affected function remains detailed byte-exact. `PADMAIN.c` is 11/11
PASS:

- `_padSetVsyncParam` 11, `_padVbCallback1` 26, `_padVbCallback0` 91;
- `_padStartCom` 51, `_padStopCom` 17, `_padInitSioMode` 205;
- `_padSioMain` 50, `_padSioRW` 118, `_padSioRW2` 142;
- `_padClrIntSio0` 36 and `_padWaitRXready` 10 instructions.

`WAITRC2.c` remains 2/2 PASS: `setRC2wait` at 8 and `chkRC2wait` at 40
instructions.

## Data and project proof

`PADMAIN.c.o(.data)` is a single 108-byte block placed at retail
`0x80137C78`; direct comparison against `rom/nfs4-f.exe` is 108/108 bytes
exact. `WAITRC2.c.o(.bss)` is an eight-byte block containing `_waitTime` at
offset 0 and `_startTime` at offset 4, matching canonical ownership and retail
address order.

- Focused libpad board: seven canonical owners, all `SYM_UNTYPED`; no
  synthetic `PAD.c` row remains.
- Full p423 board: 463 TUs, 151 typed `OK`, 312 `SYM_UNTYPED`, and zero
  `OWNER_MAP`, `SOURCE_MERGE`, `SOURCE_SPLIT`, `DIFF`, or `COMPILE_FAIL`.
- Both relink lanes: GREEN, zero real duplicates and zero hidden phantoms.
- Fresh probe: text 958,017/979,772 bytes identical (97.78%), 250/454 placed
  code objects exact; data 148,576/151,363 bytes identical (98.16%), 214/249
  byte-compared data sections exact.

Durable evidence: `libpad_data_owner_p423_20260831.tsv`,
`sym_type_graph_board_p423_20260831.tsv`,
`libpad_data_owner_relink_p423_20260831.json`, and
`libpad_data_owner_link_probe_p423_20260831.json`.
