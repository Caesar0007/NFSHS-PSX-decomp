#!/bin/sh
# refs_a5.sh <src> <fn> : gate + allocno order + per-pseudo refs/live
SRC="$1"; FN="$2"
python tools/verify_asm.py "$SRC" "$FN" 2>&1 | grep -E "PASS|FAIL"
sh scratchpad/rtl_a5.sh "$SRC" -dg -dl >/dev/null 2>&1
awk -v f=";; Function $FN" '$0==f{p=1} p&&/regs to allocate/{print; exit}' scratchpad/rtl_a5/t.i.greg
awk -v f=";; Function $FN" '$0==f{p=1;next} p&&/^;; Function /{exit} p&&/^Register .* used/{print}' scratchpad/rtl_a5/t.i.lreg | head -16
awk -v f=";; Function $FN" '$0==f{p=1;next} p&&/^;; Function /{exit} p&&/^;; Register dispositions/{d=1} d&&/^[0-9]/{print} d&&/^$/{if(seen)exit; seen=1}' scratchpad/rtl_a5/t.i.greg | head -8
