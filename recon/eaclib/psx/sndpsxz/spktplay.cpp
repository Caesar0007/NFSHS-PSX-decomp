/* eaclib/psx/sndpsxz/spktplay.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 13/13 ***
 *   Source obj : nfs4\eaclib\psx\spktplay.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   13 fns @[0x801028BC .. 0x80103424].  SNDPKTPLAY -- the packet player sst.obj feeds.  A ring of
 *   "frames" (each a list of per-channel sample-data pointers) is submitted, then drained by the platform
 *   audio layer; per-frame release/notify callbacks report consumption back up to the stream layer.
 *
 *   Dual-source: Ghidra `C:\Temp\claud\nfs4-f.exe.c` L166899..167407 + disasm-v3 L334627+ (authoritative;
 *   Ghidra mangled SNDPKTPLAY_start's unaligned copy AND swapped its hdr/arg3 param naming, and dropped
 *   the bodies of unsafeframesoutstanding/framesoutstanding and args of iSNDpacketget/freeframes).
 *
 *   ===== player ppp = sndpps[i] (@0x80148574, one slot) =====
 *     +0x00 voice id (-1 idle)   +0x04 submit sequence   +0x08(h) ring size (numFrames)
 *     +0x0A(h) read index   +0x0C(h) last-channel marker (0xffff)   +0x0E(h) outstanding frame count
 *     +0x10 bytes pending   +0x14 bytes consumed   +0x18 mem base   +0x1C release cb   +0x20 notify cb
 *     +0x24 rate word (unaligned copy)   +0x26(b) channels per frame   +0x28.. frame ring (0x18 each:
 *           +0=seq, +4=size, +8.. = up-to-channels sample pointers)
 *   ===== voice ch = sndgs[0x25] + note*100 (the global channel pool slot) =====
 */

extern "C" int  sndpps;                  /* @0x80148574 -- player array (one slot; access (&sndpps)[i]) */
extern "C" int  sndgs[];                  /* (char)sndgs[0xf]=init, sndgs[0x25]=channel pool base */
extern "C" int  iSNDplatformrate;         /* @0x80147840 -- platform sample rate (pitch calc) */

/* ---- backends ---- */
extern "C" int  iSNDplatformpacketoverhead(void);                           /* sdpacket */
extern "C" int  iSNDplatformpacketplaycreate(int slot, int *mem);
/* H10: 9-arg per oracle call @0x80102C94 (a0..a3 + sp+16/20/24/28/32). sdpacket's def reads 8
 *   (volAngle,level,pitch,a6,fxlevel,hdr-ptr); a9=hdr+0xc is pushed-but-unused, matching the binary. */
extern "C" int  iSNDplatformpacketplay(int p, int note, int volAngle, int level,
                                       int pitch, int a6, int fxlevel, int hdr, int a9);
extern "C" void iSNDplatformpacketplaydestroy(int p);
extern "C" int  iSNDallocchan(int a, int b, int c, int *out);               /* salloc */
extern "C" void iSNDfreechan(int note);
extern "C" void iSNDcalcpitch(int note);                                    /* sclcptch */
extern "C" void iSNDcalcvol(int note);                                      /* spatkey  */
extern "C" void SNDstop(unsigned int voice);                                /* sstop    */
extern "C" void iSNDenteraudio(void);                                       /* sserver  */
extern "C" void iSNDleaveaudio(void);

#define MI(p,o)  (*(int*)((p)+(o)))
#define MB(p,o)  (*(unsigned char*)((p)+(o)))
#define MSB(p,o) (*(signed char*)((p)+(o)))
#define MH(p,o)  (*(short*)((p)+(o)))
#define MUH(p,o) (*(unsigned short*)((p)+(o)))

/* forward decls (mutual) */
extern "C" int iSNDpacketplayoverhead(int n);                /* @0x801028BC */
extern "C" int SNDPKTPLAY_overhead(int n);                   /* @0x801028D0 */
extern "C" int SNDPKTPLAY_create(int mem, int memsize, int relcb, int notifycb); /* @0x801028FC */
extern "C" int SNDPKTPLAY_start(int p, int rate, int hdr, int params);       /* @0x80102A10 */
extern "C" int SNDPKTPLAY_submit(int p, int frame);          /* @0x80102CFC */
extern "C" int SNDPKTPLAY_submitspace(int p);                /* @0x80102E70 */
extern "C" int SNDPKTPLAY_unsafeframesoutstanding(int p);    /* @0x80102EC4 */
extern "C" int SNDPKTPLAY_framesoutstanding(int p);          /* @0x80102EEC */
extern "C" int SNDPKTPLAY_purge(int p, int lo, int hi);      /* @0x80102F3C */
extern "C" int SNDPKTPLAY_stop(int p);                       /* @0x80103118 */
extern "C" int SNDPKTPLAY_destroy(int p);                    /* @0x801031F4 */
extern "C" int iSNDpacketget(int p, int idx, int *out);      /* @0x80103248 */
extern "C" unsigned int iSNDpacketfreeframes(int p, int idx, int bytes);     /* @0x801033C4 */

/* ====================================================================================== */

/* iSNDpacketplayoverhead @0x801028BC : bytes of player bookkeeping for `n` frames. */
extern "C" int iSNDpacketplayoverhead(int n)
{
    return n * 0x18 + 0x40;
}

/* SNDPKTPLAY_overhead @0x801028D0 : total player overhead (bookkeeping + platform). */
extern "C" int SNDPKTPLAY_overhead(int n)
{
    int a = iSNDpacketplayoverhead(n);
    return a + iSNDplatformpacketoverhead();
}

/* SNDPKTPLAY_create @0x801028FC : claim a player slot in `mem`, size its frame ring, store the callbacks.
 *   Returns the slot index, or a negative error. */
extern "C" int SNDPKTPLAY_create(int mem, int memsize, int relcb, int notifycb)
{
    int slot, off, ppp;
    if ((char)sndgs[0xf] == 0)
        return -10;
    slot = 0;
    if ((&sndpps)[0] != 0)                       /* no free slot */
        return -9;
    off = iSNDplatformpacketplaycreate(slot, (int *)mem);
    if (off < 0)
        return -6;
    iSNDplatformpacketoverhead();                /* (side effect / sizing, result discarded) */
    ppp = mem + off;
    iSNDplatformpacketoverhead();
    (&sndpps)[slot] = ppp;
    MI(ppp, 0x18) = mem;                          /* puVar4[6] */
    MI(ppp, 0x1c) = relcb;                        /* puVar4[7] */
    MI(ppp, 0x20) = notifycb;                     /* puVar4[8] */
    MH(ppp, 8) = (short)(((unsigned)(memsize - off - 0x40)) / 0x18);   /* ring size */
    MI(ppp, 0) = -1;
    return slot;
}

/* SNDPKTPLAY_start @0x80102A10 : begin playing a stream on player `p`.  Allocates a hardware voice, copies
 *   the format/rate into the voice, fills the ~50-field voice descriptor (sources per the disasm -- NOTE
 *   Ghidra's hdr/arg3 param naming is swapped), computes the playback pitch/duration, and hands off to the
 *   platform.  Returns the voice id, or a negative error.
 *   Args (per the caller, sst): rate = locked rate word, hdr = 0x14-byte header, params = 5-word params. */
extern "C" int SNDPKTPLAY_start(int p, int rate, int hdr, int params)
{
    int ppp, note, allocOut, ch, s3len, t4, v1, dur, r;
    if ((char)sndgs[0xf] == 0)
        return -10;
    ppp = (&sndpps)[p];
    iSNDenteraudio();
    note = iSNDallocchan(*(int *)hdr, MB(rate, 2), MSB(hdr, 6), &allocOut);
    if (note < 0) {
        iSNDleaveaudio();
        return -9;
    }

    MI(ppp, 0)    = allocOut;
    MH(ppp, 0xa)  = 0;
    MH(ppp, 0xe)  = 0;
    MI(ppp, 0x10) = 0;
    MI(ppp, 4)    = 0;
    MI(ppp, 0x14) = 0;
    MH(ppp, 0xc)  = (short)0xffff;
    *(int *)(ppp + 0x24) = *(int *)rate;          /* unaligned rate-word copy (asm: lwl/lwr) */

    ch = sndgs[0x25] + note * 100;
    if (MSB(params, 0xb) != 0)
        s3len = MUH(params, 0x10);
    else
        s3len = ((MSB(params, 7) - 0x40) << 8) & 0xffff;

    MB(ch, 0xa)   = 0xff;
    MUH(ch, 0x5c) = MUH(hdr, 4);
    MI(ch, 0x14)  = 0;
    MUH(ch, 0x60) = MUH(params, 0xc);
    MI(ch, 0x20)  = 0;
    MI(ch, 0x28)  = 0x7fffffff;
    MI(ch, 0x24)  = 0x7f0000;
    MI(ch, 0x1c)  = (int)MSB(params, 8) << 0x10;
    MB(ch, 0x2c)  = MB(hdr, 7);
    MB(ch, 0x2e)  = MB(hdr, 8);
    MB(ch, 0x30)  = 1;
    MB(ch, 0x31)  = 0;
    MB(ch, 0x32)  = 0;
    MB(ch, 0x33)  = 1;
    MB(ch, 0x2f)  = MB(params, 9);   /* H09: src was hdr (oracle 0x80102B90 *(u8)(9+$s4=params)) */
    MB(ch, 0x34)  = MB(hdr, 9);      /* H09: src was params (oracle 0x80102BAC *(u8)(9+$s5=hdr)) */
    MB(ch, 0x35)  = MB(params, 10);  /* H09: src was hdr (oracle 0x80102BB8 *(u8)(10+$s4=params)) */
    MH(ch, 0x5a)  = (short)(MSB(hdr, 10) * 100);
    MB(ch, 0x37)  = 0;
    MB(ch, 0x36)  = 0;
    MB(ch, 0x3d)  = MB(params, 7);   /* H09: src was hdr (oracle 0x80102BE8 *(u8)(7+$s4=params)) */
    MI(ch, 0x40)  = 0;
    MI(ch, 0x44)  = 0;
    MI(ch, 0x48)  = 0;
    MI(ch, 0x4c)  = 0;
    MI(ch, 0x50)  = 0;
    MI(ch, 0x54)  = 0;
    MH(ch, 0x5e)  = 0;

    iSNDcalcpitch(note);
    iSNDcalcvol(note);

    /* pitch -> playback duration: rate * ch[0x34] * ch[0x35], divided by a fixed constant */
    t4 = iSNDplatformrate * MSB(ch, 0x34);
    v1 = t4 * MSB(ch, 0x35);
    {
        long long pr = (long long)v1 * (int)0x82061029;
        dur = (((int)(pr >> 32) + v1) >> 0xD) - (v1 >> 0x1f);
    }
    /* H10: oracle (0x80102C94) passes 9 args; was 6 with dur/rate/hdr+0xc in the wrong slots and
       ch[0x2d]/ch[0x62]/params[0xe] missing.  a0..a3 + sp+16/20/24/28/32. */
    r = iSNDplatformpacketplay(p, note, s3len, MSB(ch, 0x2d), MUH(ch, 0x62),
                               MUH(params, 0xe), dur, rate, hdr + 0xc);
    if (r < 0) {
        iSNDfreechan(note);
        iSNDleaveaudio();
        return r;
    }
    iSNDleaveaudio();
    return MI(ppp, 0);
}

/* SNDPKTPLAY_submit @0x80102CFC : append a frame (descriptor `frame`) to the player's ring.  Returns the
 *   submit sequence number, or -0xD if the ring is full. */
extern "C" int SNDPKTPLAY_submit(int p, int frame)
{
    int ppp, slot, idx, seq, i;
    if ((char)sndgs[0xf] == 0)
        return -10;
    ppp = (&sndpps)[p];
    iSNDenteraudio();
    if ((int)MH(ppp, 0xe) < (int)MH(ppp, 8) - 1) {        /* room in the ring */
        idx = (int)MH(ppp, 0xa) + (int)MH(ppp, 0xe);      /* (read + count) wrapped */
        if ((int)MH(ppp, 8) <= idx)
            idx -= MH(ppp, 8);
        slot = ppp + idx * 0x18 + 0x28;
        MI(slot, 4) = *(int *)(frame + 4);                /* size */
        MI(slot, 0) = MI(ppp, 4);                         /* sequence */
        i = 0;
        if (MB(ppp, 0x26) != 0) {                         /* copy the per-channel pointers */
            int src = frame;
            int dst = slot;
            do {
                i++;
                MI(dst, 8) = *(int *)(src + 0xc);
                dst += 4;
                src += 4;
            } while (i < (int)MB(ppp, 0x26));
        }
        MH(ppp, 0xe) = MH(ppp, 0xe) + 1;                  /* count++ */
        MI(ppp, 0x10) = MI(ppp, 0x10) + *(int *)(frame + 4);  /* bytes pending += size */
        seq = MI(ppp, 4);
        MI(ppp, 4) = MI(ppp, 4) + 1;                      /* sequence++ */
    } else {
        seq = -0xd;
    }
    iSNDleaveaudio();
    return seq;
}

/* SNDPKTPLAY_submitspace @0x80102E70 : free frame slots in the ring. */
extern "C" int SNDPKTPLAY_submitspace(int p)
{
    if ((char)sndgs[0xf] != 0)
        return ((int)MH((&sndpps)[p], 8) - (int)MH((&sndpps)[p], 0xe)) - 1;
    return -10;
}

/* SNDPKTPLAY_unsafeframesoutstanding @0x80102EC4 : bytes still to be played (no critical section). */
extern "C" int SNDPKTPLAY_unsafeframesoutstanding(int p)
{
    int ppp = (&sndpps)[p];
    return MI(ppp, 0x10) + MI(ppp, 0x14);
}

/* SNDPKTPLAY_framesoutstanding @0x80102EEC : same, inside a critical section. */
extern "C" int SNDPKTPLAY_framesoutstanding(int p)
{
    int r;
    if ((char)sndgs[0xf] == 0)
        return -10;
    iSNDenteraudio();
    r = SNDPKTPLAY_unsafeframesoutstanding(p);
    iSNDleaveaudio();
    return r;
}

/* SNDPKTPLAY_purge @0x80102F3C : drop every frame whose sequence falls within [lo, hi] from the ring,
 *   compacting the survivors down, firing the release callback for each removed frame. */
extern "C" int SNDPKTPLAY_purge(int p, int lo, int hi)
{
    int   ppp;
    short total;
    int   rd, wr, rdoff, i;

    if ((char)sndgs[0xf] == 0)
        return -10;
    ppp = (&sndpps)[p];
    iSNDenteraudio();
    wr    = (int)MH(ppp, 0xa);                    /* write (compaction) index  */
    total = MH(ppp, 0xe);                         /* frames to scan            */
    rd    = (int)MH(ppp, 0xa);                    /* read index                */
    if (0 < total) {
        rdoff = rd * 0x18 + 0x28;
        int wrptr = wr * 0x18 + ppp;
        i = 0;
        do {
            int *fr = (int *)(ppp + rdoff);
            if (fr[0] < lo || hi < fr[0]) {        /* keep -> move down */
                MI(wrptr, 0x28) = fr[0];
                MI(wrptr, 0x2c) = fr[1];
                MI(wrptr, 0x30) = fr[2];
                MI(wrptr, 0x34) = fr[3];
                MI(wrptr, 0x38) = fr[4];
                MI(wrptr, 0x3c) = fr[5];
                wr++;
                wrptr += 0x18;
                if ((int)MH(ppp, 8) <= wr) {
                    wr = 0;
                    wrptr = ppp;
                }
            } else {                               /* remove */
                MH(ppp, 0xe) = MH(ppp, 0xe) - 1;
                MI(ppp, 0x10) = MI(ppp, 0x10) - fr[1];
                if (*(void **)(ppp + 0x1c) != 0)
                    (*(void (**)(int))(ppp + 0x1c))(fr[2]);
            }
            rdoff += 0x18;
            rd++;
            if ((int)MH(ppp, 8) <= rd) {
                rdoff = 0x28;
                rd = 0;
            }
            i++;
        } while (i < total);
    }
    iSNDleaveaudio();
    return 0;
}

/* SNDPKTPLAY_stop @0x80103118 : stop the voice, purge the whole ring, and idle the player. */
extern "C" int SNDPKTPLAY_stop(int p)
{
    int ppp;
    if ((char)sndgs[0xf] == 0)
        return -10;
    ppp = (&sndpps)[p];
    iSNDenteraudio();
    SNDstop(MI(ppp, 0));
    SNDPKTPLAY_purge(p, 0, 0x7fffffff);
    if (*(void **)(ppp + 0x1c) != 0 && -1 < (int)((unsigned)MUH(ppp, 0xc) << 0x10)) {
        (*(void (**)(int))(ppp + 0x1c))(MI(ppp, (short)MH(ppp, 0xc) * 0x18 + 0x30));
    }
    MI(ppp, 0) = -1;
    iSNDleaveaudio();
    return 0;
}

/* SNDPKTPLAY_destroy @0x801031F4 : release the player slot. */
extern "C" int SNDPKTPLAY_destroy(int p)
{
    if ((char)sndgs[0xf] == 0)
        return -10;
    iSNDplatformpacketplaydestroy(p);
    (&sndpps)[p] = 0;
    return 0;
}

/* iSNDpacketget @0x80103248 : platform pull -- hand out the next sample pointer for channel `idx` of the
 *   head frame, advancing the ring (and firing the release callback) once the last channel is taken.
 *   Writes the frame size to *out.  Returns the channel's sample pointer (0 if none). */
extern "C" int iSNDpacketget(int p, int idx, int *out)
{
    int   ppp = (&sndpps)[p];
    short m;
    int   fr;

    if ((unsigned)(idx + 1) == (unsigned)MB(ppp, 0x26) &&
        -1 < (int)((unsigned)MUH(ppp, 0xc) << 0x10)) {
        m = MH(ppp, 0xc);
        MH(ppp, 0xc) = (short)0xffff;
        if (*(void **)(ppp + 0x1c) != 0)
            (*(void (**)(int))(ppp + 0x1c))(MI(ppp, m * 0x18 + 0x30));
    }
    fr = 0;
    if (MH(ppp, 0xe) != 0) {
        fr = ppp + (int)MH(ppp, 0xa) * 0x18 + 0x28;
        *out = MI(fr, 4);
        if ((unsigned)(idx + 1) == (unsigned)MB(ppp, 0x26)) {
            MH(ppp, 0xc) = MH(ppp, 0xa);
            MH(ppp, 0xe) = MH(ppp, 0xe) - 1;
            MH(ppp, 0xa) = MH(ppp, 0xa) + 1;
            MI(ppp, 0x14) = MI(ppp, 0x14) + MI(fr, 4);
            MI(ppp, 0x10) = MI(ppp, 0x10) - MI(fr, 4);
            if ((int)((unsigned)MUH(ppp, 8) << 0x10) <= (int)((unsigned)MUH(ppp, 0xa) << 0x10))
                MH(ppp, 0xa) = 0;
        }
        fr = MI(fr, idx * 4 + 8);
    }
    return fr;
}

/* iSNDpacketfreeframes @0x801033C4 : platform notify -- once the last channel of a frame is consumed,
 *   credit `bytes` back and call the notify callback. */
extern "C" unsigned int iSNDpacketfreeframes(int p, int idx, int bytes)
{
    int          ppp = (&sndpps)[p];
    unsigned int v = (unsigned int)MB(ppp, 0x26);
    if ((unsigned)(idx + 1) == v) {
        v = MI(ppp, 0x14) - bytes;
        MI(ppp, 0x14) = (int)v;
        if (*(void **)(ppp + 0x20) != 0)
            v = (*(unsigned int (**)(void))(ppp + 0x20))();
    }
    return v;
}

/* owning-TU def (extern-declared, never defined; link-harness) */
extern "C" { int iSNDplatformrate; }
