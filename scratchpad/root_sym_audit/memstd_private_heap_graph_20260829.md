# EACPSXZ memstd private heap graph (2026-08-29)

## Evidence and source restoration

`recon/eaclib/psx/eacpsxz/memstd.c` is a stripped EA library owner: retail SYM
retains its FILE/XDEF ownership but no private type rows. The raw PSX oracle
nevertheless fixes the allocator graph tightly across thirteen exact bodies.
A block has a 16-byte physical header and overlays two free-list links on its
payload, while each 64-byte class embeds the 24-byte free-ring sentinel at
offset `0x10`.

The reconstruction previously represented that embedded sentinel as an
opaque `char[0x18]` and addressed its members with byte casts. It is now the
real nested `MemBlock freehead`; `FREE_find`, `FREE_findlargest`, and
`FREE_add` take its address directly; and class initialization uses typed
`magic`, `size`, `freenext`, and `freeprev` members. All thirteen functions
remain byte-exact.

The matched NFS2 PC beta EA allocator independently confirms the library's
block/class vocabulary, but it is an older allocator with a different layout.
Therefore it does not prove the exact capitalization/spelling of the private
PSX tags `MemBlock` and `MemClass`. Their complete layouts, nesting, member
roles, offsets, dimensions, pointer relationships, and behavior are proven;
the two tag spellings remain conventional names because the linked PSX owner
contains no recoverable spelling evidence. This limit is explicit rather than
silently promoted to an original-name claim.

The audit filters this stripped-owner graph only when both complete tag/typedef
pairs match the exact 24-byte and 64-byte definitions. Any owner, tag, typedef,
member, leaf type, recursive pointer, nested tag, offset, dimension, or size
drift remains a failure. The pre-change source/tool backup is Git commit
`7561d4f3`.

## Matching and SYM proof

- `memstd.c`: 13/13 PASS;
- focused `memstd_type_graph_p344_20260829.tsv`: OK, zero residual records;
- full `project_type_graph_p345_20260829.tsv`: 379 OK / 38 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP;
- compared with p343, exactly `memstd.c` changed `DIFF -> OK`; all other
  status rows are unchanged.

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
