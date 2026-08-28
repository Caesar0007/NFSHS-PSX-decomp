# Callback-only library typedef cleanup (2026-08-28)

## Scope

- `recon/eaclib/psx/spchpsxz/spchpick.c`
- `recon/syslib/psx/libpad/PADSEQD.c`

Both retail owners have empty SYM type graphs. The local callback typedef names
were therefore source-only inventions rather than recoverable retail type
records. They were replaced with direct function-pointer declarations and
casts, without changing the callback signatures or generated code.

No audit rule, suppression, post-link rewrite, or binary artifact was changed.

## Matching proof

Each translation unit was checked twice after the source edit:

- `spchpick.c`: 27/27 PASS on both runs.
- `PADSEQD.c`: 5/5 PASS on both runs.

## Project type-graph proof

The authoritative project sweep is stored in
`project_type_graph_p305_20260828.tsv`:

- OK: 345
- DIFF: 72
- COMPILE_FAIL: 30
- OWNER_MAP: 11

Compared with p304, exactly two owners changed status and no owner regressed:

- `spchpick.c`: DIFF -> OK
- `PADSEQD.c`: DIFF -> OK

## Integrity gates

- `relink.py --lane both`: GREEN; zero real duplicates, hidden phantoms,
  or relocation-referenced unresolved symbols in either lane.
- `undefcall_audit.py`: zero undefined calls in both recon and src lanes.
- `calltarget_audit.py`: 0/460 proven wrong-call-target sites.
- `tu_order_audit.py`: 513 owners, zero inversions.
- `audit_vtable_indexing.py`: PASS across 983 files.
- `textmoves_audit.py`: PASS; no post-compiler text moves or retargets.
- Full `phantom_audit.py` rebuild: 513/513 owners compiled, 3484/3484
  oracle symbols exact-matched, zero hidden phantoms, and zero ownership or
  missing gaps.

The phantom audit emitted the pre-existing warning that the optional
`2.8.1-norcse` ladder rung is unavailable. It fell back to each affected TU's
configured compiler; this does not affect either owner changed here or the
zero-gap/zero-phantom result.
