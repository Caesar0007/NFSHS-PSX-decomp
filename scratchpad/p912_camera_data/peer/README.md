# P912 Camera initializer peer review

GREEN for candidate source `393afbd6...` and object `6e2f9478...`.

The actual `camera_flags` definition agrees with native SYM1e05ee..1e06b0:
one 12-byte `coorddef arm` followed by the six original INT one-bit fields at
bits 96 through 101. Independent parsing of all 19 nested source initializers
and packing in that native field order reproduces all 304 ROM/CPE bytes.
The former flat initializers had 102 wrong bytes; these are real data fixes.

Native SYM1e97f0 identifies `Camera_gInfo[2]` as 544 bytes at 8010F2AC.
The complete native CPE loads those zero bytes. Ordinary explicit aggregate
zero initialization restores its emitted position before the initialized
tables, making all ten native cells and the full 1,404-byte source section exact.
This is a supported source form, not proof that the original author wrote the
same braces, literal values, or macro spelling. The candidate says this honestly.

Only the two initializers change code tokens. The complete function/body/tail
bytes are preserved. Re-running detailed verification on the frozen prebuilt
object gives 38 PASS functions and 382 exact branches. All 38 local, lexical and
SLD graphs were rechecked; all 204 data references retain their native cell and
interior addend. Seven changed code words are exclusively existing relocation
sites, with unchanged instruction opcode bits.

The copied clock-module caption and misleading initialized-storage BSS comments
are correctly replaced. No original source completion claim is warranted for
remaining Camera body/local/physical-line debt. No compilation, production edit,
normal-output write, or original receipt overwrite was performed here.

Details and input hashes: `initializer_peer_review.json`; read-only rechecks:
`review.py`. The full combined native link remains a separate proof.
