/* game/psx/unpack.c -- RECONSTRUCTED (NFS4 PSX decompression dispatch)
 *   C TU: SLD source = C:\nfs4\GAME\PSX\UNPACK.C -> CC1PSX lane (methodology 3.25;
 *   migrated from unpack.cpp, task #90). Self-contained per C-lane convention.
 *   4 free fns: unpackz/unpack (decompress), unpacksizez/unpacksize (decompressed-size query).
 *   Reads the 2-byte magic (xxFB) and forwards to the eaclib EACPSXZ codec backends
 *   (unrefpack / unhuff / unbtree / getm). unpack & unpacksize are thin public wrappers.
 */

typedef unsigned char u_char;

/* eaclib EACPSXZ codec backends (EXT symbols; sigs from the call sites + SYM)
 *   RefPack  0x10FB/0x11FB/0x90FB/0x91FB
 *   Huffman  0x30FB/0x32FB/0x34FB
 *   BTree    0x46FB/0x47FB          */
extern long unrefpack(void *src, void *dst, int reverse);
extern long unhuff(void *src, void *dst, int reverse);
extern long unbtree(void *src, void *dst, int reverse);
extern long getm(void *p, int n);           /* read n-byte big-endian field */

/* ---- unpackz  [UNPACK.C:59-101] SLD-VERIFIED ---- */
long unpackz(void *src, void *dst)
{
  long len;
  u_char magic;

  if ((*(char *)((int)src + 1) != -5) && (*(char *)((int)src + 1) != '2')) {
    return 0;
  }
  magic = *(u_char *)src & 0xfe;
  if (magic != 0x32) {
    if (magic < 0x33) {
      if (magic == 0x10) {
        len = unrefpack(src,dst,1);
        return len;
      }
      if (magic != 0x30) {
        return 0;
      }
    }
    else if (magic != 0x34) {
      if (magic != 0x46) {
        return 0;
      }
      len = unbtree(src,dst,0);
      return len;
    }
  }
  len = unhuff(src,dst,1);
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
  long len;
  u_char magic;

  if ((*(char *)((int)src + 1) != -5) && (*(char *)((int)src + 1) != '2')) {
    return 0;
  }
  magic = *(u_char *)src & 0xfe;
  if (magic != 0x32) {
    if (magic < 0x33) {
      if (magic != 0x18) {
        if (magic < 0x19) {
          if (magic != 0x10) {
            return 0;
          }
        }
        else if (magic != 0x30) {
          return 0;
        }
      }
    }
    else if (magic != 0x46) {
      if (magic < 0x47) {
        if (magic != 0x34) {
          return 0;
        }
      }
      else if (magic != 0x4a) {
        return 0;
      }
    }
  }
  len = getm((void *)((int)src + 2),3);
  return len;
}

/* ---- unpacksize  [UNPACK.C:196-208] SLD-VERIFIED ---- */
long unpacksize(void *src)
{
  return unpacksizez(src);
}

/* end of unpack.c */
