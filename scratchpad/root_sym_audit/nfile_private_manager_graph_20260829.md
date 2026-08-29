# EACPSXZ nfile private manager graph (2026-08-29)

## Evidence and source restoration

`recon/eaclib/psx/eacpsxz/nfile.c` belongs to the stripped EA library member
`..\eaclib\psx\eacpsxz.lib(nfile.obj)`: retail SYM retains its FILE/XDEF
ownership but no completed private type or typedef records. The raw PSX oracle
fixes the complete manager graph across twenty-seven bodies: operation slots
are `0x30` bytes, open-file handles are `0x4c` bytes, and the singleton manager
is `0x30` bytes with exact pointers to both arrays, the active operation, the
pending queue, and the BIG-device list.

The reconstruction also carried a TU-local `size_t` typedef solely to route
32-bit pointer/integer casts through an intermediate spelling. It was not a
retail declaration and appeared as a fourth source-only typedef. The alias and
all redundant cast steps are now removed; direct target-width casts preserve
the detailed result of every function.

The NFS2 PC beta uses a different async/file layer and contains no compatible
operation-manager implementation. The NFS3 PC implementation independently
confirms the later `FileOp` vocabulary, but has a different `0x118`-byte
operation record and its reconstructed private header does not prove the PSX
source spelling. Thus the exact capitalization/spelling of `FileOp`,
`FileHandle`, `FileMgr`, and private multipurpose member names cannot be
recovered from retained debug data. Their sizes, layouts, offsets, recursive
queue relationship, storage, field roles, and behavior are proven; the names
remain conventional. This limitation is explicit rather than silently
presented as original-name proof.

The audit filters these stripped-owner types only when all three completed
tag/typedef pairs match the exact definitions from `recon/lib/nfile.h`. Any
owner, tag, typedef, member, leaf type, offset, dimension, recursive pointer,
or size drift remains a failure. The pre-change source/tool backup is Git
commit `75b712a9`.

## Matching and SYM proof

- `nfile.c`: 26/27 PASS before and after the cleanup;
- the sole residual remains the pre-existing two-instruction
  `FILE_completeop` prologue scheduling mismatch;
- focused `nfile_type_graph_p348_20260829.tsv`: OK, zero residual records;
- full `project_type_graph_p349_20260829.tsv`: 381 OK / 36 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP;
- compared with p347, exactly `nfile.c` changed `DIFF -> OK`; every other
  semantic status/detail row is unchanged. The known compiler failures differ
  only in generated temporary filenames.

## Integrity proof

- both relink lanes GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined calls: zero in both lanes (15,782 reconstruction and 15,779 source
  call relocations scanned);
- proven wrong call targets: 0/460;
- TU order: 513 owners, zero inversions;
- no unsafe direct vtable-row indexing across 983 files;
- no post-compiler text moves or branch retargets;
- full phantom rebuild: 513/513 owners compiled, 3484/3484 oracle symbols
  exact-matched, zero hidden phantoms, and zero ownership/missing gaps.

The only rebuild warning is the pre-existing unavailable optional
`2.8.1-norcse` rung, unrelated to this owner.
