# Canonical PsyQ `FIRST.obj` private-owner restoration

Date: 2026-08-31

## Authorities joined

- canonical PsyQ 4.3 member
  `C:\Temp\nfs4-clean\psyq43\extracted\LIBAPI\obj\FIRST.obj`;
- canonical PsyQ 4.3 `libapi.h` declaration;
- NFS4 retail assembly and detailed `tools\verify_asm.py` gates;
- independent PsyQ FIRST-unit storage evidence from the Vagrant Story and
  Chrono Cross decompilation trees.

## Restored source surface

The canonical member exports only `firstfile`. The reconstruction now uses its
canonical interface:

```c
struct DIRENTRY *firstfile(char *name, struct DIRENTRY *dir);
```

`struct DIRENTRY` and the BIOS `firstfile2` declaration now use the canonical
PsyQ field and argument types. The second retail function remains file-local;
`_first_patch` is retained only as a zero-code local oracle alias so the
detailed verifier can address the retail symbol without falsely exporting it
from the source unit.

The member's 48-byte BSS is now ordinary local C storage with exact offsets:

- saved handler pointer at offset `0x00`;
- the independently observed unused word at offset `0x04`;
- the 40-byte device-name buffer at offset `0x08`.

Neither the canonical object nor the retail SYM retains private spellings for
these objects, so address-based placeholders are used instead of presenting
older reconstruction-era semantic names as original source evidence. The
buffer keeps an unsized code-generation view while its actual definition
records the proven 40-byte extent.

## Matching and repository proof

- `firstfile`: detailed PASS, 103 instructions;
- local `_first_patch` oracle alias: detailed PASS, 64 instructions;
- all six functions in the adjacent ISO9660 owner remain detailed PASS;
- both relink lanes GREEN, with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- recon/source undefined-call audits scan 15,781/15,779 call relocations with
  zero calls to undefined symbols;
- 521 objects have zero TU-order inversions;
- 466 units have zero proven wrong call targets;
- vtable indexing passes all 1,017 scanned files;
- exhaustive ownership audit compiles 518/518 TUs and exactly owns all 3,491
  oracle names, with zero hidden phantoms or ownership gaps.

Durable machine-readable evidence:
`psyq_iso9660_first_relink_p432_20260831.json`,
`psyq_iso9660_first_undef_recon_p432_20260831.json`, and
`psyq_iso9660_first_undef_src_p432_20260831.json`.
