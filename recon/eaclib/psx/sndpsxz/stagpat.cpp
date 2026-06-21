/* eaclib/psx/sndpsxz/stagpat.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 8/8 ***
 *   Source obj : nfs4\eaclib\psx\stagpat.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   8 fns @[0x80101ABC .. 0x801025C0].  The patch-trigger engine -- parse a sound bank's tag stream, build
 *   per-note "timbres", and launch the voices (cSNDplay's core).  Ghidra nfs4-f.exe.c (stagpat) + IDA sigs.
 *
 *   ALL 8 fns SEALED.  The two dense parsers (iSNDplaytaggedpatch 864B / iSNDplaytaggedtimbre 1280B) were
 *   reconstructed from Ghidra + disasm-v3 (7-arg timbre call, range fields, captured returns Ghidra lost).
 *   NEW leaf deps: sgettag(iSNDgettag), sdresolv(iSNDplatformresolve/remove), srrange(randrange),
 *   srandom(iSNDrandom), sdplapat(iSNDplatformplay).
 *
 *   TIMBRE struct (0x98 bytes): +0x14/0x20 note range, +0x1c base note, +0x30 detune, +0x08/0x10 vel,
 *     +0x64 envelope ptr (&snddefaultenvelope), +0x90 patch flag, +0x94 timbre-active.
 *   BANK header: +0x03 flags (bit1 = 8-byte header, bit0 = resolved), +0x04/+0x08 tag stream start.
 */

extern "C" int          sndgs[];
extern "C" signed char  snddefaultenvelope;          /* default envelope table (sclcptch/data-mat) */
extern "C" char         DAT_801371cc;                /* rolling key-group counter */

extern "C" int  iSNDgettag(int *cursor, unsigned int *outId, int *outVal, int *outPtr);  /* sgettag (4-arg) */
extern "C" int  iSNDplatformresolve(int resolv, int patch_idx, int scratch);  /* sdresolv */
extern "C" int  iSNDplatformremove(int resolv, int *patch_idx);               /* sdresolv */
extern "C" int  randrange(int range);                                         /* srrange  */
extern "C" int  iSNDrandom(void);                                             /* srandom  */
extern "C" int  iSNDallocchan(unsigned int priority, int numChannels, int a2, unsigned int *out); /* salloc */
extern "C" int  iSNDfreechan(int chan);                                       /* salloc   */
extern "C" int  iSNDcalcpitch(int note);                                      /* sclcptch */
extern "C" unsigned int iSNDcalcvol(int chan);                                /* spatkey  */
extern "C" int  iSNDplatformplay(int chan, int voice, int level, int pitch, int a5, int fx, int volAngle); /* sdplapat (now 7-arg, sealed) */
extern "C" void trap(unsigned int code);                                      /* compiler div-by-zero break */

extern "C" void iSNDresetpatch(int patch);                          /* @0x80101ABC */
extern "C" unsigned char *iSNDresettimbre(int *t, int buf);         /* @0x80101AC4 */
extern "C" int  iSNDresolveheader(int *hdr, int *out);              /* @0x80101B7C */
extern "C" void iSNDfindfreekey(void);                              /* @0x80101BFC */
extern "C" int  iSNDresolvetaggedpatch(int bank, int patch_idx, int scratch);  /* @0x801024EC */
extern "C" int  iSNDremovetaggedpatch(int bank, int *patch_idx);    /* @0x801025C0 */
extern "C" int  iSNDplaytaggedtimbre(int timbre, int tag, int vol, int header,
                                     int baseNote, int velScale, int pitchOff);  /* @0x80101C8C */
extern "C" int  iSNDplaytaggedpatch(int patch, int tag);            /* @0x8010218C */
extern "C" int  SNDstop(unsigned int tag);                          /* sstop  */
extern "C" int  iSNDgetchan(unsigned int tag);                      /* salloc */
extern "C" void iSNDenteraudio(void);                               /* sserver */
extern "C" void iSNDleaveaudio(void);

/* iSNDresetpatch @0x80101ABC : clear a patch-play state's flag word (+0x90). */
extern "C" void iSNDresetpatch(int patch)
{
    *(int *)(patch + 0x90) = 0;
}

/* iSNDresettimbre @0x80101AC4 : zero the 0x98-byte timbre `buf` then load the default timbre into `t`
 *   (note range 0..0x3c, full velocity, default envelope). */
extern "C" unsigned char *iSNDresettimbre(int *t, int buf)
{
    int i = 0x25;
    int *p = (int *)(buf + 0x94);
    do {                                              /* zero the whole timbre buffer */
        *p = 0;
        i--;
        p--;
    } while (-1 < i);
    *(int *)((int)t + 0x14) = -1;
    *(int *)((int)t + 0x20) = -1;
    *(int *)((int)t + 0x1c) = 0x3c;
    *(int *)((int)t + 0x30) = 0x40;
    *(int *)((int)t + 4)    = 0;
    *(int *)((int)t + 8)    = 0x7f;
    *(int *)((int)t + 0xc)  = 0;
    *(int *)((int)t + 0x10) = 0x7f;
    *(int *)((int)t + 0x18) = 0;
    *(int *)((int)t + 0x24) = 1;
    *(int *)((int)t + 0x28) = 0;
    *(int *)((int)t + 0x2c) = 1;
    *(int *)((int)t + 0x34) = 0;
    *(int *)((int)t + 0x38) = 0x7f;
    *(int *)((int)t + 0x3c) = 0;
    *(int *)((int)t + 0x40) = 0;
    *(int *)((int)t + 0x44) = 0;
    *(int *)((int)t + 0x48) = 0;
    *(int *)((int)t + 0x4c) = 0;
    *(int *)((int)t + 0x54) = 0;
    *(int *)((int)t + 0x5c) = 0;
    *(int *)((int)t + 0x70) = 0x7f;
    *(int *)((int)t + 0x74) = 0;
    *(int *)((int)t + 0x78) = 0;
    *(int *)((int)t + 0x7c) = 0;
    *(int *)((int)t + 0x80) = 0;
    *(int *)((int)t + 0x84) = 0;
    *(int *)((int)t + 0x8c) = 0;
    *(int *)((int)t + 0x88) = 0;
    *(int *)((int)t + 0x94) = 1;
    *(unsigned char **)((int)t + 100) = (unsigned char *)&snddefaultenvelope;
    return (unsigned char *)&snddefaultenvelope;
}

/* iSNDresolveheader @0x80101B7C : fold an override header `out` into the running timbre header `hdr`
 *   (sum the envelope / volume / pitch fields). */
extern "C" int iSNDresolveheader(int *hdr, int *out)
{
    int r;
    *(int *)((int)hdr + 0x48) = *(int *)((int)out + 0x48) + *(int *)((int)hdr + 0x48);
    *(int *)((int)hdr + 0x54) = *(int *)((int)out + 0x54) + *(int *)((int)hdr + 0x54);
    *(int *)((int)hdr + 0x5c) = *(int *)((int)out + 0x5c) + *(int *)((int)hdr + 0x5c);
    *(int *)((int)hdr + 0x74) = *(int *)((int)out + 0x74) + *(int *)((int)hdr + 0x74);
    r = *(int *)((int)out + 0x80) + *(int *)((int)hdr + 0x80);
    *(int *)((int)hdr + 0x80) = r;
    if (*(int *)((int)hdr + 100) != 0) {
        r = *(int *)((int)out + 100) + *(int *)((int)hdr + 100);
        *(int *)((int)hdr + 100) = r;
    }
    return r;
}

/* iSNDfindfreekey @0x80101BFC : advance the rolling key-group counter (DAT_801371cc) to a value not
 *   currently owned by any held channel. */
extern "C" void iSNDfindfreekey(void)
{
    char key;
    int  i, slot;
    while (1) {
        key = DAT_801371cc + 1;
        if ((char)(DAT_801371cc + 1) == 0)        /* skip 0 (the "no group" sentinel) */
            key = DAT_801371cc + 2;
        DAT_801371cc = key;
        i = 0;
        slot = sndgs[0x25];
        if (((unsigned char *)sndgs)[0x11] == 0)
            break;
        while (*(char *)(slot + 0xb) == 0 || *(char *)(slot + 0x37) != DAT_801371cc) {
            i++;
            slot += 100;
            if ((int)(unsigned)((unsigned char *)sndgs)[0x11] <= i)
                return;                           /* nobody owns this key -> it is free */
        }
    }
}

/* iSNDresolvetaggedpatch @0x801024EC : walk a bank's tag stream and resolve its SPU sample data (tag 0xfd
 *   = platform resolve), marking the bank resolved (+3 |= 1).  Returns -1 / resolve result. */
extern "C" int iSNDresolvetaggedpatch(int bank, int patch_idx, int scratch)
{
    int cursor;
    unsigned int tag[3];
    int r = -1;
    cursor = ((*(unsigned char *)(bank + 3) & 2) == 0) ? bank + 4 : bank + 8;
    while (iSNDgettag(&cursor, &tag[0], (int *)&tag[1], (int *)&tag[2]) != 0) {
        if (tag[0] == 0xfd)
            r = iSNDplatformresolve(cursor, patch_idx, scratch);
    }
    if (-1 < r)
        *(unsigned char *)(bank + 3) = *(unsigned char *)(bank + 3) | 1;
    return r;
}

/* iSNDremovetaggedpatch @0x801025C0 : walk a bank's tag stream and release its resolved SPU data (tag 0xfd
 *   = platform remove), clearing the resolved flag (+3 &= ~1). */
extern "C" int iSNDremovetaggedpatch(int bank, int *patch_idx)
{
    int cursor;
    unsigned int tag[3];
    cursor = ((*(unsigned char *)(bank + 3) & 2) == 0) ? bank + 4 : bank + 8;
    while (iSNDgettag(&cursor, &tag[0], (int *)&tag[1], (int *)&tag[2]) != 0) {
        if (tag[0] == 0xfd)
            iSNDplatformremove(cursor, patch_idx);
    }
    *(unsigned char *)(bank + 3) = *(unsigned char *)(bank + 3) & 0xfe;
    return 0;
}

/* iSNDplaytaggedtimbre @0x80101C8C : launch ONE note's voice from a fully-resolved timbre.  Folds the
 *   override `header`, randomises detune/pan/pitch (srrange/srandom), allocates a channel, fills its ~50
 *   playback fields from the timbre `vol`, computes the SPU sweep, and starts it via iSNDplatformplay.
 *   7-arg per IDA/disasm (Ghidra showed 3 + dropped header/baseNote/velScale/pitchOff).
 *     header   = override header folded into `vol`
 *     baseNote = the note being played (transposes pitch off the timbre's base note vol[0x1c])
 *     velScale = velocity (scales the pan curve)
 *     pitchOff = pitch-bend offset (applied when vol[0x90] is set)
 *   iSNDallocchan is 4-arg (vol[0x14] priority, vol[0x2c] numCh, vol[0x18] flag, &out); the final
 *   iSNDplatformplay arg list is best-effort (exact sig in sdplapat.obj; reconcile at link). */
extern "C" int iSNDplaytaggedtimbre(int timbre, int tag, int vol, int header,
                                    int baseNote, int velScale, int pitchOff)
{
    unsigned char b7  = *(unsigned char *)(tag + 7);
    char          b8  = *(char *)(tag + 8);
    unsigned char b9  = *(unsigned char *)(tag + 9);
    unsigned char b10 = *(unsigned char *)(tag + 10);
    unsigned int  out;
    int           chan, slot, detune, pan, panc, sw, s28, num;
    short         sv;

    iSNDresolveheader((int *)vol, (int *)header);

    detune = *(int *)(vol + 0x30);
    if (*(int *)(vol + 0x34) != 0)
        detune += randrange(*(int *)(vol + 0x34));
    if (detune < 0x80) { if (detune < 0) detune = 0; }
    else                 detune = 0x7f;

    chan = iSNDallocchan(*(unsigned int *)(vol + 0x14), *(int *)(vol + 0x2c), *(int *)(vol + 0x18), &out);
    if (-1 < chan) {
        slot = sndgs[0x25] + chan * 100;
        *(unsigned char *)(slot + 0x33) = *(unsigned char *)(vol + 0x94);
        sv = *(short *)(vol + 0x40);
        *(short *)(slot + 0x5c) = sv;
        sv = sv + (short)(((short)*(int *)(vol + 0x1c) - (short)baseNote) * -100);
        *(short *)(slot + 0x5c) = sv;
        if (*(int *)(vol + 0x90) != 0)
            *(short *)(slot + 0x5c) = sv + (short)pitchOff;
        if (*(int *)(vol + 0x44) != 0)
            *(short *)(slot + 0x5c) = *(short *)(slot + 0x5c) + (short)randrange(*(int *)(vol + 0x44));
        *(int *)(slot + 0x44) = *(int *)(vol + 0x48);
        *(int *)(slot + 0x48) = *(int *)(vol + 0x54);
        *(int *)(slot + 0x1c) = (int)b8 << 0x10;
        *(int *)(slot + 0x4c) = *(int *)(vol + 0x5c);
        *(int *)(slot + 0x14) = 0;
        *(unsigned char *)(slot + 0x3d) = b7;
        pan = *(int *)(vol + 0x38);
        if (*(int *)(vol + 0x3c) != 0)
            pan += randrange(*(int *)(vol + 0x3c));
        panc = pan;
        if (0x7f < pan)   panc = 0x7f;
        if (pan < -0x80)  panc = -0x80;
        *(char *)(slot + 0x2e) = (char)detune;
        *(char *)(slot + 0x2c) = (char)((panc * velScale) / 0x7f);
        *(unsigned char *)(slot + 0x2f) = b9;
        *(short *)(slot + 0x5a) = (short)(*(int *)(vol + 0x28) * 100);
        *(int *)(slot + 0x40) = *(int *)(vol + 100);
        *(unsigned char *)(slot + 0x31) = 0;
        *(int *)(slot + 0x24) = *(int *)(vol + 0x70) << 0x10;
        *(unsigned char *)(slot + 0x30) = *(unsigned char *)(vol + 0x24);
        *(unsigned char *)(slot + 0x32) = *(unsigned char *)(vol + 0x20);
        sw = **(int **)(slot + 0x40);
        *(int *)(slot + 0x28) = sw;
        if (sw < 0)
            *(int *)(slot + 0x28) = 0x7fffffff;
        s28 = *(int *)(slot + 0x28);
        num = *(int *)(*(int *)(slot + 0x40) + 4) * 0x10000 - *(int *)(slot + 0x24);
        if (s28 == 0)  trap(0x1c00);
        if (s28 == -1 && num == (int)0x80000000)  trap(0x1800);
        *(int *)(slot + 0x20) = num / s28;
        *(int *)(slot + 0x50) = *(int *)(vol + 0x74);
        *(int *)(slot + 0x54) = *(int *)(vol + 0x80);
        *(unsigned char *)(slot + 0x38) = *(unsigned char *)(vol + 0x78);
        *(unsigned char *)(slot + 0x39) = *(unsigned char *)(vol + 0x84);
        *(unsigned short *)(slot + 0x58) = (unsigned short)*(unsigned char *)(vol + 0x88);
        {
            unsigned int rv = *(unsigned int *)(vol + 0x7c);
            if (rv == 0) {
                *(unsigned char *)(slot + 0x3a) = 0;
            } else {
                iSNDrandom();
                if (*(unsigned int *)(vol + 0x78) == 0) trap(0x1c00);
                *(char *)(slot + 0x3a) = (char)(rv % *(unsigned int *)(vol + 0x78));
            }
            rv = *(unsigned int *)(vol + 0x8c);
            if (rv == 0) {
                *(unsigned char *)(slot + 0x3b) = 0;
            } else {
                iSNDrandom();
                if (*(unsigned int *)(vol + 0x84) == 0) trap(0x1c00);
                *(char *)(slot + 0x3b) = (char)(rv % *(unsigned int *)(vol + 0x84));
            }
        }
        *(short *)(slot + 0x3e) = *(short *)(tag + 0xe);
        *(short *)(slot + 0x5e) = 0;
        *(short *)(slot + 0x60) = *(short *)(tag + 0xc);
        iSNDcalcpitch(chan);
        *(unsigned char *)(slot + 0x35) = b10;
        *(unsigned char *)(slot + 0x34) = *(unsigned char *)(vol + 0x4c);
        *(unsigned char *)(slot + 10)   = *(unsigned char *)(tag + 4);
        *(short *)(slot + 8) = *(short *)tag;
        iSNDcalcvol(chan);
        if (iSNDplatformplay(timbre, chan, (int)*(char *)(slot + 0x2d),
                             (int)(unsigned)*(unsigned short *)(slot + 0x62), 0, 0, 0) < 0)   /* a5/fx/volAngle best-effort */
            iSNDfreechan(chan);
    }
    return chan;
}

/* iSNDplaytaggedpatch @0x8010218C : THE cSNDplay entry -- parse a patch's tag stream into per-note timbres
 *   and launch each note whose range matches.  For each tag: 0xfd records the SPU sample data ptr (the
 *   "timbre" to play); 0xfe terminates a note-region header -> if the requested note(tag[5])/vel(tag[6])
 *   fall in the accumulated range (builtTimbre[1..4]) launch it via iSNDplaytaggedtimbre, then reset the
 *   timbre; tag < 0x26 sets timbre[tag] (and the parallel override header) from the tag's two values.
 *   The started voices are collected and joined into a key group; on any failure all are SNDstop'd.
 *   Ghidra body + disasm: range fields are builtTimbre +4/+8 (vel min/max), +0xc/+0x10 (note min/max);
 *   the iSNDplaytaggedtimbre return (Ghidra lost it to void-typing) is the started voice tag.
 *     7-arg call: (timbreData, tag, &builtTimbre, &header, note, vel, pitchOff). pitchOff is best-effort 0
 *     (it is only used when the patch flag builtTimbre[0x90] is set, which iSNDresetpatch clears). */
extern "C" int iSNDplaytaggedpatch(int bank, int tag)
{
    int           note, vel;
    int           cursor, timbreData, prevTimbre;
    int           nStarted = 0, nAtFail = 0;
    unsigned int  ret = 0xfffffff7;
    unsigned int  gtag[3];                 /* {id, val1, val2} from iSNDgettag */
    int           bt[0x26];                /* built timbre   (anStack_198) */
    int           hdr[0x26];               /* override header (auStack_100) */
    unsigned int  started[12];
    int           i, slot, lastSlot = 0, r;

    if (bank == 0)
        return -8;
    note = (int)*(char *)(tag + 5);
    vel  = (int)*(char *)(tag + 6);
    cursor = ((*(unsigned char *)(bank + 3) & 2) == 0) ? bank + 4 : bank + 8;

    iSNDresetpatch((int)bt);
    iSNDresettimbre(bt, (int)hdr);
    iSNDenteraudio();
    iSNDfindfreekey();

    prevTimbre = 0;
    for (;;) {
        timbreData = prevTimbre;
        nAtFail = nStarted;                /* iVar10 = iVar9 captured at iteration start */
        if (iSNDgettag(&cursor, &gtag[0], (int *)&gtag[1], (int *)&gtag[2]) == 0)
            break;
        prevTimbre = cursor;               /* after a 0xfd tag the cursor IS the sample data */
        if (gtag[0] == 0xfd)
            continue;
        prevTimbre = timbreData;           /* non-0xfd: keep the last sample ptr */
        if (gtag[0] == 0xfe) {             /* note-region complete -> launch if in range */
            if (bt[1] <= vel && vel <= bt[2] && bt[3] <= note && note <= bt[4]) {
                r = iSNDplaytaggedtimbre(timbreData, tag, (int)bt, (int)hdr, note, vel, 0);
                if (r < 0)
                    goto fail;
                started[nStarted++] = (unsigned int)r;
                ret = (unsigned int)r;
            }
            iSNDresettimbre(bt, (int)hdr);
        } else if (gtag[0] < 0x26) {       /* field tag -> set timbre[idx] + parallel header[idx] */
            bt[gtag[0]]  = (int)gtag[1];
            hdr[gtag[0]] = (int)gtag[2];
            if (gtag[0] == 0x24)
                randrange((int)gtag[1]);
        }
    }
    /* the final note-region (no trailing 0xfe) */
    if (bt[1] <= vel && vel <= bt[2] && bt[3] <= note && note <= bt[4]) {
        r = iSNDplaytaggedtimbre(timbreData, tag, (int)bt, (int)hdr, note, vel, 0);
        if (r < 0)
            goto fail;
        started[nStarted++] = (unsigned int)r;
        ret = (unsigned int)r;
    }

    nAtFail = 0;
    if (nStarted != 0) {                   /* join the started voices into a key group */
        if (nStarted == 1) {
            i = iSNDgetchan(started[0]);
            if (-1 < i) {
                slot = sndgs[0x25] + i * 100;
                *(unsigned char *)(slot + 0x37) = 0;
                *(unsigned char *)(slot + 0x36) = 0;
            }
        } else {
            for (i = 0; i < nStarted; i++) {
                int ch = iSNDgetchan(started[i]);
                if (-1 < ch) {
                    lastSlot = sndgs[0x25] + ch * 100;
                    *(unsigned char *)(lastSlot + 0x37) = (unsigned char)DAT_801371cc;
                    *(unsigned char *)(lastSlot + 0x36) = 0;
                }
            }
            *(unsigned char *)(lastSlot + 0x36) = 1;     /* mark the last voice as the group end */
        }
        iSNDleaveaudio();
        return (int)ret;
    }

fail:
    iSNDleaveaudio();
    for (i = 0; i < nAtFail; i++)          /* roll back every voice started before the failure */
        SNDstop(started[i]);
    return (int)ret;
}
