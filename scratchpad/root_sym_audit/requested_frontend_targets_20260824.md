# Requested frontend target audit

Date: 2026-08-24

## `FeAudio_InitViv`

SYM gives `fname` as register-parameter `char *`, `vivHandle` as register
`int`, `lumpHead` as an automatic 16-byte `LUMPYHEAD`, and `bigfileHeader` as
register `LUMPYHEAD *`.  The current source has exactly those four declarations
and no additional local.  The function is PASS at 109 instructions and the
complete `feaudio.cpp` TU is 10/10 PASS.  No source edit was warranted.

## `tScreenMemcard::DrawBackground`

The separately recorded MIN/MAX restoration removed one non-SYM temporary
while preserving PASS at 410 instructions and 15/15 TU status.  Remaining
non-SYM geometry carriers and the owner's monolithic type surface stay open.

## `tGlobalMenuDefs::tGlobalMenuDefs`

The current user-edited constructor is the only far residual in
`frontend/common`: 872 diffs, 3,223 reconstructed instructions versus 3,207
retail.  Its first current divergence is an allocation/scheduling split near
instruction 1,227: retail completes the `-1` load/store before the following
address calculations, while the reconstruction schedules those calculations
first and rotates the subsequent temporary registers.

Natural constant spellings and casts were neutral at the former 874 baseline.
Statement-expression forms were substantially worse, and callback
cast/spacing/unsigned/hex probes were also neutral.  A zero-instruction
immediate-only scheduling boundary after `menuTrackRecords.VertHelp = 1`
reduced 874 to 872 without changing the 3,223-instruction reconstruction; two
function gates and two complete 65/66 TU gates reproduced the result.  The live
user brace edit remains intact.  The target remains explicit backlog rather
than being mislabeled as fixed.
