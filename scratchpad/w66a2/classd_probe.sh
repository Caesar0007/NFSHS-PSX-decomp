#!/bin/sh
# w66-a2: does the opt-in --nop-before-label close any OTHER open class-d row?
# (control vs flag-on brdist, maspsx-lane TUs only; 272-lane TUs ignore it)
cd /c/Temp/nfs4-decomp || exit 1
for tu in recon/frontend/common/fememcard.cpp \
          recon/frontend/common/fescreen.cpp \
          recon/frontend/common/screencarselect.cpp \
          recon/frontend/common/screenmain.cpp \
          recon/frontend/psx/memcard.c \
          recon/game/psx/hud.cpp ; do
  echo "=== $tu CONTROL"
  python scratchpad/w66a2/pr.py brd "$tu" 2>/dev/null | grep -v '^# pr.py'
  echo "=== $tu FLAG-ON"
  W66_MASPSX_FLAGS=--nop-before-label python scratchpad/w66a2/pr.py brd "$tu" 2>/dev/null | grep -v '^# pr.py'
done
