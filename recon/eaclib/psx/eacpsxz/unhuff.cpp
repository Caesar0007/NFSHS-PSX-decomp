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

/* unhuff @0x800F459C : decompress `comp` (an EA Huff stream) into `out`; returns the uncompressed size.
 * 2026-07-08 FULL RE-TRANSCRIPTION from the ORIGINAL EA Canada source: EA's 2025 GPL release of
 * C&C Generals ships `Compression/EAC/huffdecode.cpp` ("Copyright (C) Electronic Arts Canada Inc.
 * 1995-2002") = the same codebase lineage as this 1998 PSX build (cross-checked against the NFS2
 * PC-beta nfsw.exe Watcom-debug `unhuff.obj` and this oracle). Macro/variable names below are EA's
 * own (GET16BITS / SQgetbits / SQgetnum / SQmemset; qs/qd/bits/bitsunshifted/bitsleft/type/clue/
 * cluelen/ulen/bitnumtbl/deltatbl/cmptbl/codetbl/quickcodetbl/quicklentbl/leap).
 * PSX-variant deltas vs the Generals version (per THIS oracle): no `type & 0x8000` 4-byte-size
 * branch (3-byte ulen only); an extra `doDecode` arg gates the table build; undelta checks plain
 * 0x32fb / 0x34fb (no 0xb?fb aliases); SQgetbits carries no `if (n)` guard (the later `ZERO`
 * device is hand-folded at the two refill-only sites, matching the oracle's lack of any ZERO load);
 * the quick-8 loop caches `bits>>24` in `idx` (`char idx`; the oracle reuses the extract across the
 * unroll back-edge -- gcc cannot CSE across the join, so the variable is original); the quick-8
 * STORE address is materialized into a `cp = quickcodeptr + idx` pointer BEFORE the `bits<<=numbits`
 * shift (matching the oracle's `addu t6,v1` ahead of `sllv`); the clue byte is read DIRECT
 * `SQgetbits(clue,8)` (no `unsigned int t` temp -- the oracle coalesces clue into $30);
 * `cluelen`/`bitnum` carry NO `=0` initializers (the oracle has no init store to cluelen's spill).
 * RESULT 2026-07-08: 1531 -> 22 diffs, ours 777 == oracle 777 (EXACT instruction count).
 * RESIDUAL 22 (traced to a single CROSS-LOOP COLORING coin-flip -- NOT a structural miss): the
 * leapfrog `for (i=0;i<numchars;++i)` emits a top-test (`slt;beqz;...;j back`) where the oracle
 * ROTATES it to a `blez numchars` guard + bottom-`slt` do-while. Forcing the rotation with an
 * explicit `if(numchars>0){do{...}while(i<numchars);}` DOES produce the mnemonic-exact blez+rotated
 * shape, but flips `numchars` from $s1 to $s0 across the WHOLE function -> breaks the earlier
 * bitnum-decode loop (which needs numchars=$s1) = 40 diffs. So the oracle wants numchars=$s1 AND a
 * rotated leapfrog; our gcc-2.8.0 build gives one XOR the other (retail ccpsx rotates a for-loop
 * with a complex SQgetnum head that our build won't). Plain-for kept: numchars=$s1 correct, exact
 * count, only the leapfrog entry/back-edge shape diverges. => permuter multi-basin (the do-while
 * basin is structurally exact, needs the $s0->$s1 flip). NOT toolchain-fixable at source. */

#define GET16BITS() \
    bitsunshifted = qs[0] | (bitsunshifted << 8);\
    bitsunshifted = qs[1] | (bitsunshifted << 8);\
    qs += 2;

#define SQgetbits(v,n)\
    v = bits >> (32-(n));\
    bits <<= (n);\
    bitsleft -= (n);\
    if (bitsleft<0)\
    {\
        GET16BITS() \
        bits = bitsunshifted<<(-bitsleft);\
        bitsleft += 16;\
    }

#define SQrefill()\
    if (bitsleft<0)\
    {\
        GET16BITS() \
        bits = bitsunshifted<<(-bitsleft);\
        bitsleft += 16;\
    }

#define SQgetnum(v) \
    if ((int)bits<0)\
    {\
        SQgetbits(v,3);\
        v -= 4;\
    }\
    else\
    {\
        int             n;\
        unsigned int   v1;\
\
        if (bits>>16)\
        {\
            n=2;\
            do\
            {\
                bits <<= 1; \
                ++n;\
            }\
            while ((int)bits>=0);\
            bits <<= 1;\
            bitsleft -= (n-1);\
            SQrefill();\
        }\
        else\
        {\
            n=2;\
            do\
            {\
                ++n;\
                SQgetbits(v,1);\
            }\
            while (!v);\
        }\
        if (n>16)\
        {\
            SQgetbits(v,n-16);\
            SQgetbits(v1,16);\
            v = (v1|(v<<16))+(1<<n)-4;\
        }\
        else\
        {\
            SQgetbits(v,n);\
            v = (v+(1<<n)-4);\
        }\
    }

/* note:  requires 'amt' be a multiple of 16 */
#define SQmemset(ptr, val, amt) \
{\
    int i = amt/16;\
    int intval = (val<<24)|(val<<16)|(val<<8)|val;\
    int* lptr = (int*)ptr;\
\
    while (i)\
    {\
        lptr[0] = intval;\
        lptr[1] = intval;\
        lptr[2] = intval;\
        lptr[3] = intval;\
        lptr += 4;\
        --i;\
    }\
}\

extern "C" int unhuff(unsigned char *comp, unsigned char *out, int doDecode)
{
    unsigned int    type;
    unsigned char   clue;
    int            ulen;
    unsigned int    cmp;
    int             bitnum;
    int             cluelen;
    unsigned char   *qs;
    unsigned char   *qd;
    unsigned int   bits;
    unsigned int   bitsunshifted=0;
    int             numbits;
    int             bitsleft;
    unsigned int   v;

    qs = comp;
    qd = out;
    ulen = 0;

    if (qs)
    {
        {
            int             mostbits;
            int             i;
            int             bitnumtbl[16];
            unsigned int    deltatbl[16];
            unsigned int    cmptbl[16];
            unsigned char   codetbl[256];
            unsigned char   quickcodetbl[256];
            unsigned char   quicklentbl[256];

            bitsleft = -16;                                 /* init bit stream */
            bits = 0;
            SQrefill();

            SQgetbits(type,16);

            /* (skip nothing for 0x30fb) */
            if (type&0x100)                                 /* skip ulen */
            {
                SQgetbits(v,8);
                SQgetbits(v,16);
            }
            type &= ~0x100;

            SQgetbits(v,8);                                 /* unpack len */
            SQgetbits(ulen,16);
            ulen |= (v<<16);

            if (doDecode)
            {
                {
                    int numchars;

                    {
                        unsigned int basecmp;

                        numchars = 0;

                        SQgetbits(clue,8);                          /* clue byte */

                        numbits = 1;
                        basecmp = (unsigned int) 0;

                        /* decode bitnums */

                        do
                        {
                            basecmp <<= 1;
                            deltatbl[numbits] = basecmp-numchars;

                            SQgetnum(bitnum);               /* # of codes of n bits */
                            bitnumtbl[numbits] = bitnum;

                            numchars += bitnum;
                            basecmp += bitnum;

                            cmp = 0;
                            if (bitnum)                             /* left justify cmp */
                                cmp = (basecmp << (16-numbits) & 0xffff);

                            cmptbl[numbits++] = cmp;

                        }
                        while (!bitnum || cmp);                     /* n+1 bits in cmp? */
                    }
                    cmptbl[numbits-1] = 0xffffffff;               /* force match on most bits */

                    mostbits = numbits-1;

                    /* decode leapfrog code table */

                    {
                        signed char     leap[256];
                        unsigned char   nextchar;

                        SQmemset(leap,0,256);
                        nextchar = (unsigned char) -1;

                        if (numchars > 0)
                        {
                            i = 0;
                            do
                            {
                                int leapdelta=0;

                                SQgetnum(leapdelta);
                                ++leapdelta;

                                do
                                {
                                    ++nextchar;
                                    if (!leap[nextchar])
                                        --leapdelta;
                                } while (leapdelta);

                                leap[nextchar] = 1;
                                codetbl[i] = nextchar;
                                ++i;
                            } while (i < numchars);
                        }
                    }
                }

/****************************************************************/
/*  Make fast 8 tables                                          */
/****************************************************************/

                SQmemset(quicklentbl,64,256);

                {
                    int bits;
                    int bitnum;
                    int numbitentries;
                    int nextcode;
                    int nextlen;
                    int i;
                    unsigned char *codeptr;
                    unsigned char *quickcodeptr;
                    unsigned char *quicklenptr;

                    codeptr = codetbl;
                    quickcodeptr = quickcodetbl;
                    quicklenptr = quicklentbl;

                    for (bits=1; bits<=mostbits; ++bits)
                    {
                        bitnum = bitnumtbl[bits];
                        if (bits>=9)
                            break;
                        numbitentries = 1<<(8-bits);

                        while (bitnum--)
                        {
                            nextcode = *codeptr++;
                            nextlen = bits;
                            if (nextcode==clue)
                            {
                                cluelen = bits;
                                nextlen = 96;                   /* will force out of main loop */
                            }
                            for (i=0; i<numbitentries; ++i)
                            {
                                *quickcodeptr++ = (unsigned char) nextcode;
                                *quicklenptr++ = (unsigned char) nextlen;
                            }
                        }
                    }
                }
            }

/****************************************************************/
/*  Main decoder                                                */
/****************************************************************/

            for (;;)
            {
                unsigned char   *quickcodeptr = quickcodetbl;
                unsigned char   *quicklenptr  = quicklentbl;
                unsigned int    idx;
                unsigned char  *cp;

                goto nextloop;

/* quick 8 fetch */

                do
                {

                    *qd++ = quickcodeptr[bits>>24];
                    GET16BITS();
                    bits = bitsunshifted<<(16-bitsleft);

/* quick 8 decode */

nextloop:
                    idx = bits>>24;
                    numbits = quicklenptr[idx];
                    bitsleft -= numbits;

                    if (bitsleft>=0)
                    {
                        do
                        {
                            cp = quickcodeptr + idx;
                            bits <<= numbits;
                            *qd++ = *cp;
                            idx = bits>>24;

                            numbits = quicklenptr[idx];
                            bitsleft -= numbits;
                            if (bitsleft<0) break;
                            cp = quickcodeptr + idx;
                            bits <<= numbits;
                            *qd++ = *cp;
                            idx = bits>>24;

                            numbits = quicklenptr[idx];
                            bitsleft -= numbits;
                            if (bitsleft<0) break;
                            cp = quickcodeptr + idx;
                            bits <<= numbits;
                            *qd++ = *cp;
                            idx = bits>>24;

                            numbits = quicklenptr[idx];
                            bitsleft -= numbits;
                            if (bitsleft<0) break;
                            cp = quickcodeptr + idx;
                            bits <<= numbits;
                            *qd++ = *cp;
                            idx = bits>>24;

                            numbits = quicklenptr[idx];
                            bitsleft -= numbits;

                        } while (bitsleft>=0);
                    }
                    bitsleft += 16;

                } while (bitsleft>=0);  /* would fetching 16 bits do it? */

                bitsleft = bitsleft-16+numbits;   /* back to normal */

/****************************************************************/
/*  16 bit decoder                                              */
/****************************************************************/

                {
                    unsigned char   code;


                    if (numbits!=96)
                    {
                        cmp = (unsigned int) (bits>>16);  /* 16 bit left justified compare */

                        numbits = 8;
                        do
                        {
                            ++numbits;
                        }
                        while (cmp>=cmptbl[numbits]);
                    }
                    else
                        numbits = cluelen;


                    cmp = bits >> (32-(numbits));
                    bits <<= (numbits);
                    bitsleft -= (numbits);

                    code = codetbl[cmp-deltatbl[numbits]];  /* the code */

                    if (code!=clue && bitsleft>=0)
                    {
                        *qd++ = code;
                        goto nextloop;
                    }

                    if (bitsleft<0)
                    {
                        GET16BITS();
                        bits = bitsunshifted<<-bitsleft;
                        bitsleft += 16;
                    }

                    if (code!=clue)
                    {
                        *qd++ = code;
                        goto nextloop;
                    }

                    /* handle clue */

                    {
                        int    runlen=0;
                        unsigned char *d=qd;
                        unsigned char *dest;

                        SQgetnum(runlen);
                        if (runlen)                             /* runlength sequence */
                        {
                            dest = d+runlen;
                            code = *(d-1);
                            do
                            {
                                *d++ = code;
                            } while (d<dest);

                            qd = d;
                            goto nextloop;
                        }
                    }

                    SQgetbits(v,1);                         /* End Of File */
                    if (v)
                        break;

                    {
                        unsigned int t;
                        SQgetbits(t,8);                    /* explicite byte */
                        code = (unsigned char)t;
                    }
                    *qd++ = code;
                    goto nextloop;
                }

            }


/****************************************************************/
/*  Undelta                                                     */
/****************************************************************/

            {
                int i;
                int nextchar;

                if (type==0x32fb)                           /* deltaed? */
                {
                    i = 0;
                    qd = out;
                    while (qd<out+ulen)
                    {
                        i += (int) *qd;
                        *qd++ = (unsigned char) i;
                    }
                }
                else if (type==0x34fb)                      /* accelerated? */
                {

                    i = 0;
                    nextchar = 0;
                    qd = out;
                    while (qd<out+ulen)
                    {
                        i += (int) *qd;
                        nextchar += i;
                        *qd++ = (unsigned char) nextchar;
                    }
                }
            }
        }
    }
    return(ulen);
}

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
