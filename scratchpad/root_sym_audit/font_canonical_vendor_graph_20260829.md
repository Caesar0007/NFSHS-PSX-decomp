# FONT canonical PsyQ vendor graph

Date: 2026-08-29

Pre-change source/tool backup: Git commit `93adfbcd`.

## Source restoration

`recon/syslib/psx/libgpu/FONT.c` now uses the private names recovered by the
matched Sony font implementation in
`C:/Temp/ps1-decomp-refs/psyz/decomp/src/libgpu/font.c`:

- `struct FntStream` is restored as `struct Font`;
- `maxchars`, `primbuf`, `textbuf`, `textlen`, and `autoupd` are restored as
  `capacity`, `sprites`, `buffer`, `written`, and `unwrap`;
- the synthetic `FntStream` typedef is removed;
- FntFlush's corresponding private locals are restored as `font`, `x`, `y`,
  `xscreen`, `max_y`, `sprt`, `max_x`, `unwrap`, `len`, `line_break`, `buf`,
  `ch2`, and `ch`.

The public anonymous `TILE`, `DR_MODE`, and `SPRT_8` typedef bodies already
match canonical PsyQ 4.3 `libgpu.h` member-for-member. Their sizes are 16, 12,
and 16 bytes. Together they fix the complete 48-byte `struct Font` layout used
by the retail instructions and the eight-element `Font` data object.

`FONT.OBJ` is a stripped vendor member and retains no owner-local type records
in NFS4.SYM. The audit therefore accepts its source graph only as one atomic
fingerprint: all four type blocks and all eight typedefs—including the used
`stdarg.h`/`stddef.h` aliases—must agree exactly. Any added, missing, renamed,
or reshaped record disables the classification and reports DIFF again.

## Compiler-input lane correction

The hash-validated `2.8.1-norcse` compiler is required for the exact Sony
FntFlush identity. The old lane compiled the full preprocessed TU and depended
on that instrumented compiler faulting only after it had flushed FntFlush's
assembler terminator while entering FntPrint. Canonical identifier restoration
changed heap timing and exposed that fragile assumption: the complete function
instructions were emitted, but the final assembler metadata was truncated.

`tools/build.py` now creates a structurally checked preprocessed input ending
immediately before the unique `extern int FntPrint(` definition and compiles
that one-function input normally. It requires exactly one `.ent FntFlush` and
one `.end FntFlush` before splicing the compiler-produced region. This is an
input-side per-function compiler lane; it performs no postcompile instruction
rewrite, text move, branch retarget, or metadata repair.

## Matching and type-graph proof

- With `NFS4_CC1_NORCSE` pointing to the hash-validated compiler,
  `python tools/tugate.py recon/syslib/psx/libgpu/FONT.c` reports 2/2 PASS on
  repeated runs.
- The same gate with `NFS4_SOURCE_ONLY=1` reports 2/2 PASS.
- Focused board `font_type_graph_sweep_p362_20260829.tsv`: OK.
- Full board `project_type_graph_p363_20260829.tsv`: 390 OK / 27 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP.
- Compared with p361, FONT is the only status transition: DIFF -> OK.

## Integrity gates

- Both relink lanes GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols.
- Undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned).
- Call-target audit: 0/460 proven wrong targets.
- TU order: 513 objects, zero inversions.
- Vtable indexing: 983 files, zero unsafe row-index sites.
- Text moves: none configured.
- Phantom audit with the intended compiler rung active: 513/513 TUs compile;
  3,484/3,484 oracle functions exact, zero hidden phantoms and zero ownership
  gaps.
