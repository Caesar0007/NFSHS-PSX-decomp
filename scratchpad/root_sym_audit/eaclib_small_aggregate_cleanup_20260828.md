# EAC library small aggregate cleanup (2026-08-28)

## Scope

- `recon/eaclib/psx/eacpsxz/matrix.c`
- `recon/eaclib/psx/eacpsxz/trnsfrm.c`
- `recon/eaclib/psx/sndpsxz/sdmemlu.c`

These linked EA library members retain empty retail type graphs.

`sdmemlu.c` used `SndSpuEnt` only to cast the address of a packed pair of
unsigned shorts; it never accessed a member. The source-only typedef and its
anonymous body were removed, and the macro now exposes the exact underlying
`unsigned short *` type.

The other two aggregates are necessary compiler carriers:

- `matrix.c` requires a 36-byte `mtx` structure assignment to produce the
  retail movstrsi block-copy loops. Its exact body is one `int m[9]` member.
- `trnsfrm.c` requires its final 12-byte `TransformResult` structure assignment.
  Replacing it with `int result[3]` and three scalar stores produced a 12-diff
  function, so that failed experiment was reverted. Its exact body is three
  consecutive ints named `x`, `y`, and `z`.

The audit accepts those two anonymous bodies only when the matching typedef,
compiler tag, owner, size, complete member list, leaf types, and offsets agree.
This is not a generic name suppression. The pre-change audit tool is backed up
by Git commit `c1385fa4`.

## Matching proof

Each owner was checked twice after the final source/tool state:

- `matrix.c`: 4/4 PASS on both runs
- `trnsfrm.c`: 1/1 PASS on both runs
- `sdmemlu.c`: 1/1 PASS on both runs

## SYM graph proof

The three focused p309 reports are all `OK`, with zero unmatched named,
anonymous, or typedef records. The authoritative whole-project p310 report is
`project_type_graph_p310_20260828.tsv`:

- OK: 351
- DIFF: 66
- COMPILE_FAIL: 30
- OWNER_MAP: 11

Compared with p307, exactly the three owners above changed `DIFF -> OK`; no
other owner changed status.

## Integrity proof

- both relink lanes GREEN, with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols
- zero calls to undefined symbols in either lane
- zero proven wrong call targets across 460 audited units
- 513 owners with zero TU-order inversions
- no unsafe direct vtable-row indexing across 983 files
- no post-compiler text moves or branch retargets
- full phantom rebuild: 513/513 owners compiled, 3484/3484 oracle symbols
  exact-matched, zero hidden phantoms, and zero ownership/missing gaps

The full rebuild emitted only the pre-existing warning that the optional
`2.8.1-norcse` ladder rung is unavailable and affected owners fall back to
their configured compiler. It does not affect these owners or the zero-gap
result.
