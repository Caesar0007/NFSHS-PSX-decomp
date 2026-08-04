# Salvage from C:/Temp/nfs4-decomp-r3dcar-match (2026-08-04)

Fork branch `codex-r3dcar-match`: ALL commits already contained in origin/main
(the "Match ..." pushes merged during waves 45-48); fork HEAD is 151 commits
behind. Salvaged here before the fork is retired:

* `newton.s` + `vdiff_*.txt` -- the codex run's residual analysis of
  recon/game/common/newton.cpp (6 fns still below 100: AddDamageZone 96.08,
  CalcDistToClosestPlayerCar 87.78, CalculateGroundShadowMatrix 87.41,
  DoPostBarrierCollisionHandling 67.08, TestForUndrivableSurfaces 92.76,
  FindGroundElevationAndNormal 99.77). vdiff filenames = diff counts of probed
  variants; files are UTF-16. vdiff_carbound_651 / vdiff_indexed_650 are named
  spelling probes.

* The fork's stash (`WIP on w47-a3`: hoist `kon = 0` above the serve-hook call
  in slib.c iSNDserve) was ADJUDICATED at consolidation: 58 -> 74 diffs =
  FALSIFIED, do not retry. (Also note: the stash existed despite the stash
  ban -- it survived only because the fork was never pruned.)
