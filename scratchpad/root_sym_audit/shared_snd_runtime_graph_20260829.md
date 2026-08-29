# Shared PSX sound-runtime graph

Date: 2026-08-29

Pre-change tool backup: Git commit `1cef9e31`.

## Classification

`span.c`, `sstsetpr.c`, and `svol.c` all consume the shared private runtime
types from `recon/lib/snd.h`. Their stripped SNDPSXZ archive members retain no
private type records, so the owner-local SYM comparison previously reported
the five header types as extras even though the source graph is required by
the retail field accesses.

The audit now locks one complete shared graph at its actual GCC debug owner,
`snd.h`: `SndVoice` (100 bytes), `SndBank` (12), `SndFxBus` (16),
`SndPlayDef` (20), and `SndState` (188). Every member name, leaf type, offset,
padding array, nested tag, and array bound is part of the immutable check.
Only the three current TUs include this header. Any source drift remains a
failure.

The PSX instruction/field sweep proves the sizes and offsets. Because the
owners are stripped and no cross-version debug graph preserves the private
identifiers, exact private tag and placeholder-field spellings remain
unprovable; this receipt records that limit rather than presenting them as
SYM-proven names.

## Evidence

- Detailed matching: `span.c` 1/1 PASS; `sstsetpr.c` 1/1 PASS; `svol.c` 2/2
  PASS.
- Focused type graphs `span_type_graph_p356_20260829.tsv`,
  `sstsetpr_type_graph_p356_20260829.tsv`, and
  `svol_type_graph_p356_20260829.tsv`: all OK.
- Full type graph `project_type_graph_p357_20260829.tsv`: 387 OK / 30 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP.
- Compared with p355, exactly these three owners move DIFF -> OK.
- Both relink lanes GREEN; zero real duplicates, hidden phantoms, and
  reloc-referenced unresolved symbols.
- Undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned).
- Call-target audit: 0/460 proven wrong targets.
- TU order: 513 objects, zero inversions.
- Vtable indexing: 983 files, zero unsafe row-index sites.
- Text moves: none configured.
- Phantom audit: 513/513 TUs compile; 3,484/3,484 oracle functions exact,
  zero hidden phantoms and zero ownership gaps.
