# Stripped LIBMATH carrier graphs (2026-08-28)

## Scope

- `ADDDF3.c`
- `DIVDF3.c`
- `GTDF2.c`
- `LTDF2.c`
- `MULDF3.c`
- `TRUDFSF2.c`

These are Sony prebuilt LIBMATH archive members. Their linked NFS4 SYM owners
retain no type records, while their already byte-matched sources require the
runtime's anonymous word-pair, union, and mantissa carriers.

## Source evidence and audit rule

`C:/Temp/gcc-2.8.1-src/extracted2/gcc-2.8.1/floatlib.c` contains the real
`union double_long`: a `double` overlaid with two 32-bit words. The matched
sources use that same representation. ADDDF3, DIVDF3, and MULDF3 additionally
use the exact two-word `mant_pair`; ADDDF3 has one exact anonymous local return
union (`double` over `int[2]`).

The audit does not accept these types by name. For each exact `/libmath/<owner>`
path it compares the entire anonymous block and typedef multisets, including:

- block kind and size
- every member name, leaf type, offset, dimension, and nested anonymous tag
- exact typedef name, kind, size, and anonymous-tag relationship
- owner-specific record counts, including ADDDF3's additional local union

Only when the complete multiset is exact is the stripped runtime graph removed
from the source-extra comparison. Any drift leaves the entire owner visible.
Both the standalone audit and project sweep use the same filter pipeline. The
pre-change tool backup is Git commit `b73d0a38`.

## Matching proof

- `ADDDF3.c`: 1/1 PASS
- `DIVDF3.c`: 2/2 PASS
- `GTDF2.c`: 1/1 PASS
- `LTDF2.c`: 1/1 PASS
- `MULDF3.c`: 2/2 PASS
- `TRUDFSF2.c`: 1/1 PASS

All eight functions were repeated after the final audit state.

## SYM graph proof

All six focused p329 reports are `OK` with zero residual records. The complete
`project_type_graph_p330_20260828.tsv` sweep over 458 audited units reports:

- OK: 372
- DIFF: 45
- COMPILE_FAIL: 30
- OWNER_MAP: 11

Compared row-for-row with p326, exactly these six owners changed `DIFF -> OK`;
no other owner changed status.

## Integrity scope

This checkpoint changes only the two audit scripts and their evidence reports;
no reconstructed source, build configuration, object, or post-compiler step is
changed. The immediately preceding `b73d0a38` full integrity result therefore
remains code-identical: both relink lanes green, zero undefined calls, 0/460
wrong call targets, zero TU-order inversions, vtable/text-move gates green, and
the 513/513-owner phantom rebuild with 3484/3484 exact oracle symbols and zero
gaps. The complete debug sweep and all eight focused matching gates were rerun
for this checkpoint.
