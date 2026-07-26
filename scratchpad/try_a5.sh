#!/bin/sh
# try_a5.sh <src.c> <fn>  -> gate + print allocno order/refs for <fn>
set -e
SRC="$1"; FN="$2"
python tools/verify_asm.py "$SRC" "$FN" 2>&1 | head -30
sh scratchpad/rtl_a5.sh "$SRC" -dg -dl >/dev/null 2>&1
S=$(grep -n "^;; Function $FN\$" scratchpad/rtl_a5/t.i.greg | cut -d: -f1)
sed -n "$((S+1)),$((S+3))p" scratchpad/rtl_a5/t.i.greg
awk "/^;; Function $FN\$/,/^;; Function .*\$/" scratchpad/rtl_a5/t.i.greg | grep -m1 -A3 "Register dispositions"
L=$(grep -n "^;; Function $FN\$" scratchpad/rtl_a5/t.i.lreg | cut -d: -f1)
sed -n "$((L)),$((L+40))p" scratchpad/rtl_a5/t.i.lreg | grep "used" | head -14
