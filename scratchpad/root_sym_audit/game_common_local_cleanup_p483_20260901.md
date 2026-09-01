# Game/common SYM cleanup P483

## Target

`Speech::CalculateBankSize` (`0x80094FA8`, `SPEECH.CPP:931-984`).

The trusted SLD records three inline regions at caller lines 15, 22, and 33.
The first reads the BIG directory file count, the second expands twice for the
row offset and size, and the third tests the filename suffix.  Their debug
surfaces are `Speech *this`, pointer `p` where it survives, and integer
quantities `a`, `b`, `c`, and `d`.

## Source restoration

- moved the byte-wise big-endian reader from a file-static reconstruction
  helper to inline member `Speech::ReadBE32(char *p)`;
- restored the three call sites as member operations;
- restored the four-character suffix predicate as inline member
  `Speech::IsHeader(a,b,c,d,'.','h','d')`;
- removed reconstruction-only caller locals `period`, `h`, `hd`, `cc`, and
  `extension`;
- replaced the earlier incorrect optimized-`p` explanation with explicit SLD
  inline-expansion receipts.  Fully inlined helper spellings remain inferred;
  the receiver, local names, operations, expansion count, and generated code
  are independently proven.

The useful negative controls were:

- a direct four-argument predicate changed saved-register allocation, emitted
  132 instructions, and produced 33 diffs;
- retaining only caller `period` plus a direct predicate still emitted 132
  instructions;
- passing the three comparison constants through the fully inlined member
  restores retail constant lifetimes and the exact 133-instruction stream,
  without caller-only names.

## Audit movement

- declaration-clean functions: 729 -> 730;
- unexplained extra source locals: 1642 -> 1637;
- missing SYM names: 0;
- restored inline-local mappings: 28 -> 37;
- explicit optimization/carrier mappings: 16 -> 15 (the old `p` receipt was
  replaced by the actual inline source object);
- function/type/storage findings: 0.

## Proof

- `tools/verify_asm.py`: `CalculateBankSize` PASS 133/133;
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
