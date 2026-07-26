#!/bin/sh
# rtl_a5.sh <src.c> [extra cc1 flags...]  -> dumps RTL passes into scratchpad/rtl_a5/
# cwd must be worktree root.
set -e
SRC="$1"; shift
OUT=scratchpad/rtl_a5
rm -rf "$OUT"; mkdir -p "$OUT"
CPP="C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe"
CC1="C:/Temp/psq43/COMPILER/CC1PSX.EXE"
"$CPP" -nostdinc -undef -D__GNUC__=2 -D__OPTIMIZE__ -Dmips -D__mips__ -D__psx__ -DPSX \
  -Iinclude -Irecon "$SRC" -o "$OUT/t.i"
cd "$OUT"
"$CC1" -quiet -O2 -G4 -g1 -mgpOPT -fgnu-linker "$@" t.i -o t.s
ls
