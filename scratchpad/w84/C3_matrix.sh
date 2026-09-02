#!/bin/sh
# W84-C3: rung x delayed-branch x split-address matrix for MemCardFormat.
# Prints, per cell: gate result + the two structural fingerprints
#   BNEZ-SLOT  = word in the bnez delay slot   (oracle: addiu v0,zero,1)
#   JAL-SLOT   = word in MemCardMakeDevname's slot (oracle: sw v1,%lo(...)($at))
cd "$(dirname "$0")/../.." || exit 1
OBJD=C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe
OBJ=build/scratchpad/w84/C3_LIBMCRD.c.o
SRC=scratchpad/w84/C3_LIBMCRD.c
fingerprint() {
  "$OBJD" -d -z "$OBJ" 2>/dev/null | awk '/^[0-9a-f]+ <MemCardFormat>:/{f=1;next} /^$/{f=0} f' > /tmp/c3fn.txt
  b=$(grep -A1 -m1 'bnez' /tmp/c3fn.txt | tail -1 | sed 's/.*\t//')
  j=$(grep -A1 -m1 'MemCardMakeDevname' /tmp/c3fn.txt | tail -1 | sed 's/.*\t//')
  n=$(grep -c '	' /tmp/c3fn.txt)
  echo "bnez-slot='$b'  jal-slot='$j'  n=$n"
}
for ver in "" 2.6.0 2.6.3 2.7.2-970404 2.7.2 2.8.0 2.8.1 2.8.1-sn; do
  for dbr in off on; do
    for spl in default nosplit; do
      if [ "$dbr" = on ]; then SK=PER_FN_FLAG_SPLICE_272,PER_FN_NO_DELAYED_BRANCH; else SK=; fi
      if [ "$spl" = nosplit ]; then EX=no_split_addresses=1; else EX=; fi
      out=$(NFS4_FORCE_CC1_ALT="$ver" C3_SKIP_TABLES="$SK" C3_TU_EXTRA="$EX" \
            python scratchpad/w84/C3_verify.py "$SRC" MemCardFormat 2>&1 | grep -E 'MemCardFormat:' )
      [ -z "$out" ] && out="  BUILD-ERROR"
      printf '%-14s dbr=%-3s %-8s %-42s %s\n' "${ver:-wired272}" "$dbr" "$spl" "$(echo "$out"|sed 's/^ *//')" "$(fingerprint)"
    done
  done
done
