#!/usr/bin/env bash
# w66-a1 acceptance sweep: every touched TU, gate + brdist, TWICE, with the
# FINAL row list.  $1 = "base" for the control run (no spec) or "spec".
set -u
cd /c/Temp/nfs4-decomp
TUS="recon/syslib/psx/libpad/PADSEQD.c recon/syslib/psx/libmcrd/LIBMCRD.c recon/frontend/common/screenmain.cpp recon/game/psx/hud.cpp recon/frontend/psx/memcard.c recon/game/common/sim.cpp"
if [ "$1" = "base" ]; then unset W66_SPEC; else export W66_SPEC=scratchpad/w66a1/SPEC_w66a1_ALL.json; fi
for pass in 1 2; do
  echo "########## PASS $pass ($1)"
  for tu in $TUS; do
    echo "--- $tu"
    python scratchpad/w66a1/br.py tu  "$tu" 2>&1 | grep -v NO.ORACLE
    python scratchpad/w66a1/br.py brd "$tu" 2>&1 | tail -n +1 | grep -E "offset diffs|BRANCH COUNT|fns checked"
  done
done
