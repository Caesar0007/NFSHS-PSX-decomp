# `TransformVector` SYM-exact static linkage (P767, 2026-09-02)

## Correction

Compact SYM records the file-static helper at `0x8003A8F0` as
`TransformVector__FRA4_iRA4_A4_iT0`.  The source-level name and reference-array
signature were already correct, but the declaration forced a shortened
assembler label:

```cpp
static void TransformVector(...) asm("TransformVector");
```

P767 removes that forcing and keeps an ordinary static C++ prototype.  GCC-v2
now emits local symbol `TransformVector__FRA4_iRA4_A4_iT0` naturally, size
`0xE4` bytes.  `configs/symbol_addrs.txt` uses the same retail-exact spelling.

## Verification

- detailed helper gate: PASS, 57 instructions;
- complete `screencarselect.cpp` gate: 59/59 PASS;
- branch audit: 59 functions checked, zero offset/count divergence;
- both relink lanes: GREEN, zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved names;
- P767 raw compact counts: opcode 6 exact-name+VA 149, VA-alias-only 36,
  absent-VA 187.

The historical oracle file is named `TransformVector.s`.  A narrow
`_ORACLE_FILE_STEMS` entry in `tools/verify_asm.py` maps the exact symbol to
that filename for diagnostics only.  The exact pre-change verifier is backed
up as `verify_asm.py.pre_transformvector_exact_p767_backup` (SHA-256
`D5E3837ADFBB718BEB3F65B449878DD9FD53158058898921BC6FF5E083EA2544`).

The directory-wide strict frontend audit still reports its pre-existing
deleting-destructor/header-inline review queue; this correction introduces no
new local/global/type/storage finding and does not claim that queue is closed.
