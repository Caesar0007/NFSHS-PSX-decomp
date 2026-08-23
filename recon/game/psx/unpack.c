/* game/psx/unpack.c -- RECONSTRUCTED (NFS4 PSX decompression dispatch)
 *   C TU: SLD source = C:\nfs4\GAME\PSX\UNPACK.C -> CC1PSX lane (methodology 3.25;
 *   migrated from unpack.cpp, task #90). Self-contained per C-lane convention.
 *   4 free fns: unpackz/unpack (decompress), unpacksizez/unpacksize (decompressed-size query).
 *   Reads the 2-byte magic (xxFB) and forwards to the eaclib EACPSXZ codec backends
 *   (unrefpack / unhuff / unbtree / getm). unpack & unpacksize are thin public wrappers.
 */

/* The retail TU's debug stream proves the shared PsyQ/EA platform include
 * surface even though this file directly uses only u_char. */
#define NFS4_PSYQ_WCHAR_TYPE u_long
#include "../../frontend/psx/ea_psx_types.h"
#undef NFS4_PSYQ_WCHAR_TYPE

/* eaclib EACPSXZ codec backends (EXT symbols; sigs from the call sites + SYM)
 *   RefPack  0x10FB/0x11FB/0x90FB/0x91FB
 *   Huffman  0x30FB/0x32FB/0x34FB
 *   BTree    0x46FB/0x47FB          */
extern long unrefpack(void *src, void *dst, int reverse);
extern long unhuff(void *src, void *dst, int reverse);
extern long unbtree(void *src, void *dst);  /* 2 args -- see recon/eaclib/psx/eacpsxz/unbtree.c
                                             * and its oracle (@0x800F55B4 never reads $a2). */
extern long getm(void *p, int n);           /* read n-byte big-endian field */

/* ---- unpackz  [UNPACK.C:59-101] SLD-VERIFIED ----
 * Oracle shape (w38): a RESULT FUNNEL (`len` in $a2, zeroed in the guard's delay
 * slot, one `addu $v0,$a2,$zero` at the single exit) + a real `switch` on the
 * masked magic byte -- gcc-2.8 lowers the 5 sparse cases to a BALANCED BINARY
 * SEARCH TREE (beq 0x32 / slti 0x33 pivot, then {0x10,0x30} and {0x34,0x46}),
 * which an if/else chain cannot produce.
 * BUGFIX (w38): the old guard read the magic through `*(char *)` and compared
 * against -5; `char` is UNSIGNED on this build (__CHAR_UNSIGNED__) so that test
 * was ALWAYS TRUE -- the 0xFB (the common) marker never matched.  Oracle uses
 * `lbu` + compare against 0xFB. */
long unpackz(void *src, void *dst)
{
  long len = 0;

  if ((((u_char *)src)[1] == 0xfb) || (((u_char *)src)[1] == 0x32)) {
    switch (*(u_char *)src & 0xfe) {
    case 0x10:
      len = unrefpack(src,dst,1);
      break;
    case 0x30:
    case 0x32:
    case 0x34:
      len = unhuff(src,dst,1);
      break;
    case 0x46:
      len = unbtree(src,dst);
      break;
    }
  }
  return len;
}

/* ---- unpack  [UNPACK.C:104-116] SLD-VERIFIED ---- */
long unpack(void *src, void *dst)
{
  return unpackz(src,dst);
}

/* ---- unpacksizez  [UNPACK.C:165-193] SLD-VERIFIED ---- */
long unpacksizez(void *src)
{
  long len = 0;

  if ((((u_char *)src)[1] == 0xfb) || (((u_char *)src)[1] == 0x32)) {
    if ((short)(*(u_char *)src & 0xfe) == 0x32) goto ok;
    if ((short)(*(u_char *)src & 0xfe) < 0x33) {
      if ((short)(*(u_char *)src & 0xfe) == 0x18) goto ok;
      if ((short)(*(u_char *)src & 0xfe) < 0x19) {
        if ((short)(*(u_char *)src & 0xfe) == 0x10) goto ok;
      } else {
        if ((short)(*(u_char *)src & 0xfe) == 0x30) goto ok;
      }
    } else {
      if ((short)(*(u_char *)src & 0xfe) == 0x46) goto ok;
      if ((short)(*(u_char *)src & 0xfe) < 0x47) {
        if ((short)(*(u_char *)src & 0xfe) == 0x34) goto ok;
      } else {
        if ((short)(*(u_char *)src & 0xfe) == 0x4a) goto ok;
      }
    }
    goto done;
  ok:
    len = getm((void *)((int)src + 2),3);
  }
done:
  return len;
}

/* ---- unpacksize  [UNPACK.C:196-208] SLD-VERIFIED ---- */
long unpacksize(void *src)
{
  return unpacksizez(src);
}

/* end of unpack.c */
