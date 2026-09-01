# P486: `trgsfx.cpp` local-declaration cleanup

Five one-local SYM residuals in `recon/game/common/trgsfx.cpp` were removed
without changing retail code generation:

- `TrgSfx_AddEnviroEffect`: reuse the masked `obj` parameter instead of the
  decompiler-introduced `c` local.
- `TrgSfx_AddCarSfx`: reuse the masked `car` parameter instead of `c`.
- `TrgSfx_AddCarExtraCheck`: reuse the masked `car` parameter instead of `c`.
- `TrgSfx_CrashCar`: test `random() & 0xf` directly instead of preserving the
  single-use `rnd` temporary.
- `TrgSfx_AddSkidmark`: restore the conditional-result form
  `temp = temp > 0xff ? 0xff : temp`, eliminating the extra `shade` local while
  retaining the retail register schedule.

The AddSkidmark source shape is instruction-sensitive.  Two superficially
equivalent clamp forms produced 311/313, while spelling `MIN(temp, 0xff)` in
this compilation lane produced 325/313 and the wrong frame.  Those negative
controls were rejected.  The retained explicit conditional is 313/313 exact
and requires neither `volatile` nor assembly.

## Proof

- `tools/tugate.py recon/game/common/trgsfx.cpp`: 11/11 PASS.
- `tools/brdist.py recon/game/common/trgsfx.cpp`: 11 functions, 0 branch-distance
  divergences.
- Strict SYM audit P486: 788 declaration-clean functions, 1512 extras, 0
  missing locals, 0 type/storage discrepancies.  This is +5 clean and -5
  extras from P485.
- Strict global audit remains 547/547; vtable audit remains 115/115.
- `tools/relink.py --lane both -v`: GREEN, with 0 real duplicates, 0 hidden
  phantoms, and 0 unresolved relocations in both lanes.
- `audit_data_only_payloads.py`: PASS, all 11 audited members byte exact.
- `git diff --check`: no errors (only existing line-ending warnings).

No commit or push was performed in this round.
