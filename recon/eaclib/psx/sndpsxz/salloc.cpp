/* eaclib/psx/sndpsxz/salloc.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
 *   Source obj : nfs4\eaclib\psx\salloc.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x800FE724 .. 0x800FEDC4].  Sound-channel allocation/arbitration (no SPU pokes -- pure
 *   priority logic over the channel pool sndgs[0x25]).  Ghidra nfs4-f.exe.c L163749..164019.
 *
 *   Channel slot (100 bytes, pool base = sndgs[0x25], count = (byte)sndgs[0x11]):
 *     +0x00 owning tag (id|priority)   +0x0B in-use state (0 free / 1 held / 2 linked)
 *     +0x0C age   +0x10 alloc timestamp   +0x3C link-back   +0x3D..  voice fields
 */

extern "C" int           sndgs[];
extern "C" unsigned char  sndchanreserved[];       /* scratch list of chosen channel indices */
extern "C" int           DAT_80136dec;             /* rolling allocation id counter (+=0x20)  */
extern "C" int  SNDstop(unsigned int tag);                          /* sstop  */
extern "C" int  SNDover(unsigned int tag);                          /* sover  */

extern "C" int iSNDischanreserved(int chan, int count);             /* @0x800FE724 */

#define SNDNUMCHAN (((unsigned char *)sndgs)[0x11])  /* sndgs[4]._1_1_ : channels in the pool */

/* iSNDischanreserved @0x800FE724 : is channel `chan` already in the chosen list (first `count` entries)? */
extern "C" int iSNDischanreserved(int chan, int count)
{
    int i;
    for (i = 0; i < count; i++)
        if ((signed char)sndchanreserved[i] == chan)
            return 1;
    return 0;
}

/* iSNDallocchan @0x800FE764 : reserve `numChannels` voices for a sound, honouring the `priority` channel
 *   mask.  First takes idle channels (lowest timestamp), then -- if short -- steals the lowest-age /
 *   lowest-timestamp busy channels (stopping their current sound, rolling back on refusal).  Writes the
 *   allocation id to *out and returns the primary channel index, or -9 on failure.
 *     priority = channel-eligibility bitmask;  numChannels = voices needed;  a2 = a voice flag byte. */
extern "C" int iSNDallocchan(unsigned int priority, int numChannels, int a2, unsigned int *out)
{
    int          reserved = 0;
    int          result = -9;
    int          i, k, off;
    unsigned int best, c, v, bestval;

    for (i = 0; i < numChannels; i++)               /* clear the chosen list */
        sndchanreserved[i] = 0xff;

    DAT_80136dec += 0x20;                            /* fresh allocation id */
    if (DAT_80136dec < 0)
        DAT_80136dec = 0;

    if (0 < numChannels) {
        /* pass 1: take idle channels (state 0), preferring the oldest (lowest +0x10) */
        for (i = 0; i < numChannels; i++) {
            best = 0xffffffff;
            c = 0;
            if (SNDNUMCHAN != 0) {
                bestval = 0xffffffff;
                off = 0;
                do {
                    if ((priority & (1u << (c & 0x1f))) != 0) {
                        int ch = sndgs[0x25] + off;
                        if (*(char *)(ch + 0xb) == 0 &&
                            iSNDischanreserved(c, reserved) == 0) {
                            v = *(unsigned int *)(ch + 0x10);
                            if (v < bestval) { best = c; bestval = v; }
                        }
                    }
                    c++; off += 100;
                } while ((int)c < (int)(unsigned)SNDNUMCHAN);
            }
            if (-1 < (int)best) {
                sndchanreserved[reserved] = (unsigned char)best;
                reserved++;
            }
        }
        /* pass 2: short of channels -> steal busy ones by lowest (age, timestamp) */
        for (k = reserved; k < numChannels; k++) {
            unsigned char bestage = 0x66;
            unsigned int  bestv = 0xffffffff;
            v = 0;
            best = 0xffffffff;
            if (SNDNUMCHAN != 0) {
                c = 0;
                off = 0;
                do {
                    if ((priority & (1u << (c & 0x1f))) != 0 &&
                        iSNDischanreserved(c, reserved) == 0) {
                        int ch = sndgs[0x25] + off;
                        if (*(unsigned char *)(ch + 0xc) < 0x65) {
                            unsigned char age = *(unsigned char *)(ch + 0xc);
                            if (age < bestage) {
                                v = *(unsigned int *)(ch + 0x10);
                                bestage = age;
                            } else if (age != bestage ||
                                       (v = *(unsigned int *)(ch + 0x10), bestv <= v)) {
                                goto next2;
                            }
                            best = c;
                            bestv = v;
                        }
                    }
                next2:
                    c++; off += 100;
                } while ((int)c < (int)(unsigned)SNDNUMCHAN);
            }
            if (-1 < (int)best) {
                sndchanreserved[reserved] = (unsigned char)best;
                reserved++;
                if (numChannels <= reserved)
                    break;
            }
        }
    }

    if (reserved == numChannels) {                   /* got them all -> commit */
        *out = DAT_80136dec | (int)(signed char)sndchanreserved[0];
        result = (int)(signed char)sndchanreserved[0];
        i = 0;
        if (0 < reserved) {
            do {
                int *ch = (int *)(sndgs[0x25] + (signed char)sndchanreserved[i] * 100);
                unsigned int owner = *(unsigned int *)ch;
                if (*(char *)((int)ch + 0xb) == 1) {        /* currently held -> stop it */
                    if ((int)owner < 0)
                        owner = *(unsigned int *)((signed char)ch[0xf] * 100 + sndgs[0x25]);
                    SNDstop(owner);
                    if (SNDover(owner) != 1) {              /* refused -> roll back */
                        while (i = i - 1, -1 < i)
                            *(char *)(sndgs[0x25] + (signed char)sndchanreserved[i] * 100 + 0xb) = 0;
                        return -9;
                    }
                }
                *(char *)((int)ch + 0xb) = 1;
                ch[4] = sndgs[0x11];                        /* timestamp */
                *(char *)((int)ch + 0xc) = (char)a2;        /* voice flag byte */
                i++;
            } while (i < reserved);
        }
        /* link the secondary channels to the primary */
        *(unsigned int *)((signed char)sndchanreserved[0] * 100 + sndgs[0x25]) = *out;
        for (i = 1; i < reserved; i++) {
            *(unsigned char *)(i + (signed char)sndchanreserved[0] * 100 + sndgs[0x25] + 3) =
                sndchanreserved[i];
            *(unsigned int *)((signed char)sndchanreserved[i] * 100 + sndgs[0x25]) = 0xffffffff;
            *(unsigned char *)((signed char)sndchanreserved[i] * 100 + sndgs[0x25] + 0x3c) =
                sndchanreserved[0];
        }
    }
    return result;
}

/* iSNDfreechan @0x800FEC0C : release channel `chan`.  Honours linked-channel groups (a stereo/multi voice
 *   only frees when its partners are also done).  Returns the freed channel / 2 (still linked) / timestamp. */
extern "C" int iSNDfreechan(int chan)
{
    int *p;
    int  base = sndgs[0x25] + chan * 100;
    int  group = 0;
    int  partner = -1;
    int  idx;

    if (*(char *)(base + 0x37) == 0) {              /* not part of a link group */
        *(char *)(base + 0xb) = 0;
        *(int *)(base + 0x10) = sndgs[0x11];
        return sndgs[0x11];
    }

    idx = 0;
    p = (int *)sndgs[0x25];
    if (SNDNUMCHAN != 0) {
        do {
            if (*(char *)((int)p + 0x37) == *(char *)(base + 0x37) && -1 < *p &&
                *(char *)((int)p + 0xb) != 0 &&
                (group = group + 1, *(char *)((int)p + 0x36) != 0))
                partner = idx;
            idx++;
            p += 0x19;                              /* 100-byte stride */
        } while (idx < (int)(unsigned)SNDNUMCHAN);
    }
    base = sndgs[0x25] + chan * 100;
    if (group != 1) {
        int pbase = partner * 100;
        if (*(char *)(pbase + sndgs[0x25] + 0xb) == 2 && chan != partner && group == 2) {
            *(char *)(base + 0xb) = 0;
            *(int *)(base + 0x10) = sndgs[0x11];
            *(char *)(pbase + sndgs[0x25] + 0xb) = 0;
            pbase += sndgs[0x25];
            *(int *)(pbase + 0x10) = sndgs[0x11];
            return pbase;
        }
        idx = partner * 100 + sndgs[0x25];
        if (*(char *)(idx + 0xb) == 1 && chan == partner) {
            *(char *)(idx + 0xb) = 2;
            return 2;
        }
    }
    *(char *)(base + 0xb) = 0;
    *(int *)(base + 0x10) = sndgs[0x11];
    return sndgs[0x11];
}

/* iSNDgetchan @0x800FEDC4 : resolve a sound tag back to its channel index, validating that the channel is
 *   still held by that exact tag.  Returns the channel, or a negative error. */
extern "C" int iSNDgetchan(unsigned int tag)
{
    unsigned int ch;
    if (-1 < (int)tag && (ch = tag & 0x1f) < (unsigned)SNDNUMCHAN) {
        int *slot = (int *)(sndgs[0x25] + ch * 100);
        if (*(char *)((int)slot + 0xb) == 0 || *(unsigned int *)slot != tag)
            ch = 0xfffffff8;
        return ch;
    }
    return -8;
}
