/* unhuff @0x800F459C : decompress an EA Huff stream into `out`; returns the uncompressed size.
 * SEALED 2026-07-08 (verify_asm PASS, 777/777 insns) -- eacpsxz.lib(unhuff.obj) is a C module:
 * this TU compiles with CC1PSX (gcc 2.8.0, C) via build.py compile_c, NOT CC1PLPSX. The same
 * source scores 20 "diffs" under cc1plus -- that residual was a C-vs-C++ compiler artifact.
 * PROVENANCE: transcribed from EA's GPL'd huffdecode.cpp (C&C Generals 2025 release,
 * (C) Electronic Arts Canada 1995-2002 -- the same codebase lineage), PSX-variant deltas per
 * this oracle (3-byte ulen, doDecode gate, plain 0x32fb/0x34fb undelta); cross-checked against
 * the NFS2 PC-beta nfsw.exe Watcom build (unhuff.obj, _unhuff @0x004a39f0).
 * FINAL LEVER (community: Bl00D4NGEL, decomp.me/scratch/8YjZQ, forked from our wEnyh):
 * `basecmp = numchars;` instead of `= 0` -- the READ extends numchars' live range, dropping
 * its gcc-2.8 allocno priority below the table base so it keeps $s1 with the clue read in
 * its original position, and the plain `for` leapfrog then rotates to the oracle shape. */

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

int unhuff(unsigned char *comp, unsigned char *out, int doDecode)
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
                        int basecmp;

                        SQgetbits(clue,8);                          /* clue byte */

                        numchars = 0;
                        numbits = 1;
                        basecmp = numchars;

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

                        for (i = 0; i < numchars; i++)
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