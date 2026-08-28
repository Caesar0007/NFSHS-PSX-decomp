# EACPSXZ nasync private request graph (2026-08-29)

## Evidence and source restoration

`recon/eaclib/psx/eacpsxz/nasync.c` belongs to the stripped EA library member
`..\eaclib\psx\eacpsxz.lib(nasync.obj)`: retail SYM retains its FILE/XDEF
ownership but no completed private type or typedef records. The raw PSX oracle
nevertheless fixes the complete graph across twenty-three byte-exact bodies.
Each request is `0x2c` bytes, has the recursive queue link at `+0x04`, and the
two FIFOs are exact `{head, tail}` pairs over request pointers.

The reconstruction had also introduced a TU-local `size_t` typedef solely to
route 32-bit pointer/integer casts through a host-sized spelling. It was not a
retail declaration and appeared as a third source-only typedef. The alias and
all of its redundant cast steps are now removed; the target's direct 32-bit
casts generate the same instructions in every affected function.

The matched NFS2 PC beta async library independently confirms EA's
request/queue vocabulary (`ASYNC_REQUEST`, `ASYNC_QUEUE`), but its layout and
API differ and its private names are not retained by NFS2 SYM either. It cannot
prove the exact capitalization or spelling of the NFS4 PSX tags `AsyncReq` and
`AsyncQueue`. Their complete sizes, members, offsets, recursive pointer
relationship, storage, queue roles, and behavior are proven; the two tag
spellings remain conventional names because the linked PSX owner contains no
recoverable spelling evidence. This limitation is recorded explicitly rather
than silently promoted to an original-name claim.

The audit filters this stripped-owner graph only when both completed
tag/typedef pairs match the exact 44-byte request and 8-byte FIFO definitions
from `recon/lib/nasync.h`. Any owner, tag, typedef, member, leaf type, offset,
dimension, recursive pointer, or size drift remains a failure. The pre-change
source/tool backup is Git commit `62734041`.

## Matching and SYM proof

- `nasync.c`: 23/23 PASS before and after the cleanup;
- focused `nasync_type_graph_p346_20260829.tsv`: OK, zero residual records;
- full `project_type_graph_p347_20260829.tsv`: 380 OK / 37 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP;
- compared with p345, exactly `nasync.c` changed `DIFF -> OK`; every other
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
