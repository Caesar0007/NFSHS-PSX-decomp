# Game/common SYM cleanup P485

## Target

The complete `spchevnt.c` event-wrapper family: 53 byte-exact functions,
52 of which still carried the same two decompiler-only locals.

## Evidence and correction

Every affected retail SYM function records only:

- its named parameters;
- `long parms[12]` at stack offset `-0x38`;
- `long i` in the retail register selected for that wrapper.

The reconstructed bodies already declared `long i`, but left it unused and
instead performed the identical descending 12-slot zeroing loop through a
second `int iVar2`; they also declared an unused `long *plVar1`.  Both names
were decompiler artifacts and are absent from every corresponding SYM scope.

All 52 wrappers now use their existing retail `long i` directly:

```c
i = 0xb;
do {
  parms[i] = 0;
  i = i + -1;
} while (-1 < i);
```

`plVar1` and `iVar2` were removed throughout.  This is ordinary C, with no
fence, asm, volatile qualifier, or tool rewrite.

## Audit movement

- declaration-clean functions: 731 -> 783;
- unexplained extra source locals: 1621 -> 1517;
- missing SYM names: 0;
- function/type/storage findings: 0;
- no new carrier or ambiguity receipts were needed.

## Proof

- `tools/tugate.py recon/game/common/spchevnt.c`: 53/53 PASS;
- `tools/brdist.py recon/game/common/spchevnt.c`: 53 functions checked, zero
  branch-offset/count divergences;
- strict game/common audit: 1193/1193 functions mapped, 547/547 globals,
  115/115 vtables, zero missing names;
- `tools/relink.py --lane both -v`: GREEN; recon 757 objects and source 706
  objects, zero real duplicates, hidden phantoms, or unresolved relocations;
- data-only payload audit: PASS, 11/11 byte exact, including `vars.obj`;
- scoped `git diff --check`: no errors (repository line-ending warnings only).

No commit or push was requested or performed.
