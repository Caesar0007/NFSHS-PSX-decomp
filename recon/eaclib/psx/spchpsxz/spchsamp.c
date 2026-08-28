/* eaclib/psx/spchpsxz/spchsamp.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\spchsamp.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x8010B5AC .. 0x8010B5D4].  Decodes one speech-sample descriptor out of a packed sample bank.
 *   Ghidra nfs4-f.exe.c (spchsamp) + disasm-v3 + IDA sigs.
 *
 *   `out` is a 0x10-byte VoxSample descriptor: [0]=int length(<<8), [4]=int spuStart(<<8), [8]=int filterCnt,
 *   [0xc..0xf]=up to 4 filter bytes.  A bank entry is (2 + filterCnt) bytes: [0..1]=start offset (16-bit BE),
 *   [2..]=filter bytes; high bit of entry[0] flags a redirect to entry[entry[1]].
 *
 *   Ghidra-ism note: IDA typed iSPCH_InitSample as 1-arg (its body reads only `out`), but the sole caller
 *   (iSPCH_UnPackSample) passes (out, sampleId) -- kept 2-arg as the formal API, sampleId unused here.
 */

extern void iSPCH_InitSample(int *out);                            /* @0x8010B5AC */
extern int  iSPCH_UnPackSample(int bank, int sampleIdx, int *out); /* @0x8010B5D4 */

/* iSPCH_InitSample @0x8010B5AC : reset a VoxSample descriptor to "empty" (length 0, start -1, no filter,
 *   filter bytes 0xff). */
extern void iSPCH_InitSample(int *out)
{
    out[1] = -1;
    *out   = 0;
    out[2] = 0;
    *((unsigned char *)out + 0xc) = 0xff;
    *((unsigned char *)out + 0xd) = 0xff;
    *((unsigned char *)out + 0xe) = 0xff;
    *((unsigned char *)out + 0xf) = 0xff;
}

/* iSPCH_UnPackSample @0x8010B5D4 : decode sample `sampleIdx` of `bank` into `out`.  Reads the entry's filter
 *   bytes + start offset, follows a redirect if the entry's high bit is set, then scans forward for the next
 *   real entry (or the bank total at bank+4) to derive the length.  Returns 1 on success, 0 if out of range.
 * MATCH (w31-a4, 39->0): startOff/endOff each built in TWO statements (`x = (e[0]<<8)+e[1]; x <<= 8;`)
 *   -- the single-expression form let gcc cross-jump-merge the two arms' identical `sll rX,v0,8` tails
 *   (1 insn short) and colored startOff into a fresh temp instead of reusing dead `entry`/$a2.
 *   The InitSample 1-arg fix (above) removed sampleIdx's phantom 7th ref, restoring the oracle's
 *   result->s1 / done->s2 / sampleIdx->s3 allocation order. */
extern int iSPCH_UnPackSample(int bank, int sampleIdx, int *out)
{
    int result = 0;
    int done = result;
    int endOff = result;

    iSPCH_InitSample(out);
    if (sampleIdx < (int)*(unsigned char *)(bank + 3)) {
        int filterCnt = *(unsigned char *)(bank + 2) & 0xf;
        int stride = filterCnt + 2;
        unsigned char *entry = (unsigned char *)(bank + 8);
        int i = 0;

        entry = entry + sampleIdx * stride;
        out[2] = filterCnt;
        if (i < filterCnt) {
            do {
                *((unsigned char *)out + i + 0xc) = entry[i + 2];
                i = i + 1;
            } while (i < filterCnt);
        }

        if ((*entry & 0x80) != 0) {
            sampleIdx = entry[1];
            entry = (unsigned char *)(bank + 8);
            entry = entry + sampleIdx * stride;
        }

        {
            unsigned char *nextEntry = entry + stride;
            int nextIndex = sampleIdx + 1;
            int startOff = (int)entry[0] * 0x100 + (int)entry[1];
            startOff = startOff * 0x100;

            out[1] = startOff;
            while (!done) {
                if ((int)*(unsigned char *)(bank + 3) <= nextIndex) {
                    done = 1;
                    endOff = (int)*(unsigned short *)(bank + 4) << 8;
                } else if ((*nextEntry & 0x80) != 0) {
                    nextEntry = nextEntry + stride;
                    nextIndex = nextIndex + 1;
                } else {
                    done = 1;
                    endOff = (int)nextEntry[0] * 0x100 + (int)nextEntry[1];
                    endOff = endOff * 0x100;
                }
            }
            *out = endOff - startOff;
        }
        result = 1;
    }
    return result;
}
