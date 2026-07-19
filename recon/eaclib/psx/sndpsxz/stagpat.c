/* eaclib/psx/sndpsxz/stagpat.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 8/8 ***
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

extern int          sndgs[];
extern signed char  snddefaultenvelope;          /* default envelope table (sclcptch/data-mat) */
extern char         DAT_801371cc;                /* rolling key-group counter */
char DAT_801371cc;                               /* def (owning TU; @0x801371cc image-verified zero) */

extern int  iSNDgettag(int *cursor, unsigned int *outId, int *outVal, int *outPtr);  /* sgettag (4-arg) */
extern int  iSNDplatformresolve(int resolv, int patch_idx, int scratch);  /* sdresolv */
extern int  iSNDplatformremove(int resolv, int *patch_idx);               /* sdresolv */
extern int  randrange(int range);                                         /* srrange  */
extern int  iSNDrandom(void);                                             /* srandom  */
extern int  iSNDallocchan(unsigned int priority, int numChannels, int a2, unsigned int *out); /* salloc */
extern int  iSNDfreechan(int chan);                                       /* salloc   */
extern int  iSNDcalcpitch(int note);                                      /* sclcptch */
extern unsigned int iSNDcalcvol(int chan);                                /* spatkey  */
extern int  iSNDplatformplay(int chan, int voice, int level, int pitch, int a5, int fx, int volAngle); /* sdplapat (now 7-arg, sealed) */
extern void trap(unsigned int code);                                      /* compiler div-by-zero break */

extern void iSNDresetpatch(int patch);                          /* @0x80101ABC */
extern unsigned char *iSNDresettimbre(int *t, int buf);         /* @0x80101AC4 */
extern int  iSNDresolveheader(int *hdr, int *out);              /* @0x80101B7C */
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
extern int iSNDresolveheader(int *hdr, int *out)
{
    int r;
    *(int *)((int)hdr + 0x48) = *(int *)((int)out + 0x48) + *(int *)((int)hdr + 0x48);
    *(int *)((int)hdr + 0x54) = *(int *)((int)out + 0x54) + *(int *)((int)hdr + 0x54);
    *(int *)((int)hdr + 0x5c) = *(int *)((int)out + 0x5c) + *(int *)((int)hdr + 0x5c);
    *(int *)((int)hdr + 0x74) = *(int *)((int)out + 0x74) + *(int *)((int)hdr + 0x74);
    /* near-miss floor (4 diffs, 32==32 insns): the +0x80 accumulation feeds `r` (returned); ours
     * hoists the hdr+0x80 load ahead of the +0x74 store + colors the commutative addu operands
     * opposite the oracle. Tried: out-first operand order (regressed, 6 diffs -- hdr-first is
     * correct), direct-store-then-reread (regressed, +2 insns), an interleaved `guard` temp for
     * the +100 read (no change). Pure gcc-2.8.0 scheduling/coloring tie-break across the block
     * boundary; not source-reachable. Permuter multi-basin candidate. */
    r = *(int *)((int)hdr + 0x80) + *(int *)((int)out + 0x80);
    *(int *)((int)hdr + 0x80) = r;
    if (*(int *)((int)hdr + 100) != 0) {
        r = *(int *)((int)out + 100) + *(int *)((int)hdr + 100);
        *(int *)((int)hdr + 100) = r;
    }
    return r;
}

/* iSNDfindfreekey @0x80101BFC : advance the rolling key-group counter (DAT_801371cc) to a value not
 *   currently owned by any held channel; RETURNS the chosen key (oracle: `lbu v0,key; jr ra` --
 *   iSNDplaytaggedpatch captures it in $fp and stamps it into every started voice's +0x37). */
extern int iSNDfindfreekey(void)
{
    int   i, count;
    unsigned char key;
    unsigned char *kp;
    char *gs;
    char *slot;
    kp = (unsigned char *)&DAT_801371cc;          /* one base reg for the 4 counter accesses */
top:
    *kp = *kp + 1;                                /* lbu/addiu/sb; the == 0 test reuses the CSE'd value */
    if (*kp == 0)                                 /* skip 0 (the "no group" sentinel) */
        *kp = *kp + 1;
    i = 0;
    gs = (char *)sndgs;                           /* one la base for the +0x11 / +0x94 displacements */
    if (*(unsigned char *)(gs + 0x11) == 0)
        goto done;
    count = *(unsigned char *)(gs + 0x11);        /* CSE of the test's load -> the addu copy */
    key   = *kp;
    slot  = *(char **)(gs + 0x94);
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
    return DAT_801371cc;
    /* near-miss floor (20 diffs, 36==36 insns): oracle addresses DAT_801371cc DIRECTLY at each access
     * (`lbu/sb r,%lo(sym)(base)` -- the %lo offset IS the displacement, no separate `la`), while our
     * `kp` pointer-variable materializes the FULL address first (`lui;addiu`) then dereferences at
     * offset 0 -- one extra insn per access, cascading a v0/v1/a1/a2 register-coloring swap through
     * the whole function. Tried: dropping `kp` and accessing `DAT_801371cc` as a bare global at each
     * site -- this makes it eligible for `-G4` gp-relative BSS placement (a 1-byte `.lcomm`), which
     * REGRESSED to a `0(gp)` load the oracle doesn't have (20->22); adding
     * `__attribute__((section(".bss")))` to force it out of `.sbss` had NO effect (confirming the
     * known READ+WRITE gp-rel assembler floor -- the section lever only fixes SINGLE-ACCESS globals,
     * see reference_asm_pattern_catalog.md Row G/I-addendum). Reverted both; kp-pointer form is the
     * best available (20 diffs). Permuter multi-basin candidate. */
}

/* iSNDresolvetaggedpatch @0x801024EC : walk a bank's tag stream and resolve its SPU sample data (tag 0xfd
 *   = platform resolve), marking the bank resolved (+3 |= 1).  Returns -1 / resolve result. */
extern int iSNDresolvetaggedpatch(int bank, int patch_idx, int scratch)
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
extern int iSNDremovetaggedpatch(int bank, int *patch_idx)
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
extern int iSNDplaytaggedtimbre(int timbre, int tag, int vol, int header,
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
                *(char *)(slot + 0x3a) = (char)(rv % *(unsigned int *)(vol + 0x78));
            }
            rv = *(unsigned int *)(vol + 0x8c);
            if (rv == 0) {
                *(unsigned char *)(slot + 0x3b) = 0;
            } else {
                iSNDrandom();
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
