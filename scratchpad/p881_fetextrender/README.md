# P881 FETextRender scalar view cleanup

Retained only in fetextrender.cpp: remove the gSemiTransText_arr int-array asm
override, using the existing native bool scalar for its two reads and one write.
The real textDefinitions[14][6] array is unchanged; its stale file-header comment
was corrected to agree with the source and native dimensions.

Native SYM522963 is EXT BOOL gSemiTransText at8005160C. Record52293b separately
describes textDefinitions as ARY ARY CHAR,84 bytes,14 rows by6 columns. SetABR
retains its native abr INT and trans BOOL parameters. No scalar/array inference
is based merely on an old matching comment.

## Verification

- Whole TU17/17 PASS; zero branch-offset/count divergence.
- Exact debug twins: FullTextRGB93, WordWrapTextRGBJustify285, SetABR9.
- All388 affected oracle comment words (including padding) equal raw rom/nfs4-f.exe.
- The entire88-byte initialized data section equals raw800515B8 onward.
- Actual same-source-path before/after8080-byte ELF objects are identical:
  fc573287922a2dc9949dd2cc97b5d714612ba489c1ea87a6a07c9e3fb0a62260.

Thus all code/data bytes, symbols, relocations and references are preserved,
not merely normalized instruction matches. baseline.cpp is the source backup;
build/p881/original_fetextrender.cpp.o is the pre-edit object.

## Related local: still open

WordWrap native block521f79 contains short x, ushort index1/index2 and the
recorded buffers/spacing, but no pixels local. Two bounded source-only probes
after scalar restoration did not resolve it: collapsing the width into native
x gives64diff at289/285 with a branch-count mismatch; reusing the existing size
parameter gives22diff at285/285 and the wrong register lifetime. Neither probe
entered production. The existing pixels carrier remains honestly visible for
later original-source work; there is no claim of an unmatchable compiler limit.

No new identifiers, asm, volatile, helpers, header/tool edits, or instruction
rewrites. Parent handles commits. receipts.json contains all experimental rows.
