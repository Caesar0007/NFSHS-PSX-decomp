# EAC library dispatch/filter/resize cleanup (2026-08-28)

## Scope

- `recon/eaclib/psx/eacpsxz/nsync.c`
- `recon/eaclib/psx/eacpsxz/resize.c`
- `recon/eaclib/psx/eacpsxz/stream.c`

The linked library owners retain empty retail type graphs.

`resize.c` had two typedef-only aliases for incomplete `MemBlock` and
`MemClass` declarations. They were replaced throughout the prototypes and
local declarations with direct `struct MemBlock` / `struct MemClass`
spellings. No completed source-only record was introduced.

The other two records are necessary owner-local compiler carriers:

- `LoadArgs`: 16 bytes, `char *name@0`, then `int dest@4`, `memclass@8`, and
  `abortval@12`; its wrappers construct the stack record and its atomic workers
  consume the same member offsets.
- `StreamFilter`: 12 bytes, unsigned `mask@0`, `value@4`, and `consumer@8`;
  `filterchunk` walks the typed array and uses all three fields.

The audit accepts each carrier only as a complete owner/tag/typedef pair with
its exact size, member list, leaf types, and offsets. Any drift is visible; this
is not a name-only suppression. The pre-change audit tool is backed up by Git
commit `dee8eb82`.

## Matching and graph proof

Final matching was repeated after the edits:

- `nsync.c`: 10/10 PASS
- `resize.c`: 1/1 PASS
- `stream.c`: 32/32 PASS

All three focused p314 reports are `OK` with zero residual records. The
authoritative `project_type_graph_p315_20260828.tsv` reports:

- OK: 356
- DIFF: 61
- COMPILE_FAIL: 30
- OWNER_MAP: 11

Compared with p312, exactly these three owners changed `DIFF -> OK`; no other
owner changed status.

## Integrity proof

- both relink lanes GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols
- undefined calls: zero in both lanes
- proven wrong call targets: 0/460
- TU order: 513 owners, zero inversions
- no unsafe direct vtable-row indexing across 983 files
- no post-compiler text moves or branch retargets
- full phantom rebuild: 513/513 owners compiled, 3484/3484 oracle symbols
  exact-matched, zero hidden phantoms, and zero ownership/missing gaps

The rebuild emitted only the pre-existing optional `2.8.1-norcse` ladder-rung
warning; affected owners used their configured fallback compiler. It does not
affect these owners or the zero-gap result.
