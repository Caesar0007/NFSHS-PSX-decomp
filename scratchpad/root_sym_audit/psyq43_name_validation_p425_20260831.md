# Canonical PsyQ 4.3 syslib name validation

Date: 2026-08-31

## Authority boundary

`C:\Temp\nfs4-clean\psyq43\extracted\INDEX.tsv` is treated as canonical for
public PsyQ 4.3 archive-member names. It is not used to rename NFS4-private or
version-specific routines merely because their spelling is absent. A different
name would require same-member identity, an instruction-identical canonical
body, or independent retail SYM evidence.

The extracted SN-LNK objects do not retain local/debug function names: 1,661
of 1,662 objects parsed successfully and contained zero named 0x40/0x42 debug
records; the lone `LIBSN/CACHE.obj` parser exception does not intersect the
NFS4-private candidate set. Consequently, the kit can validate public names
but cannot manufacture the lost spelling of stripped static helpers.

## Function results

All 400 retail syslib function rows were joined to a canonical library/member:

- 293 use the exact PsyQ 4.3 name in the same archive member;
- one (`__SN_ENTRY_POINT`) is an exact canonical SDK name from another
  standalone member;
- 105 are NFS4-version/private labels absent from both the 4.3 public catalog
  and retail SYM; none has a unique instruction-identical 4.3 replacement;
- one oracle key, `CD_init_80108140`, was the canonical same-member function
  `CD_init` obscured by an NTFS filename collision with eaclib's `CD_Init`.

The reconstructed `LIBCD/BIOS.obj` function is now source-visible as
`CD_init`, exactly as both retail SYM and PsyQ 4.3 spell it. A zero-code
co-equal `CD_init_80108140` symbol remains solely for the oracle filename and
address table. Both reconstruction and source objects emit the two names at
the same text offset.

## Data results

All 78 global data symbols emitted by reconstructed syslib TUs were checked:

- 62 are exact names in the same canonical PsyQ member;
- 16 are private/unattributed storage names for which the 4.3 public index and
  retail SYM provide no replacement spelling.

No speculative data rename was made.

## Matching and link proof

- `CD_init_80108140`: PASS, 120 instructions.
- `_cd_event_init`: PASS, 15 instructions.
- `CdReset`: PASS, 27 instructions.
- Undefined-call audit: 15,781 call relocations, zero undefined.
- Both relink lanes: GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols.
- Source-only text-move audit and unsafe-vtable-indexing audit both PASS.

Durable evidence:
`psyq43_function_name_validation_p425_20260831.tsv`,
`psyq43_data_name_validation_p425_20260831.tsv`, and
`psyq43_name_validation_relink_p425_20260831.json`.
