# Game/common SYM cleanup P484

## Target

`Speech::LoadBankHeaders` (`0x800951BC`, `SPEECH.CPP:990-1102`).

The trusted SLD exposes three byte-reader inline regions and two four-character
suffix-predicate regions.  Retail caller locals are `data`, `offset`, `size`,
`id`, `dt`, `filecount`, `c`, `hdata`, `banknames`, loop `i/j`, `name`, and
`namelen`; nested debug quantities are `this`, `p`, and `a,b,c,d`.

## Source restoration

- restored the `.hdr` test through the P483-proven inline
  `Speech::IsHeader(a,b,c,d,'.','h','d')` member;
- added/restored the parallel `.dat` predicate as inline
  `Speech::IsData(a,b,c,d,'.','d','a')`;
- removed caller-only constant locals `h`, `hd`, `period`, `dc`, and `ac`;
- restored all three explicit byte-reader expansions from reconstruction name
  `cc` to retail SYM name `c`;
- restored the first row byte from `firstbyte` to retail name `a`;
- removed the second `extension` local by testing `IsData` directly;
- removed fallback-only `namep` and `joffset`: direct
  `banknames[j]`/`fBankOffset[j]` indexing with `++j` in the loop condition is
  instruction- and register-exact.

The initial file-count decoder remains explicitly expanded.  Replacing it with
the semantic `ReadBE32(header + 8)` member was tested in two statement orders;
both emitted 271/270 instructions and moved the first byte load into a retail
load-delay slot.  The exact expanded form remains, now with SYM names.

## Required codegen quantities

Seven source-only quantities have explicit receipts:

- `reserveArg`, `reserveCallArg`, `reserveBytes`, `alignment`, and `dataSize`
  are the existing tied allocator inputs that reproduce retail saved-register
  allocation and the `$v1` size web;
- `extension` and `isheader` are distinct retail compiler quantities.  Reusing
  `isheader` for the suffix result shortens the function to 266/270 and removes
  the retail `$s0` accepted-bank flag sequence.

## Audit movement

- declaration-clean functions: 730 -> 731;
- unexplained extra source locals: 1637 -> 1621;
- missing SYM names: 0;
- restored inline-local mappings: 37 -> 43;
- explicit source-only codegen carriers: 110 -> 117;
- function/type/storage findings: 0.

## Proof

- `tools/verify_asm.py`: `LoadBankHeaders` PASS 270/270;
- `tools/tugate.py recon/game/common/speech.cpp`: 102/102 PASS;
- `tools/brdist.py recon/game/common/speech.cpp`: 102 functions checked, zero
  branch-offset/count divergences;
- strict game/common audit: 1193/1193 functions mapped, 547/547 globals,
  115/115 vtables, zero missing names;
- `tools/relink.py --lane both -v`: GREEN; recon 757 objects and source 706
  objects, zero real duplicates, hidden phantoms, or unresolved relocations;
- data-only payload audit: PASS, 11/11 byte exact, including `vars.obj`;
- `git diff --check`: no errors (repository line-ending warnings only).

No commit or push was requested or performed.
