#!/bin/sh
# w46-a10 — rebuild the INSTRUMENTED gcc-2.8.1 cross-cc1 from scratch.
#
#   sh build_cc1.sh [elf|ecoff]         (default: elf)
#
# Produces  scratch/gccbuild[-ecoff]/cc1.exe
#
# HOST TOOLCHAIN (this machine, verified): MinGW-W64 gcc 15.2.0 from
#   .../WinGet/Packages/BrechtSanders.WinLibs.../mingw64/bin  + mingw32-make.
#   WSL is NOT installed; msys64 has no usr/bin/gcc.
#
# GOTCHAS (all previously paid for, encoded here):
#  * CC must be overridden to "gcc -std=gnu89 -w": gcc 15 defaults to C23 and
#    rejects K&R implicit-int throughout the 2.8.1 sources.
#  * obstack.h uses cast-as-lvalue (`*((T*)p)++ = v`), rejected since gcc 4.x —
#    apply_traces.py rewrites the 5 offending macros.
#  * A new `static` helper needs a PROTO forward decl above its first USE, else
#    "static declaration follows non-static" (K&R implicit decl).
#  * At RUN time cc1 needs TMPDIR/TMP/TEMP as Windows paths WITH A TRAILING
#    BACKSLASH, or it dies `\/ctaNNNNN: No such file or directory` and writes
#    EMPTY dump files.
#  * cc1 names its dump files after the INPUT path -> copy the .i into your own
#    scratch dir per probe, or you silently clobber a shared TU's .greg/.lreg.
set -e

TARGETKIND=${1:-elf}
case "$TARGETKIND" in
  elf)   TGT=mipsel-unknown-elf   ; BDIR=gccbuild ;;
  ecoff) TGT=mipsel-unknown-ecoff ; BDIR=gccbuild-ecoff ;;
  *) echo "usage: $0 [elf|ecoff]"; exit 1 ;;
esac

HERE=$(cd "$(dirname "$0")" && pwd)
SCRATCH=$(cd "$HERE/.." && pwd)
SRC="$SCRATCH/gccsrc/gcc-2.8.1"
TARBALL=/c/Temp/gcc-2.8.1-src/gcc281.tar.gz

# gcc/mingw32-make are already on PATH via the WinLibs WinGet package; add it
# explicitly if a future shell drops it:
MINGW=$(ls -d /c/Users/*/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs*/mingw64/bin 2>/dev/null | head -1)
[ -n "$MINGW" ] && export PATH="$MINGW:$PATH"

if [ ! -d "$SRC" ]; then
  echo "== extracting $TARBALL"
  mkdir -p "$SCRATCH/gccsrc"
  ( cd "$SCRATCH/gccsrc" && tar xzf "$TARBALL" )
  chmod -R u+w "$SRC"
fi

echo "== applying instrumentation"
python "$HERE/apply_traces.py" "$SRC"

echo "== configure ($TGT)"
mkdir -p "$SCRATCH/$BDIR"
cd "$SCRATCH/$BDIR"
if [ ! -f Makefile ]; then
  # 🔴 MUST invoke configure through a RELATIVE path.  An absolute msys path
  # ("/c/Temp/...") is baked into the Makefile as srcdir and mingw32-make (a
  # native Windows make) then reports
  #   "No rule to make target '/c/Temp/.../Makefile.in'".
  CC="gcc -std=gnu89 -w" ../gccsrc/gcc-2.8.1/configure \
      --target=$TGT --host=i686-pc-mingw32 --build=i686-pc-mingw32 \
      --prefix="./inst"
fi

echo "== make cc1"
mingw32-make CC="gcc -std=gnu89 -w" CFLAGS="-O1 -w -std=gnu89" LANGUAGES="c" cc1

ls -l cc1.exe
echo "== OK: $SCRATCH/$BDIR/cc1.exe"
