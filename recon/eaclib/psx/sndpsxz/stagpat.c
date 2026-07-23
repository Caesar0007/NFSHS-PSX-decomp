/* eaclib/psx/sndpsxz/stagpat.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 8 PASS ***
 *   Source obj : nfs4\eaclib\psx\stagpat.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   8 fns @[0x80101ABC .. 0x801025C0].  The patch-trigger engine -- parse a sound bank's tag stream, build
 *   per-note "timbres", and launch the voices (cSNDplay's core).  Ghidra nfs4-f.exe.c (stagpat) + IDA sigs.
 *
 *   The two dense parsers (iSNDplaytaggedpatch 864B / iSNDplaytaggedtimbre 1280B) were reconstructed
 *   from Ghidra + disasm-v3 (7-arg timbre entry, range fields, and captured returns Ghidra lost).
 *   NEW leaf deps: sgettag(iSNDgettag), sdresolv(iSNDplatformresolve/remove), srrange(randrange),
 *   srandom(iSNDrandom), sdplapat(iSNDplatformplay).
 *
 *   TIMBRE struct (0x98 bytes): +0x14/0x20 note range, +0x1c base note, +0x30 detune, +0x08/0x10 vel,
 *     +0x64 envelope ptr (&snddefaultenvelope), +0x90 patch flag, +0x94 timbre-active.
 *   BANK header: +0x03 flags (bit1 = 8-byte header, bit0 = resolved), +0x04/+0x08 tag stream start.
 */

extern int          sndgs[];
extern signed char  snddefaultenvelope;          /* default envelope table (sclcptch/data-mat) */
/* Five-byte extern view keeps this byte out of -G4 small-data addressing without changing the
 * actual one-byte definition owned by snddata.c; only element zero exists and is accessed here. */
extern unsigned char DAT_801371cc[5];            /* rolling key-group counter */

extern int  iSNDgettag(int *cursor, unsigned int *outId, int *outVal, int *outPtr);  /* sgettag (4-arg) */
extern int  iSNDplatformresolve(int resolv, int patch_idx, int scratch);  /* sdresolv */
extern int  iSNDplatformremove(int resolv, int *patch_idx);               /* sdresolv */
extern int  randrange(int range);                                         /* srrange  */
extern int  iSNDrandom(void);                                             /* srandom  */
extern int  iSNDallocchan(unsigned int priority, int numChannels, int a2, unsigned int *out); /* salloc */
extern void iSNDfreechan(int chan);                                       /* salloc   */
extern int  iSNDcalcpitch(int note);                                      /* sclcptch */
extern unsigned int iSNDcalcvol(int chan);                                /* spatkey  */
extern int  iSNDplatformrate[];                                           /* spktplay/data */
extern int  iSNDplatformplay(int chan, int voice, int level, int pitch, int a5,
                             int fx, int volAngle, int pitchOffset);       /* sdplapat */
extern void trap(unsigned int code);                                      /* compiler div-by-zero break */

extern void iSNDresetpatch(int patch);                          /* @0x80101ABC */
extern unsigned char *iSNDresettimbre(int *t, int buf);         /* @0x80101AC4 */
extern void iSNDresolveheader(int *hdr, int *out);              /* @0x80101B7C */
extern int  iSNDfindfreekey(void);                              /* @0x80101BFC */
extern int  iSNDresolvetaggedpatch(int bank, int patch_idx, int scratch);  /* @0x801024EC */
extern int  iSNDremovetaggedpatch(int bank, int *patch_idx);    /* @0x801025C0 */
extern int  iSNDplaytaggedtimbre(int timbre, int tag, int vol, int header,
                                     int baseNote, int velScale, int pitchOff);  /* @0x80101C8C */
extern int  iSNDplaytaggedpatch(int patch, int tag);            /* @0x8010218C */
extern int  SNDstop(unsigned int tag);                          /* sstop  */
extern int  iSNDgetchan(unsigned int tag);                      /* salloc */
extern void iSNDenteraudio(void);                               /* sserver */
extern void iSNDleaveaudio(void);

/* iSNDresetpatch @0x80101ABC : clear a patch-play state's flag word (+0x90). */
extern void iSNDresetpatch(int patch)
{
    *(int *)(patch + 0x90) = 0;
}

/* iSNDresettimbre @0x80101AC4 : zero the 0x98-byte timbre `buf` then load the default timbre into `t`
 *   (note range 0..0x3c, full velocity, default envelope). */
extern unsigned char *iSNDresettimbre(int *t, int buf)
{
    int i = 0x25;
    int *p = (int *)(buf + 0x94);
    do {                                              /* zero the whole timbre buffer */
        *p = 0;
        i--;
        p--;
    } while (-1 < i);
    t[1] = 0;
    t[2] = 0x7f;
    t[3] = 0;
    t[4] = 0x7f;
    t[5] = -1;
    t[6] = 0;
    t[7] = 0x3c;
    t[8] = -1;
    t[9] = 1;
    t[10] = 0;
    t[11] = 1;
    t[12] = 0x40;
    t[13] = 0;
    t[14] = 0x7f;
    t[15] = 0;
    t[16] = 0;
    t[17] = 0;
    t[18] = 0;
    t[19] = 0;
    t[21] = 0;
    t[23] = 0;
    t[28] = 0x7f;
    t[29] = 0;
    t[30] = 0;
    t[31] = 0;
    t[32] = 0;
    t[33] = 0;
    t[35] = 0;
    t[34] = 0;
    t[37] = 1;
    t[25] = (int)&snddefaultenvelope;
    return (unsigned char *)&snddefaultenvelope;
}

/* iSNDresolveheader @0x80101B7C : fold an override header `out` into the running timbre header `hdr`
 *   (sum the envelope / volume / pitch fields). */
extern void iSNDresolveheader(int *hdr, int *out)
{
    *(int *)((int)hdr + 0x48) = *(int *)((int)out + 0x48) + *(int *)((int)hdr + 0x48);
    *(int *)((int)hdr + 0x54) = *(int *)((int)out + 0x54) + *(int *)((int)hdr + 0x54);
    *(int *)((int)hdr + 0x5c) = *(int *)((int)out + 0x5c) + *(int *)((int)hdr + 0x5c);
    *(int *)((int)hdr + 0x74) = *(int *)((int)out + 0x74) + *(int *)((int)hdr + 0x74);
    *(int *)((int)hdr + 0x80) = *(int *)((int)out + 0x80) + *(int *)((int)hdr + 0x80);
    if (*(int *)((int)hdr + 100) != 0)
        *(int *)((int)hdr + 100) = *(int *)((int)out + 100) + *(int *)((int)hdr + 100);
}

/* iSNDfindfreekey @0x80101BFC : advance the rolling key-group counter (DAT_801371cc) to a value not
 *   currently owned by any held channel; RETURNS the chosen key (oracle: `lbu v0,key; jr ra` --
 *   iSNDplaytaggedpatch captures it in $fp and stamps it into every started voice's +0x37). */
extern int iSNDfindfreekey(void)
{
    int   i, count, probe;
    unsigned char key;
    int *gs;
    char *slot;
top:
    DAT_801371cc[0] = DAT_801371cc[0] + 1;        /* lbu/addiu/sb; the == 0 test reuses the CSE'd value */
    if (DAT_801371cc[0] == 0)                     /* skip 0 (the "no group" sentinel) */
        DAT_801371cc[0] = DAT_801371cc[0] + 1;
    i = 0;
    gs = sndgs;                                   /* one la base for the +0x11 / +0x94 displacements */
    probe = ((unsigned char *)gs)[0x11];
    if (probe == 0)
        goto done;
    count = ((unsigned char *)gs)[0x11];
    key   = DAT_801371cc[0];
    slot  = (char *)gs[0x25];
loop:                                             /* goto-formed: no LOOP notes -> no giv anchoring */
    if (*(signed char *)(slot + 0xb) != 0) {
        if (*(unsigned char *)(slot + 0x37) == key)
            goto top;                             /* key owned by a held channel -> try the next one */
    }
    i++;
    slot += 0x64;
    if (i < count)
        goto loop;
done:
    return DAT_801371cc[0];
    /* MATCH: DAT_801371cc's five-byte extern VIEW suppresses -G4 gp-relative addressing while its
     * real storage remains the one-byte snddata.c definition.  Keeping `probe` distinct from `count`
     * then preserves the oracle's branch value in v1 and copies it to a2 for the loop bound. */
}

/* iSNDresolvetaggedpatch @0x801024EC : walk a bank's tag stream and resolve its SPU sample data (tag 0xfd
 *   = platform resolve), marking the bank resolved (+3 |= 1).  Returns -1 / resolve result. */
extern int iSNDresolvetaggedpatch(int bank, int patch_idx, int scratch)
{
    unsigned int state[4];
    int r = -1;
    state[0] = (unsigned int)bank;
    if ((*(unsigned char *)(bank + 3) & 2) != 0)
        state[0] = (unsigned int)(bank + 8);
    else
        state[0] = (unsigned int)(bank + 4);
    while (iSNDgettag((int *)&state[0], &state[1], (int *)&state[2], (int *)&state[3]) != 0) {
        if (state[1] == 0xfd)
            r = iSNDplatformresolve((int)state[0], patch_idx, scratch);
    }
    if (-1 < r)
        *(unsigned char *)(bank + 3) = *(unsigned char *)(bank + 3) | 1;
    return r;
}

/* iSNDremovetaggedpatch @0x801025C0 : walk a bank's tag stream and release its resolved SPU data (tag 0xfd
 *   = platform remove), clearing the resolved flag (+3 &= ~1). */
extern int iSNDremovetaggedpatch(int bank, int *patch_idx)
{
    unsigned int state[4];
    state[0] = (unsigned int)bank;
    if ((*(unsigned char *)(bank + 3) & 2) != 0)
        state[0] = (unsigned int)(bank + 8);
    else
        state[0] = (unsigned int)(bank + 4);
    while (iSNDgettag((int *)&state[0], &state[1], (int *)&state[2], (int *)&state[3]) != 0) {
        if (state[1] == 0xfd)
            iSNDplatformremove((int)state[0], patch_idx);
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
 *   iSNDallocchan is 4-arg (vol[0x14] priority, vol[0x2c] numCh, vol[0x18] flag, &out). The final
 *   iSNDplatformplay call is 8-arg: the oracle stores args 5..8 at sp+0x10..0x1c. This reconstruction
 *   restores the detune table/scaling path, both PRNG return uses, all four stack arguments, and the
 *   success/failure return contract. MATCH (320/320): modeling the one-word platform-rate storage as
 *   an array element makes gcc split its address materialization around the independent byte load. */
extern int iSNDplaytaggedtimbre(int timbre, int tag, int vol, int header,
                                    int baseNote, int velScale, int pitchOff)
{
    int b7  = *(signed char *)(tag + 7);
    int b8  = *(signed char *)(tag + 8);
    int b9  = *(signed char *)(tag + 9);
    int b10 = *(signed char *)(tag + 10);
    unsigned int  out;
    int           chan, slot, detune, pan, sw, s28, num, active, tmp;
    int           field28, field4c, field54, field5c;
    int           playOffset, playResult;
    int           playLevel, playPitch, playTag;
    unsigned int  sv;

    iSNDresolveheader((int *)vol, (int *)header);

    detune = *(int *)(vol + 0x30);
    if (*(int *)(vol + 0x34) != 0)
        detune += randrange(*(int *)(vol + 0x34));
    if (detune < 0x80)
        goto detune_low;
    detune = 0x7f;
    goto detune_done;
detune_low:
    if (detune < 0)
        detune = 0;
detune_done:

    chan = iSNDallocchan(*(unsigned int *)(vol + 0x14), *(int *)(vol + 0x2c), *(int *)(vol + 0x18), &out);
    if (chan < 0)
        return chan;
    {
        slot = sndgs[0x25] + chan * 100;
        *(unsigned char *)(slot + 0x33) = *(unsigned char *)(vol + 0x94);
        sv = *(unsigned short *)(vol + 0x40);
        *(short *)(slot + 0x5c) = sv;
        sv = sv - (*(int *)(vol + 0x1c) - baseNote) * 100;
        *(short *)(slot + 0x5c) = sv;
        if (*(int *)(vol + 0x90) != 0)
            *(short *)(slot + 0x5c) = sv + pitchOff;
        if (*(int *)(vol + 0x44) != 0)
            *(short *)(slot + 0x5c) = *(unsigned short *)(slot + 0x5c) + randrange(*(int *)(vol + 0x44));
        *(volatile int *)(slot + 0x44) = *(int *)(vol + 0x48);
        field54 = *(int *)(vol + 0x54);
        *(volatile int *)(slot + 0x48) = field54;
        field5c = *(int *)(vol + 0x5c);
        *(volatile int *)(slot + 0x1c) = (int)b8 << 0x10;
        *(volatile int *)(slot + 0x4c) = field5c;
        active = *(signed char *)(slot + 0x33);
        *(int *)(slot + 0x14) = 0;
        *(unsigned char *)(slot + 0x3d) = b7;
        if (active != 1)
            b7 = (b7 - 0x40) * active + 0x40;
        b7 = detune + b7 - 0x40;
        if (b7 < 0)
            b7 = 0;
        else if (0x7f < b7)
            b7 = 0x7f;
        if (*(int *)(slot + 0x48) != 0)
            b7 = *(signed char *)(*(int *)(slot + 0x48) + b7);
        pan = *(int *)(vol + 0x38);
        if (*(int *)(vol + 0x3c) != 0)
            pan += randrange(*(int *)(vol + 0x3c));
        if (pan < 0x80)
            goto pan_low;
        pan = 0x7f;
pan_low:
        if (pan < -0x80)
            pan = -0x80;
        *(char *)(slot + 0x2e) = (char)detune;
        *(char *)(slot + 0x2c) = (char)((pan * velScale) / 0x7f);
        field28 = *(int *)(vol + 0x28);
        *(unsigned char *)(slot + 0x2f) = b9;
        *(short *)(slot + 0x5a) = (short)(field28 * 100);
        *(int *)(slot + 0x40) = *(int *)(vol + 100);
        *(int *)(slot + 0x24) = *(int *)(vol + 0x70) << 0x10;
        *(unsigned char *)(slot + 0x31) = 0;
        *(unsigned char *)(slot + 0x30) = *(unsigned char *)(vol + 0x24);
        *(unsigned char *)(slot + 0x32) = *(unsigned char *)(vol + 0x20);
        sw = **(int **)(slot + 0x40);
        *(int *)(slot + 0x28) = sw;
        if (sw < 0)
            *(int *)(slot + 0x28) = 0x7fffffff;
        s28 = *(int *)(slot + 0x28);
        num = *(int *)(*(int *)(slot + 0x40) + 4) * 0x10000 - *(int *)(slot + 0x24);
        *(int *)(slot + 0x20) = num / s28;
        *(int *)(slot + 0x50) = *(int *)(vol + 0x74);
        *(int *)(slot + 0x54) = *(int *)(vol + 0x80);
        *(unsigned char *)(slot + 0x38) = *(unsigned char *)(vol + 0x78);
        *(unsigned char *)(slot + 0x39) = *(unsigned char *)(vol + 0x84);
        *(unsigned short *)(slot + 0x58) = (unsigned short)*(unsigned char *)(vol + 0x88);
        {
            unsigned int rv = *(unsigned int *)(vol + 0x7c);
            if (rv != 0) {
                rv = (unsigned int)iSNDrandom();
                *(char *)(slot + 0x3a) = (char)(rv % *(unsigned int *)(vol + 0x78));
            } else
                *(unsigned char *)(slot + 0x3a) = 0;
            rv = *(unsigned int *)(vol + 0x8c);
            if (rv != 0) {
                rv = (unsigned int)iSNDrandom();
                *(char *)(slot + 0x3b) = (char)(rv % *(unsigned int *)(vol + 0x84));
            } else
                *(unsigned char *)(slot + 0x3b) = 0;
        }
        *(short *)(slot + 0x3e) = *(short *)(tag + 0xe);
        *(short *)(slot + 0x60) = *(short *)(tag + 0xc);
        *(short *)(slot + 0x5e) = 0;
        iSNDcalcpitch(chan);
        field4c = *(unsigned char *)(vol + 0x4c);
        *(unsigned char *)(slot + 0x35) = b10;
        *(unsigned char *)(slot + 0x34) = field4c;
        *(unsigned char *)(slot + 10)   = *(unsigned char *)(tag + 4);
        *(short *)(slot + 8) = *(short *)tag;
        iSNDcalcvol(chan);
        if (*(signed char *)(tag + 0xb) != 0) {
            tmp = *(unsigned short *)(tag + 0x10);
            playOffset = *(short *)(tag + 0x12);
        } else {
            tmp = b7;
            tmp = tmp - 0x40;
            tmp = tmp << 8;
            tmp = (unsigned short)tmp;
            playOffset = 0;
        }
        playTag = *(unsigned short *)(tag + 0xe);
        playLevel = *(signed char *)(slot + 0x2d);
        playPitch = *(unsigned short *)(slot + 0x62);
        playResult = iSNDplatformplay(timbre, chan, playLevel, playPitch, playTag,
                                      (iSNDplatformrate[0] * *(signed char *)(slot + 0x34) *
                                       *(signed char *)(slot + 0x35)) / 16129,
                                      tmp, playOffset);
        if (playResult < 0)
            iSNDfreechan(chan);
        else
            return (int)out;
        return playResult;
    }
}

/* iSNDplaytaggedpatch @0x8010218C : THE cSNDplay entry -- parse a patch's tag stream into per-note timbres
 *   and launch each note whose range matches.  For each tag: 0xfd records the SPU sample data ptr (the
 *   "timbre" to play); 0xfe terminates a note-region header -> if the requested note(tag[5])/vel(tag[6])
 *   fall in the accumulated range (builtTimbre[1..4]) launch it via iSNDplaytaggedtimbre, then reset the
 *   timbre; tag < 0x26 sets timbre[tag] (and the parallel override header) from the tag's two values.
 *   The started voices are collected and joined into a key group; on any failure all are SNDstop'd.
 *   Ghidra body + disasm: range fields are builtTimbre +4/+8 (vel min/max), +0xc/+0x10 (note min/max);
 *   the iSNDplaytaggedtimbre return (Ghidra lost it to void-typing) is the started voice tag.
 *     7-arg call: (timbreData, tag, &builtTimbre, &header, note, vel, pitchOff). pitchOff ($s6) is the
 *     CAPTURED randrange() result of the last 0x24 field tag (0 until one is seen); the group key ($fp)
 *     is the CAPTURED iSNDfindfreekey() return.  BYTE-MATCHES the oracle (verify_asm PASS, 216 insns). */
extern int iSNDplaytaggedpatch(int bank, int tag)
{
    int           bt[0x26];                /* built timbre    @sp+0x20  */
    int           hdr[0x26];               /* override header @sp+0xB8  */
    int           started[12];             /* started voices  @sp+0x150 */
    int           cursor;                  /* tag-stream cursor @sp+0x180 (&cursor -> gettag) */
    unsigned int  g0;                      /* gettag out: tag id  @sp+0x184 (3 SCALARS, not an array */
    int           g1;                      /*             value 1 @sp+0x188  -- an array would land   */
    int           g2;                      /*             value 2 @sp+0x18C  BELOW cursor, +8 frame)  */
    int           timbreData = 0;          /* s5: last 0xfd sample-data ptr */
    int           ret        = -9;         /* s4: launch result / return value */
    int           nStarted   = 0;          /* s2 */
    int           slot       = 0;          /* s3: last written voice slot (shared single/multi) */
    int           pitchOff   = 0;          /* s6: the CAPTURED randrange() of the last 0x24 tag */
    int           vel, note;               /* s0 / s1 (lb: signed; vel FIRST -> vel=s0/note=s1) */
    int           key;                     /* fp: the CAPTURED iSNDfindfreekey() return */
    int           id, val;                 /* a1 / a2 one-shot copies of g0/g1 */
    int           i, ch;                   /* ch: getchan result, BOTH branches (a0, never crosses a call) */

    if (bank == 0)
        return -8;
    note = *(signed char *)(tag + 5);
    vel  = *(signed char *)(tag + 6);
    cursor = bank;                         /* stored (addressable) then overwritten -- both sw in oracle */
    cursor = (*(unsigned char *)(bank + 3) & 2) ? bank + 8 : bank + 4;

    iSNDresetpatch((int)bt);
    iSNDresettimbre(bt, (int)hdr);
    iSNDenteraudio();
    key = iSNDfindfreekey();

    for (;;) {
        if (iSNDgettag(&cursor, &g0, &g1, &g2) == 0)
            break;
        id = g0;                           /* ONE lw; kept in a1 for all the tag tests */
        if (id == 0xfd) {                  /* after a 0xfd tag the cursor IS the sample data */
            timbreData = cursor;
            continue;
        }
        if (id == 0xfe) {                  /* note-region complete -> launch if in range */
            if (bt[1] <= vel && vel <= bt[2] && bt[3] <= note && note <= bt[4]) {
                ret = iSNDplaytaggedtimbre(timbreData, tag, (int)bt, (int)hdr, note, vel, pitchOff);
                if (ret < 0)
                    goto fail;
                started[nStarted] = ret;
                nStarted++;
            }
            iSNDresettimbre(bt, (int)hdr);
            continue;
        }
        if (id < 0x26) {                   /* field tag -> set timbre[idx] + parallel header[idx] */
            val = g1;
            bt[id]  = val;
            hdr[id] = g2;
            if (id == 0x24)
                pitchOff = randrange(val); /* s6: fed to every later launch as arg 7 */
        }
    }
    /* the final note-region (no trailing 0xfe) */
    if (bt[1] <= vel && vel <= bt[2] && bt[3] <= note && note <= bt[4]) {
        ret = iSNDplaytaggedtimbre(timbreData, tag, (int)bt, (int)hdr, note, vel, pitchOff);
        if (ret < 0)
            goto fail;
        started[nStarted] = ret;
        nStarted++;
    }

    if (nStarted == 0)
        goto fail;                         /* nothing started: leaveaudio + return ret (-9 or the fail) */
    if (nStarted == 1) {                   /* single voice: no key group */
        ch = iSNDgetchan(started[0]);
        if (-1 < ch) {
            slot = sndgs[0x25] + ch * 100;
            *(unsigned char *)(slot + 0x37) = 0;
            *(unsigned char *)(slot + 0x36) = 0;
        }
    } else {                               /* join the started voices into the key group */
        for (i = 0; i < nStarted; i++) {
            char *gs = (char *)sndgs;      /* in-body: loop-invariant-HOISTED after the entry blez,
                                            * into a callee-saved reg (held ACROSS the getchan calls) */
            ch = iSNDgetchan(started[i]);
            if (-1 < ch) {
                slot = *(int *)(gs + 0x94) + ch * 100;
                *(unsigned char *)(slot + 0x37) = (unsigned char)key;
                *(unsigned char *)(slot + 0x36) = 0;
            }
        }
        *(unsigned char *)(slot + 0x36) = 1;   /* mark the last voice as the group end */
    }
    iSNDleaveaudio();
    return ret;

fail:
    iSNDleaveaudio();
    for (i = 0; i < nStarted; i++)         /* roll back every voice started before the failure */
        SNDstop(started[i]);
    return ret;
}
