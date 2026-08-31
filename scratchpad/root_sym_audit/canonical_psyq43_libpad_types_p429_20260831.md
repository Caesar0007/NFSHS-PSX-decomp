# Canonical PsyQ 4.3 libpad declaration and private-tail validation

Date: 2026-08-31

## Authorities joined

- Public source interface: `C:\Temp\nfs4-clean\psyq43\PSX43\psx\include\libpad.h`.
- Canonical member/storage identity:
  `C:\Temp\nfs4-clean\psyq43\extracted\LIBPAD\obj\PADMAIN.obj`.
- NFS4 ownership and addresses: retail SYM/SLD, raw executable layout, and the
  detailed reconstruction oracle.

The include tree is authoritative for public `Pad*` return/argument types. It
does not publish libpad's private file-scope storage identifiers.

## Source corrections

All eight NFS4 `PADENTRY.obj` public declarations now use the canonical PsyQ
4.3 signatures. In particular, this closes three decompiler/header defects:

- `PadSetActAlign` now takes `unsigned char *`, not `char *`;
- `PadSetMainMode` returns `int`, not `void`;
- `PadSetAct` and `PadStartCom` return `void`, not `int`.

The exact declarations are restored in the shared platform boundary and in
the `front`, `screencontroller`, and `force` consumer headers. The generated
syslib inventory now lists all eight PADENTRY declarations instead of leaving
five blank placeholders.

The internal `_padSetActAlign` carrier also represented the public buffer as
an integer. It now carries `unsigned char *` through the queued-command slots;
the two 32-bit stores are unchanged, but the source type and pointer intent are
no longer lost.

## Anonymous PADMAIN tail proof

Canonical `PADMAIN.obj` has an eight-byte anonymous library-info prefix. After
accounting for that prefix, its exported data and the NFS4 PADMAIN data block
have the same relative layout through the private tail. Canonical data words:

| canonical offset | word | interpretation |
| ---: | ---: | --- |
| 92 | `0x00000001` | `_padChanStop` |
| 96 | `0xFFFFFFFF` | `_padFixResult[0]` |
| 100 | `0xFFFFFFFF` | `_padFixResult[1]` |
| 104 | `0x1F801070` | interrupt-register base |
| 108 | `0x1F801040` | SIO0-register base |
| 112 | `0x00000000` | VBlank execution flag |

These map exactly to NFS4 object offsets `0x60`, `0x64`, and `0x68` after the
eight-byte prefix difference. This independently proves the three objects'
owner, order, initialized values, pointer/integer roles, and storage section.
Neither `libpad.h` nor the canonical object exports their private C spellings,
so `_padIntRegs`, `_padSioRegs`, and `_padVbExec` remain explicitly
underdetermined names rather than receiving speculative replacements.

## Matching and whole-tree proof

- all 8/8 PADENTRY functions remain detailed PASS;
- `_padSetActAlign` and `_padSetActAlign_snd` remain PASS at 26 and 7
  instructions;
- all direct consumers remain PASS: `front.cpp` 43/43,
  `screencontroller.cpp` 22/22, `mpause.cpp` 10/10, and `force.cpp` 9/9;
- the full build compiles and links;
- both relink lanes are GREEN with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- 15,781 call relocations contain zero undefined calls;
- 521 objects have zero TU-order inversions;
- 466 units contain zero proven wrong call targets;
- the exhaustive census compiles 518/518 TUs and exactly owns all 3,491 oracle
  names with zero hidden phantoms or ownership gaps.

The durable relink receipt is
`canonical_libpad_header_types_relink_p429_20260831.json`.
