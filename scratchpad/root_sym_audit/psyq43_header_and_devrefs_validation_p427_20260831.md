# PsyQ 4.3 public-header and Devrefs validation

Date: 2026-08-31

## Authorities checked

- `C:\Temp\nfs4-clean\psyq43\PSX43\psx\include`: all 46 canonical
  PsyQ 4.3 headers.  These are the primary authority for public SDK identifier
  spellings, typedefs, return types, and parameter lists.
- `C:\Temp\PSYQ\psyq-430-doc\Devrefs`: all 18 PDFs / 3,330 pages were
  text-searched for the 16 unresolved syslib data spellings and their semantic
  roles.  Relevant `Libref.pdf` pages were also rendered and inspected.
- `C:\Temp\nfs4-clean\psyq43\extracted`: archive/member ownership and member
  identity remain authoritative for deciding whether an NFS4 routine or datum
  belongs to the same SDK object.

The precedence used in this round is therefore: retail SYM/raw layout for NFS4
ownership and address, extracted PsyQ object membership for library identity,
canonical headers for public source declarations, and Devrefs for documented
semantics.  A documented role is not treated as proof of an unpublished private
identifier.

## Public declarations restored

`recon/lib/syslib.h` contained many generated `void Function()` placeholders
even where the canonical release headers preserve the exact public interface.
Sixty-two public declarations are now restored from `libcd.h`, `libds.h`,
`libetc.h`, `libmcrd.h`, `libpad.h`, and `libsn.h`; the canonical `DslCB`
callback typedef is restored with them.  This covers exact return types and
parameter lists for the CD streaming/control APIs, callback control, memory-card
APIs, direct-pad entry points, and host-PC file services.

`MemCardInit` was the one declaration mismatch also present on an emitted
definition/caller surface:

- `LIBMCRD.c`: `void MemCardInit(int val)` -> canonical
  `void MemCardInit(long val)`;
- `frontend/psx/memcard.c`: erroneous `long` return -> canonical `void` return.

Both `int` and `long` are 32-bit in the PSX ABI, but the latter is the preserved
PsyQ source spelling.  Detailed gates remain byte exact:

- `MemCardInit`: PASS, 11 instructions;
- `MCRD_init`: PASS, 40 instructions.

`MemCardGetDirentry` and `MemCardFormat` declarations remain parked with their
functions at the user's request.  Callback declarators whose nested callback is
intentionally unprototyped in the canonical C headers (`OpenEvent`, `bsearch`,
`DecDCToutCallback`) and C-mode `FntPrint()` are not false residuals.

## Private-data boundary established

None of the 16 P425 private/unproven syslib data identifiers occurs by exact
spelling in the 46-header canonical tree or in text extracted from the complete
Devrefs PDF corpus:

`_first_save`, `_first_devname`, `D_80148AD4`, `D_80148AC4`, `_ds_word0`,
`_ds_word1`, `__ps_libinfo__`, `_cd_dir`, `_cd_pathtbl`, `_cd_secbuf`,
`_st_slot`, `D_8013EAD8`, `_gp1_shadow`, `_padIntRegs`, `_padSioRegs`, and
`_padVbExec`.

The manuals do provide useful semantic confirmation.  In particular,
`CdSearchFile` is documented as caching one directory at a time, consistent
with the reconstructed ISO9660 directory/path-table/sector-buffer storage, and
the public syntax confirms `CdlFILE *CdSearchFile(CdlFILE *fp, char *name)`.
`ResetGraph` is documented as an `int` API taking one `int mode`, consistent
with the canonical header and reconstructed libgpu driver.  Neither section
publishes private BSS names such as `_gp1_shadow` or the restore sub-packet at
`D_8013EAD8`; those names therefore remain explicit evidence gaps, not rename
candidates.

## Regression proof

- full build completed and linked;
- both relink lanes GREEN with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: 15,781 call relocations, zero undefined;
- TU-order audit: 521 objects, zero inversions;
- call-target audit: 466 units, zero proven wrong targets;
- phantom audit: 518/518 TUs compile, all 3,491 oracle names exactly owned,
  zero hidden phantoms and zero ownership gaps;
- unsafe-vtable-indexing and source-only text-move audits PASS.

Durable relink evidence:
`psyq43_header_declaration_relink_p427_20260831.json`.
