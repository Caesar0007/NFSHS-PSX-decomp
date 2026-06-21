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

/* unhuff @0x800F459C : decompress `comp` (an EA Huff stream) into `out`; returns the uncompressed size. */
extern "C" int unhuff(unsigned char *comp, unsigned char *out, int doDecode)
{
    unsigned char *ip;          /* input byte cursor (pnVar20) */
    unsigned char *ip1;         /* pnVar1 */
    unsigned char  b0;          /* nVar3 : byte temp */
    unsigned int   more;        /* uVar19 : BE word / 16-bit refill register */
    unsigned int   bits;        /* uVar14 : 32-bit MSB bit accumulator */
    unsigned int   t13, t8, t16;/* uVar13, uVar8, uVar16 */
    int            bc, bc2;     /* iVar17, iVar18 : bit-count (Ghidra SSA split) */
    int            curlen;      /* iVar15 : current code length */
    unsigned int   magic;       /* uVar30 : 16-bit format magic */
    unsigned int   usize;       /* uVar12 : uncompressed size (return) */
    unsigned char *op;          /* pbVar22 : output write cursor */
    unsigned char *op2;         /* pbVar25 : output / table temp */
    unsigned char *dp;          /* pbVar27 : decode-symbol fill ptr */
    unsigned char *symp;        /* pbVar31 : symbol-table read ptr */
    int            t21, t23, t24;
    int            ncodes;      /* iVar29 : total #codes */
    int            off26;       /* iVar26 : byte offset into basecode/firstcode */
    int           *ncp;         /* piVar28 : numcodes ptr */
    unsigned char  sym;         /* bVar10 : current symbol / length-walk index */
    unsigned char  escape;      /* unaff_s8 : escape/literal marker symbol */
    unsigned int   escapelen;   /* local_30 */
    unsigned int  *fcp;         /* puVar9 : firstcode walk ptr */
    unsigned char *endp;        /* puVar11 : delta-filter end ptr */
    unsigned char  acc;         /* uVar5 */
    char           acc2;        /* cVar6 */
    int            i;

    int            numcodes[15];     /* local_4ec : #codes per length */
    int            basecode[16];     /* aiStack_4b0 */
    unsigned int   firstcode[17];    /* auStack_470[8]+uStack_450+local_44c[7] (contiguous; +sentinel slot) */
    unsigned char  symtab[256];      /* local_430 : symbol table */
    unsigned char  symbyprefix[256]; /* local_330 : symbol per 8-bit prefix */
    unsigned char  lenbyprefix[256]; /* local_230+local_22c : code length per 8-bit prefix */
    unsigned char  seen[256];        /* local_130+local_12c : symbol-seen flags */

    if (comp == (unsigned char *)0)
        return 0;

    /* --- header + bit-reader prime --- */
    ip    = comp + 4;
    bc    = 0;
    magic = ((unsigned int)comp[0] << 8) | comp[1];
    more  = ((unsigned int)comp[0] << 24) | ((unsigned int)comp[1] << 16) |
            ((unsigned int)comp[2] << 8) | comp[3];
    usize = more << 0x10;
    if ((comp[0] & 1) != 0) {
        ip    = comp + 8;
        bc    = 8;
        more  = ((unsigned int)comp[5] << 16) | ((unsigned int)comp[6] << 8) | comp[7];
        usize = more << 8;
    }
    magic = magic & 0xfeff;
    bc2   = bc - 8;
    t13   = usize << 8;
    if (bc2 < 0) {
        b0 = *ip; ip1 = ip + 1; ip = ip + 2;
        t13 = -bc2;
        bc2 = bc + 8;
        more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
        t13 = more << (t13 & 0x1f);
    }
    bc   = bc2 - 0x10;
    bits = t13 << 0x10;
    if (bc < 0) {
        b0 = *ip; ip1 = ip + 1; ip = ip + 2;
        more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
        bits = more << (-bc & 0x1fU);
        bc   = bc2;
    }
    usize = t13 >> 0x10 | (usize >> 0x18) << 0x10;
    op = out;

    if (doDecode != 0) {
        escape = bits >> 0x18;
        bc2 = bc - 8;
        bits = bits << 8;
        if (bc2 < 0) {
            b0 = *ip; ip1 = ip + 1; ip = ip + 2;
            t13 = -bc2;
            bc2 = bc + 8;
            more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
            bits = more << (t13 & 0x1f);
        }
        ncodes = 0;
        t24    = 0;
        ncp    = numcodes;
        off26  = 4;
        t23    = 1;
        /* --- read canonical code-length deltas, build numcodes / basecode / firstcode --- */
        do {
            curlen = t23;
            *(int *)((char *)basecode + off26) = t24 * 2 - ncodes;
            if ((int)bits < 0) {
                t13 = bits >> 0x1d;
                bc = bc2 - 3;
                bits = bits << 3;
                if (bc < 0) {
                    b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                    bits = -bc;
                    bc = bc2 + 0xd;
                    more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                    bits = more << (bits & 0x1f);
                }
            } else {
                t13 = 2;
                if (bits >> 0x10 == 0) {
                    t16 = 3;
                    do {
                        t13 = t16;
                        bc = bc2 - 1;
                        t8 = bits << 1;
                        if (bc < 0) {
                            b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                            t16 = -bc;
                            bc = bc2 + 0xf;
                            more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                            t8 = more << (t16 & 0x1f);
                        }
                        i = (-1 < (int)bits);
                        bits = t8;
                        bc2 = bc;
                        t16 = t13 + 1;
                    } while (i);
                } else {
                    do {
                        t8 = bits;
                        bits = t8 << 1;
                        t13 = t13 + 1;
                    } while (-1 < (int)bits);
                    bc = (bc2 + 1) - t13;
                    t8 = t8 << 2;
                    if (bc < 0) {
                        b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                        bits = -bc;
                        bc = bc + 0x10;
                        more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                        t8 = more << (bits & 0x1f);
                    }
                }
                if ((int)t13 < 0x11) {
                    bc = bc - t13;
                    bits = t8 << (t13 & 0x1f);
                    if (bc < 0) {
                        b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                        bits = -bc;
                        bc = bc + 0x10;
                        more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                        bits = more << (bits & 0x1f);
                    }
                    t13 = (t8 >> (0x20 - t13 & 0x1f)) + (1 << (t13 & 0x1f));
                } else {
                    t16 = t8 << (t13 - 0x10 & 0x1f);
                    bc2 = (bc + 0x10) - t13;
                    if (bc2 < 0) {
                        b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                        bits = -bc2;
                        bc2 = bc2 + 0x10;
                        more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                        t16 = more << (bits & 0x1f);
                    }
                    bc = bc2 - 0x10;
                    bits = t16 << 0x10;
                    if (bc < 0) {
                        b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                        more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                        bits = more << (-bc & 0x1fU);
                        bc = bc2;
                    }
                    t13 = (t16 >> 0x10 | (t8 >> (0x30 - t13 & 0x1f)) << 0x10) +
                          (1 << (t13 & 0x1f));
                }
            }
            t21 = t13 - 4;
            *ncp = t21;
            ncodes = ncodes + t21;
            t24 = t24 * 2 + t21;
            t13 = 0;
            if (t21 != 0)
                t13 = t24 << (0x10U - curlen & 0x1f) & 0xffff;
            *(unsigned int *)((char *)firstcode + off26) = t13;
            ncp = ncp + 1;
            off26 = off26 + 4;
            t23 = curlen + 1;
            bc2 = bc;
        } while ((t21 == 0) || (t13 != 0));
        firstcode[curlen] = 0xffffffff;

        for (i = 0; i < 256; i++)                 /* zero seen[256] (local_130/local_12c) */
            seen[i] = 0;

        sym = 0xff;
        t23 = 0;
        bc2 = bc;
        /* --- read the symbol table --- */
        if (0 < ncodes) {
            do {
                if ((int)bits < 0) {
                    t13 = bits >> 0x1d;
                    bc = bc2 - 3;
                    bits = bits << 3;
                    if (bc < 0) {
                        b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                        bits = -bc;
                        bc = bc2 + 0xd;
                        more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                        bits = more << (bits & 0x1f);
                    }
                } else {
                    t13 = 2;
                    if (bits >> 0x10 == 0) {
                        t16 = 3;
                        do {
                            t13 = t16;
                            bc = bc2 - 1;
                            t8 = bits << 1;
                            if (bc < 0) {
                                b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                                t16 = -bc;
                                bc = bc2 + 0xf;
                                more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                                t8 = more << (t16 & 0x1f);
                            }
                            i = (-1 < (int)bits);
                            bits = t8;
                            bc2 = bc;
                            t16 = t13 + 1;
                        } while (i);
                    } else {
                        do {
                            t8 = bits;
                            bits = t8 << 1;
                            t13 = t13 + 1;
                        } while (-1 < (int)bits);
                        bc = (bc2 + 1) - t13;
                        t8 = t8 << 2;
                        if (bc < 0) {
                            b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                            bits = -bc;
                            bc = bc + 0x10;
                            more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                            t8 = more << (bits & 0x1f);
                        }
                    }
                    if ((int)t13 < 0x11) {
                        bc = bc - t13;
                        bits = t8 << (t13 & 0x1f);
                        if (bc < 0) {
                            b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                            bits = -bc;
                            bc = bc + 0x10;
                            more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                            bits = more << (bits & 0x1f);
                        }
                        t13 = (t8 >> (0x20 - t13 & 0x1f)) + (1 << (t13 & 0x1f));
                    } else {
                        t16 = t8 << (t13 - 0x10 & 0x1f);
                        bc2 = (bc + 0x10) - t13;
                        if (bc2 < 0) {
                            b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                            bits = -bc2;
                            bc2 = bc2 + 0x10;
                            more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                            t16 = more << (bits & 0x1f);
                        }
                        bc = bc2 - 0x10;
                        bits = t16 << 0x10;
                        if (bc < 0) {
                            b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                            more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                            bits = more << (-bc & 0x1fU);
                            bc = bc2;
                        }
                        t13 = (t16 >> 0x10 | (t8 >> (0x30 - t13 & 0x1f)) << 0x10) +
                              (1 << (t13 & 0x1f));
                    }
                }
                bc2 = t13 - 3;
                do {
                    sym = sym + 1;
                    if (seen[sym] == 0)
                        bc2 = bc2 - 1;
                } while (bc2 != 0);
                t24 = t23 + 1;
                seen[sym] = 1;
                symtab[t23] = sym;
                bc2 = bc;
                t23 = t24;
            } while (t24 < ncodes);
        }

        for (i = 0; i < 256; i++)                 /* fill lenbyprefix[256] with 0x40 (local_230/local_22c) */
            lenbyprefix[i] = 0x40;

        symp = symtab;
        dp   = symbyprefix;
        op2  = lenbyprefix;
        t13  = 1;
        /* --- build the 8-bit fast-prefix decode tables --- */
        if (0 < curlen) {
            ncp = numcodes;
            do {
                bc2 = *ncp;
                if (8 < (int)t13)
                    break;
                t23 = 1 << (8 - t13 & 0x1f);
                while (bc2 = bc2 - 1, bc2 != -1) {
                    sym = *symp;
                    symp = symp + 1;
                    t16 = t13;
                    if (sym == escape) {
                        escapelen = t13;
                        t16 = 0x60;
                    }
                    t24 = 0;
                    if (0 < t23) {
                        do {
                            *dp = sym;
                            dp = dp + 1;
                            *op2 = (unsigned char)t16;
                            t24 = t24 + 1;
                            op2 = op2 + 1;
                        } while (t24 < t23);
                    }
                }
                t13 = t13 + 1;
                ncp = ncp + 1;
            } while ((int)t13 <= curlen);
        }
    }

    /* --- main decode loop --- */
    for (;;) {
        t13 = bits >> 0x18;
        t16 = lenbyprefix[t13];
        for (bc = bc - t16; op2 = op, -1 < bc; bc = bc - t16) {
            bits = bits << (t16 & 0x1f);
            t8 = bits >> 0x18;
            *op = symbyprefix[t13];
            t16 = lenbyprefix[t8];
            bc = bc - t16;
            op2 = op + 1;
            if (bc < 0) break;
            bits = bits << (t16 & 0x1f);
            t13 = bits >> 0x18;
            op[1] = symbyprefix[t8];
            t16 = lenbyprefix[t13];
            bc = bc - t16;
            op2 = op + 2;
            if (bc < 0) break;
            bits = bits << (t16 & 0x1f);
            t8 = bits >> 0x18;
            op[2] = symbyprefix[t13];
            t16 = lenbyprefix[t8];
            bc = bc - t16;
            op2 = op + 3;
            if (bc < 0) break;
            bits = bits << (t16 & 0x1f);
            t13 = bits >> 0x18;
            op[3] = symbyprefix[t8];
            t16 = lenbyprefix[t13];
            op = op + 4;
        }
        op = op2;
        bc = bc + 0x10;
        if (bc < 0) {
            t13 = escapelen;
            if (t16 != 0x60) {
                t13 = 8;
                fcp = &firstcode[8];
                do {
                    fcp = fcp + 1;
                    t13 = t13 + 1;
                } while (*fcp <= bits >> 0x10);
            }
            t8 = bits >> (0x20 - t13 & 0x1f);
            bits = bits << (t13 & 0x1f);
            sym = symtab[t8 - basecode[t13]];
            bc2 = (bc + (t16 - 0x10)) - t13;
            if (sym == escape) {
                if (bc2 < 0) {
                  refill_e38:
                    b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                    t13 = -bc2;
                    bc2 = bc2 + 0x10;
                    more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                    bits = more << (t13 & 0x1f);
                }
                if (sym == escape) {
                    if ((int)bits < 0) {
                        t13 = bits >> 0x1d;
                        bc = bc2 - 3;
                        bits = bits << 3;
                        if (bc < 0) {
                            b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                            bits = -bc;
                            bc = bc2 + 0xd;
                            more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                            bits = more << (bits & 0x1f);
                        }
                        bc2 = t13 - 4;
                    } else {
                        t13 = 2;
                        if (bits >> 0x10 == 0) {
                            t16 = 3;
                            do {
                                t13 = t16;
                                bc = bc2 - 1;
                                t8 = bits << 1;
                                if (bc < 0) {
                                    b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                                    t16 = -bc;
                                    bc = bc2 + 0xf;
                                    more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                                    t8 = more << (t16 & 0x1f);
                                }
                                i = (-1 < (int)bits);
                                bits = t8;
                                t16 = t13 + 1;
                                bc2 = bc;
                            } while (i);
                        } else {
                            do {
                                t8 = bits;
                                bits = t8 << 1;
                                t13 = t13 + 1;
                            } while (-1 < (int)bits);
                            bc = (bc2 + 1) - t13;
                            t8 = t8 << 2;
                            if (bc < 0) {
                                b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                                bits = -bc;
                                bc = bc + 0x10;
                                more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                                t8 = more << (bits & 0x1f);
                            }
                        }
                        if ((int)t13 < 0x11) {
                            bc = bc - t13;
                            bits = t8 << (t13 & 0x1f);
                            if (bc < 0) {
                                b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                                bits = -bc;
                                bc = bc + 0x10;
                                more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                                bits = more << (bits & 0x1f);
                            }
                            bc2 = (t8 >> (0x20 - t13 & 0x1f)) + (1 << (t13 & 0x1f)) + -4;
                        } else {
                            t16 = t8 << (t13 - 0x10 & 0x1f);
                            bc2 = (bc + 0x10) - t13;
                            if (bc2 < 0) {
                                b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                                bits = -bc2;
                                bc2 = bc2 + 0x10;
                                more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                                t16 = more << (bits & 0x1f);
                            }
                            bc = bc2 - 0x10;
                            bits = t16 << 0x10;
                            if (bc < 0) {
                                b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                                more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                                bits = more << (-bc & 0x1fU);
                                bc = bc2;
                            }
                            bc2 = (t16 >> 0x10 | (t8 >> (0x30 - t13 & 0x1f)) << 0x10) +
                                  (1 << (t13 & 0x1f)) + -4;
                        }
                    }
                    op2 = op + bc2;
                    if (bc2 == 0) {                       /* literal byte (or end-of-stream) */
                        t23 = bc - 1;
                        bc2 = bits << 1;
                        if (t23 < 0) {
                            b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                            t13 = -t23;
                            t23 = bc + 0xf;
                            more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                            bc2 = more << (t13 & 0x1f);
                        }
                        if ((int)bits < 0) {              /* end of stream -> delta post-filter + return */
                            if (magic == 0x32fb) {
                                endp = out + usize;
                                acc = 0;
                                for (; out < endp; out = out + 1) {
                                    acc = acc + *out;
                                    *out = acc;
                                }
                                return usize;
                            }
                            if (magic != 0x34fb)
                                return usize;
                            acc2 = 0;
                            endp = out + usize;
                            acc  = 0;
                            for (; out < endp; out = out + 1) {
                                acc2 = acc2 + *out;
                                acc  = acc + acc2;
                                *out = acc;
                            }
                            return usize;
                        }
                        bc = t23 - 8;
                        bits = (unsigned int)bc2 << 8;
                        if (bc < 0) {
                            b0 = *ip; ip1 = ip + 1; ip = ip + 2;
                            t13 = -bc;
                            bc = t23 + 8;
                            more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
                            bits = more << (t13 & 0x1f);
                        }
                        *op = (unsigned char)((unsigned int)bc2 >> 0x18);
                        op = op + 1;
                    } else {                              /* repeat run (back-reference of last byte) */
                        sym = op[-1];
                        do {
                            *op = sym;
                            op = op + 1;
                        } while (op < op2);
                    }
                    continue;
                }
                *op = sym;
                bc = bc2;
            } else {
                if (bc2 < 0)
                    goto refill_e38;
                *op = sym;
                bc = bc2;
            }
            op = op + 1;
            continue;
        }
        *op = symbyprefix[bits >> 0x18];
        b0 = *ip; ip1 = ip + 1; ip = ip + 2;
        more = (unsigned int)*ip1 | (((unsigned int)b0 | more << 8) << 8);
        bits = more << (0x10U - bc & 0x1f);
        op = op + 1;
    }
}

/* memcpyl @0x800F51C0 : copy `n` bytes (rounded up to 4) word-at-a-time via geti/puti.  Returns dst+n.
 * src ($s2) is loop-INVARIANT: geti is the bitstream reader (advances its own stream position), so the
 * same `src` base is passed every pass while dst advances; src is bumped once after the loop. */
extern "C" char *memcpyl(char *dst, char *src, int n)
{
    char *end = dst + n;
    do {
        unsigned int val = geti(src, 4);   /* @0x800F51E8 $a0=$s2 reloaded -- fixed src each iteration */
        puti((unsigned char *)dst, val, 4);
        dst = dst + 4;
        n   = n - 4;
    } while (0 < n);
    src = src + 4;   /* @0x800F5210: src advanced ONCE, after the loop (recon advanced it per-iter -- M04) */
    return end;
}

/* memcpyb @0x800F5234 : copy `n` bytes one at a time.  Returns the last byte copied. */
extern "C" unsigned int memcpyb(unsigned char *dst, unsigned char *src, int n)
{
    unsigned char last;
    do {
        last = *src;
        src  = src + 1;
        n    = n - 1;
        *dst = last;
        dst  = dst + 1;
    } while (n != 0);
    return (unsigned int)last;
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
