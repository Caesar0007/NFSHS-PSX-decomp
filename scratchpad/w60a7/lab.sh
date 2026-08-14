#!/bin/sh
# w60-a7 instrumented-cc1plus lab driver.
#   sh lab.sh <recon/path/tu.cpp> <Gvalue> [FN-substring]
# 1. cpp -> .i via tools/rtl_dump.py's exact recipe (build.py flags)
# 2. real CC1PLPSX  -> lab/psyq/<tu>.s
# 3. instrumented cc1plus-ecoff (near-oracle flags) -> lab/ecoff/<tu>.s + trace
# Prints the per-function IDENTICAL/DIFFERS verdict for the named fn.
set -e
TU=$1
G=${2:-4}
ROOT=/c/Temp/nfs4-decomp
LAB=$ROOT/scratchpad/w60a7/lab
INSTR=/c/Temp/nfs4-instr-cc1
CC1PL="C:/Temp/psq43/COMPILER/CC1PLPSX.EXE"
BASE=$(basename "$TU" .cpp)

mkdir -p "$LAB/psyq" "$LAB/ecoff" "$LAB/tmp"
# .i is produced by rtl_dump (which mirrors build.py's cpp invocation exactly)
cp "$ROOT/scratch/rtl/$BASE.i" "$LAB/psyq/$BASE.i"
cp "$ROOT/scratch/rtl/$BASE.i" "$LAB/ecoff/$BASE.i"

WT='C:\Temp\nfs4-decomp\scratchpad\w60a7\lab\tmp\'

( cd "$LAB/psyq" && TMPDIR="$WT" TMP="$WT" TEMP="$WT" \
    "$CC1PL" -quiet -O2 -G$G "$BASE.i" -o "$BASE.s" 2>"$BASE.err" || true )

( cd "$LAB/ecoff" && TMPDIR="$WT" TMP="$WT" TEMP="$WT" GCC_TRACE_ALLOC=1 \
    "$INSTR/cc1plus-ecoff.exe" -quiet -O2 -G$G -mgas -msplit-addresses \
    -funsigned-char -fno-exceptions -fno-rtti -dl -dg \
    "$BASE.i" -o "$BASE.s" 2>"$BASE.trace" || true )

echo "psyq  .s: $(wc -l < "$LAB/psyq/$BASE.s") lines"
echo "ecoff .s: $(wc -l < "$LAB/ecoff/$BASE.s") lines"
echo "trace   : $(wc -l < "$LAB/ecoff/$BASE.trace") lines"
