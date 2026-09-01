# P487: `mathnfs.cpp` absolute-value local cleanup

`Math_VectorLength`, `Math_VectorLength2`, and `Math_NormalizeVector` each
carried an extra reconstructed local named `absV`.  Their retail SYM scopes
record the complete arithmetic working set but no such declaration.

The three bodies now test `__builtin_abs(vx)` directly in the scaling-loop
condition.  The compiler retains the same transient value and register flow,
so the source-local artifact disappears without any matching carrier, asm,
volatile qualifier, or tool intervention.

## Proof

- `Math_VectorLength`: PASS, 103/103 instructions.
- `Math_VectorLength2`: PASS, 101/101 instructions.
- `Math_NormalizeVector`: PASS, 110/110 instructions.
- `tools/tugate.py recon/game/common/mathnfs.cpp`: 10/10 PASS.
- `tools/brdist.py recon/game/common/mathnfs.cpp`: 10 functions, 0
  branch-distance/count divergences.
- Strict SYM audit P487: 791 declaration-clean functions, 1509 extras, 0
  missing names, and 0 type or storage findings.  This is +3 clean and -3
  extras from P486.
- Strict global and vtable audits remain 547/547 and 115/115.
- `tools/relink.py --lane both -v`: GREEN, with no real duplicates, hidden
  phantoms, or unresolved relocations.
- Data-only payload audit: PASS, 11/11 members byte exact.
- `git diff --check`: no errors (repository line-ending warning only).

No commit or push was performed.
