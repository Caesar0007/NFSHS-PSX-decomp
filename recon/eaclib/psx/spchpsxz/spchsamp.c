typedef int bool;
#define true 1
#define false 0
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

extern void iSPCH_InitSample(int *out, int sampleId);              /* @0x8010B5AC */
extern int  iSPCH_UnPackSample(int bank, unsigned int sampleIdx, int *out); /* @0x8010B5D4 */

/* iSPCH_InitSample @0x8010B5AC : reset a VoxSample descriptor to "empty" (length 0, start -1, no filter,
 *   filter bytes 0xff). */
extern void iSPCH_InitSample(int *out, int sampleId)
{
    (void)sampleId;
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
 *   real entry (or the bank total at bank+4) to derive the length.  Returns 1 on success, 0 if out of range. */
extern int iSPCH_UnPackSample(int bank, unsigned int sampleIdx, int *out)
{
    int            ret  = 0;
    bool           done = false;
    int           *pp;
    unsigned char *entry, *nextEntry;
    unsigned int   filterCnt;
    int            stride;
    int            fi, sidx;
    int            startOff, endOff;

    endOff = 0;
    iSPCH_InitSample(out, (int)sampleIdx);
    if ((int)sampleIdx < (int)(unsigned int)*(unsigned char *)(bank + 3)) {
        unsigned char flagByte = *(unsigned char *)(bank + 2);
        filterCnt = flagByte & 0xf;
        stride    = (int)filterCnt + 2;
        out[2]    = (int)filterCnt;
        entry     = (unsigned char *)(bank + 8 + (int)sampleIdx * stride);
        pp        = out;
        if ((flagByte & 0xf) != 0) {                 /* copy the filter bytes into out[0xc..] */
            fi = 0;
            do {
                int srcIx = fi + 2;
                fi = fi + 1;
                *(unsigned char *)(pp + 3) = entry[srcIx];
                pp = (int *)((int)out + fi);
            } while (fi < (int)filterCnt);
        }
        if ((*entry & 0x80) != 0) {                  /* redirect to a shared entry */
            sampleIdx = (unsigned int)entry[1];
            entry = (unsigned char *)(bank + 8 + (int)sampleIdx * stride);
        }
        nextEntry = entry + stride;
        sidx      = (int)sampleIdx + 1;
        startOff  = (unsigned int)*entry * 0x100 + (unsigned int)entry[1];
        out[1]    = startOff * 0x100;
        do {                                         /* find the next real entry -> end offset */
            if (sidx < (int)(unsigned int)*(unsigned char *)(bank + 3)) {
                if ((*nextEntry & 0x80) == 0) {
                    done = true;
                    endOff = ((unsigned int)*nextEntry * 0x100 + (unsigned int)nextEntry[1]) * 0x100;
                } else {
                    nextEntry = nextEntry + stride;
                    sidx = sidx + 1;
                }
            } else {
                done = true;
                endOff = (int)((unsigned int)*(unsigned short *)(bank + 4) << 8);
            }
        } while (!done);
        *out = endOff + startOff * -0x100;
        ret  = 1;
    }
    return ret;
}
