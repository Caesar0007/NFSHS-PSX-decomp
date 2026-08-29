# SPRINTF stripped-vendor type graph

Date: 2026-08-29

Pre-change source/tool backup: Git commit `964ae078`.

## Classification

The linked PsyQ `SPRINTF.OBJ` is stripped: its NFS4.SYM owner contains no
canonical type records. That absence is not evidence that the original Sony C
source had no types. The stronger source/object evidence is:

- `C:/Temp/nfs4-clean/psyq43/extracted/LIBC/functions/sprintf.bin` is the
  shipped PsyQ 4.3 implementation. The existing object-identity trace compares
  all 548 words with the retail function: 514 are raw-identical, the other 34
  differ only in relocated fields, and the relocation-masked difference is
  zero.
- The matched PsyQ reconstruction in
  `C:/Temp/ps1-decomp-refs/sotn-decomp/src/main/psxsdk/libc/sprintf.c`
  recovers the same `bool` enum and complete 12-byte `printf_info` layout.
- The current NFS4 source retains a `char *` `va_list`, matching its measured
  read-before-advance argument cursor. Its anonymous 12-byte struct/word union
  is a code-generation carrier for the three-word template copy; it does not
  claim a recoverable private retail identifier.

The audit now accepts this stripped owner only as one complete fingerprint.
Eligibility requires exactly three blocks—the two-member `bool` enum, the
eleven-member `printf_info`, and the anonymous struct/word union—and exactly
three typedefs (`bool`, `va_list`, and `printf_info`). Every kind, tag, member,
bit offset, byte offset, size, and array bound is locked. A partial or altered
graph becomes visible as a DIFF again.

No reconstructed source or function body changed in this round.

## Matching and type-graph proof

- `python tools/tugate.py recon/syslib/psx/libc/SPRINTF.c`: unchanged at
  25 detailed diffs with exact 545/545 instruction parity.
- Focused canonical report `sprintf_type_graph_p360_20260829.tsv`: zero
  residual source or retail graph rows after the exact stripped-owner filter.
- Focused project sweep `sprintf_type_graph_sweep_p360_20260829.tsv`: OK.
- Full board `project_type_graph_p361_20260829.tsv`: 389 OK / 28 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP.
- Compared with p359, `SPRINTF.c` is the only status transition: DIFF -> OK.

## Integrity gates

- Both relink lanes GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols.
- Undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned).
- Call-target audit: 0/460 proven wrong targets.
- TU order: 513 objects, zero inversions.
- Vtable indexing: 983 files, zero unsafe row-index sites.
- Text moves: none configured.
- Phantom audit: 513/513 TUs compile; 3,484/3,484 oracle functions exact,
  zero hidden phantoms and zero ownership gaps.

The phantom audit emitted the pre-existing warning that the optional
`2.8.1-norcse` ladder rung is unavailable and `FONT.c` therefore uses its TU
compiler fallback. This does not affect SPRINTF or the zero-gap result.
