#!/bin/sh
# w46-a10 — compare our instrumented cc1 (ELF and/or ECOFF config) against the
# REAL PsyQ CC1PSX on the same preprocessed .i, function by function.
#
#   sh cmp_cc1.sh <tu.i> [Gvalue]
#
# Prints per-function IDENTICAL / DIFFERS and a summary count.
# 🔴 copies the .i into a per-config scratch dir first — cc1 names its dump
# files after the INPUT path, so a shared .i gets its .greg/.lreg clobbered.
set -e
I=$1
G=${2:-4}
HERE=$(cd "$(dirname "$0")" && pwd)
SC=$(cd "$HERE/.." && pwd)
CC1PSX="C:/Temp/psq43/COMPILER/CC1PSX.EXE"
BASE=$(basename "$I" .i)

run () {   # run <tag> <cc1-exe>
  tag=$1; exe=$2
  d="$HERE/cmp/$tag"; mkdir -p "$d" "$HERE/tmp"
  cp "$I" "$d/$BASE.i"
  TMPDIR='C:\Temp\nfs4-wt46-a10\scratch\instr\tmp\' \
  TMP='C:\Temp\nfs4-wt46-a10\scratch\instr\tmp\' \
  TEMP='C:\Temp\nfs4-wt46-a10\scratch\instr\tmp\' \
  "$exe" -quiet -O2 -G$G "$d/$BASE.i" -o "$d/$BASE.s" 2>"$d/$BASE.err" || true
}

run psyq  "$CC1PSX"
run elf   "$SC/gccbuild/cc1.exe"
run ecoff "$SC/gccbuild-ecoff/cc1.exe"

python "$HERE/cmp_fns.py" "$HERE/cmp/psyq/$BASE.s" \
       "$HERE/cmp/elf/$BASE.s" "$HERE/cmp/ecoff/$BASE.s"
