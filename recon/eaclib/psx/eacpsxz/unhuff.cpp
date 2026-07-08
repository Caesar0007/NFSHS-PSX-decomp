/* eaclib/psx/eacpsxz/unhuff.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** COMPLETE ***
 *   obj nfs4\eaclib\psx\unhuff.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3).  4 fns:
 *     unhuff  @0x800F459C (3108 B) -- EA "Huff" canonical-Huffman decompressor (the heaviest fn in the lib)
 *     memcpyl @0x800F51C0          -- word-at-a-time copy (rounded to 4) via geti/puti
 *     memcpyb @0x800F5234          -- byte-at-a-time copy
 *     refcpy  @0x800F5254          -- LZ back-reference copy (shared with unref's RefPack decoder)
 *
 *   unhuff: an MSB-first 32-bit bit reader (refilled 16 bits at a time from a byte stream) drives a
 *   canonical-Huffman tree rebuild + an 8-bit fast-prefix decode table, then the main loop emits literals /
 *   repeat-runs, finishing with the optional 0x32FB (1st-order) / 0x34FB (2nd-order) delta post-filters.
 *   SOURCE: literal transcription of Ghidra nfs4-f.exe.c (its decode is structurally correct) with ONLY:
 *     (1) the 3 Ghidra-split stack tables merged into the contiguous arrays the code indexes across --
 *         firstcode[17] (= auStack_470[8]+uStack_450+local_44c[7]; the `firstcode[maxlen]` sentinel + the
 *         `&firstcode[8]` walk both rely on contiguity), lenbyprefix[256] (= local_230[4]+local_22c[63]),
 *         seen[256] (= local_130[4]+local_12c[63]);
 *     (2) CONCAT byte-assembly at the header expanded to explicit big-endian byte shifts;
 *     (3) the Ghidra `__thiscall this` 1st arg restored to the real `comp` param (IDA: (uchar*,uint,int));
 *     (4) 1:1 local renames (no merging of distinct Ghidra locals; bc/bc2 keep Ghidra's iVar17/iVar18 split).
 *   Every operator/shift/constant is copied verbatim.  Caveat: verified by compile + Ghidra-ism scan + disasm
 *   structure; a compress/decompress round-trip is still recommended before trusting it at runtime.
 *   Plain C -> extern "C".
 */
extern "C" unsigned int   geti(void *p, char nbits);                          /* getm */
extern "C" void           puti(unsigned char *buf, unsigned int val, int n);  /* textcrnt */
extern "C" void          *memset(void *s, int c, unsigned int n);             /* syslib C43 */

extern "C" int            unhuff(unsigned char *comp, unsigned char *out, int doDecode); /* @0x800F459C */
extern "C" char          *memcpyl(char *dst, char *src, int n);                          /* @0x800F51C0 */
extern "C" unsigned int   memcpyb(unsigned char *dst, unsigned char *src, int n);        /* @0x800F5234 */
extern "C" unsigned char *refcpy(unsigned char *dst, unsigned int dist, int len);        /* @0x800F5254 */

/* unhuff @0x800F459C : MOVED to unhuff.c (SEALED) -- eacpsxz.lib(unhuff.obj) is a C module
 * compiled with CC1PSX; see unhuff.c for the full provenance breadcrumb. */

/* memcpyl @0x800F51C0 : copy `n` bytes (rounded up to 4) word-at-a-time via geti/puti.  Returns dst+n.
 * The oracle advances src ($s2) PER ITERATION -- `addiu s2,s2,4` sits in the loop-back bgtz DELAY SLOT
 * (runs every pass); the last (post-exit) advance is functionally dead but present in the code.  Writing
 * `src += 4` INSIDE the loop reproduces the delay-slot fill + the s2(src)/s3(end) register choice. */
extern "C" char *memcpyl(char *dst, char *src, int n)
{
    char *end = dst + n;
    do {
        unsigned int val = geti(src, 4);   /* @0x800F51E8 a0=src (s2) each iteration */
        puti((unsigned char *)dst, val, 4);
        dst = dst + 4;
        n   = n - 4;
        src = src + 4;                     /* @0x800F5210: in the bgtz delay slot (per-iter) */
    } while (0 < n);
    return end;
}

/* memcpyb @0x800F5234 : copy `n` bytes one at a time.  Returns the last byte copied.
 * MATCH: return type unsigned int + local unsigned int -- `unsigned char last` triggers
 * an `andi v0,v0,255` mask on the return (oracle has nop there).  lbu already gives 0-255. */
extern "C" unsigned int memcpyb(unsigned char *dst, unsigned char *src, int n)
{
    unsigned int last;
    do {
        last = *src;
        src  = src + 1;
        n    = n - 1;
        *dst = (unsigned char)last;
        dst  = dst + 1;
    } while (n != 0);
    return last;
}

/* refcpy @0x800F5254 : LZ back-reference copy -- `len` bytes from `dist` bytes behind `dst`.  Returns dst+len.
 *   dist==1 is a run (memset of dst[-1]); dist 2..3 overlap byte-copy; dist>=4 word-copy. */
extern "C" unsigned char *refcpy(unsigned char *dst, unsigned int dist, int len)
{
    unsigned char *end;
    if (dist < 4) {
        end = dst + len;
        if (dist == 1)
            memset(dst, dst[-1], (unsigned int)len);
        else
            memcpyb(dst, dst - dist, len);
    } else {
        end = (unsigned char *)memcpyl((char *)dst, (char *)(dst - dist), len);
    }
    return end;
}
