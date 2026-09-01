# SYM data-only/object-member closure (P449)

## Object-level interpretation

The trusted SYM contains 519 paired `.obj` member spans.  A function census
alone is insufficient: 367 members have no Function-start record, comprising
4 objects with explicit typed data, 16 SLD assembly/line-only objects, and 347
compact/opaque library members.  The opaque group is not labeled data-only;
many are stripped code objects and require MAP/image/canonical-library proof.

The four directly typed no-function objects are source-owned exactly:

- `FEI.obj`: `FEI_gList[114]`, EXT array-of-struct, 912 bytes at `0x8011279C`.
- `aidebug.obj`: `grabValue` plus the static `gAIDebug_PosX/PosY` storage.
- `DrawDbg.obj`: `gSavePtr`.
- `FEColor.obj`: `kRGBVals[28]`, 112 bytes at `0x800516C8`.

## Compact data-only archive members

Exact name/address receipts were added at the owning definitions for PsyQ
members whose SYM type information survives only in the compact table:

- `TABLE.obj`: `DCL_DVLC`, `DCC_DVLC`, `CF_DVLC`, `CF2_DVLC`.
- `CSTBL.obj`: `rcossin_tbl`.
- `CTYPE0.obj`: `_ctype_`.
- `SNDEF.obj`: `_stacksize`, `_ramsize`.
- EAC `atantbl`, `asintbl`, `sintbl`, `fatantbl`, `isqrttbl`, and `vars`.

Canonical PsyQ `CTYPE.H` declares `extern char _ctype_[]`; the reconstruction
now defines `char _ctype_[129]` rather than `extern const unsigned char`.  The
canonical PsyQ 4.3 `CTYPE0.OBJ` independently confirms `_ctype_` is in `.data`.
Both `wildcard.c` functions remain PASS.

An exhaustive scan intersects all 173 NFS4-linked PsyQ members available in
the canonical 4.3 extraction.  Exactly four have zero `.text` and nonzero
storage: `SNDEF`, `TABLE`, `CSTBL`, and `CTYPE0`; all four are reconstructed
above.  There were zero SN-LNK parse failures.  See
`psyq43_data_only_members_p449_20260831.md`.

The relocation-free payload audit compares freshly built object sections
directly with `rom/nfs4-f.exe`.  All 11 admitted members pass with zero
differing bytes, including the complete `0x11000`-byte LIBPRESS table and the
`0x4000`-byte LIBGTE sine/cosine table.  See
`data_only_payloads_p449_20260831.md`.

## Front overlay reservation objects

`bigbuf.obj` is the `front.bin` overlay-space reservation mechanism.  The SYM
opcode-1 linker records `00010b` through `000151` prove the separately compiled
overlay exactly:

- `_front_obj = _front_org = 0x80010000`.
- `_front_objend = _front_orgend = 0x80054548`.
- `_front_size = 0x44548`, exactly end minus start.  Consequently the interval
  is `[0x80010000, 0x80054548)`; the end value is exclusive and is not storage
  owned by the last frontend object.

The member exports the zero-size `bigBuf` load-base label at `0x80010000`; it
does not own the 472 initialized bytes a decompiler infers before the next
public symbol.  Those bytes belong to frontend objects linked inside the
front.bin overlay.  The reconstruction keeps `bigBuf` as an unsized label
alias at `_front_obj`, not a fabricated C array.

`address.obj` owns two four-byte boundary words:

- `FrontStartAddress @ 0x80054D90` contains `0x80010000`.
- `FrontEndAddress @ 0x80054D94` contains `0x80054548`.

The assembly symbol size for `FrontEndAddress` was corrected from 16 bytes to
4 bytes so it no longer swallows the following object's `"SimpleMem"`
constant.  This is a label/ownership correction only; retail bytes and
addresses do not move.

## Regression proof

- Data-only payload audit: 11/11 members PASS, zero differing bytes.
- `wildcard.c`: 2/2 PASS after canonical `_ctype_` type restoration.
- `game/common`: `ai.cpp` 40/40, `aidelaycar.cpp` 3/3,
  `aiinit.cpp` 17/17, `ailife.cpp` 20/20 PASS.
- Relink both lanes after the address-label size correction: GREEN; real
  duplicates 0, hidden phantoms 0, unresolved relocations 0.
- Undefined-call audit: recon 15,781 calls / source 15,779 calls, undefined 0.

Detailed member ledger: `sym_object_member_census_p449_20260831.md`.
