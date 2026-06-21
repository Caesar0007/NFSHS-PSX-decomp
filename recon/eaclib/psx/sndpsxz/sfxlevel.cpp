/* eaclib/psx/sndpsxz/sfxlevel.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\sfxlevel.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x801005BC .. 0x801005E8].  Per-sound effect (reverb) send level.
 *   Ghidra nfs4-f.exe.c (sfxlevel) + disasm-v3 L<801005E8+> -- AUTHORITATIVE: Ghidra OVER-SIMPLIFIED
 *   SNDfxlevel (it dropped the send-scaling math + the /127 normalise + the 3rd call arg).
 *
 *   ⚠️ This call to iSNDplatformfxlevel is 3-ARG (chan, bus, fxon); the sealed sdriver.cpp declared it
 *   2-arg (chan, fxon) -- sdriver's IDA sig is actually (a1,a2,a3), so sdriver should gain the `bus` arg
 *   on a reconcile pass.  extern "C" links regardless; flagged in 00_current_state.md.
 */

extern "C" int sndgs[];
extern "C" int  iSNDpsxeffectvol(int left, int right);          /* spatkey */
extern "C" int  iSNDgetchan(unsigned int tag);                  /* salloc  */
extern "C" int  iSNDpatchkey(int chan, int tag);                /* spatkey */
extern "C" int  iSNDplatformfxlevel(int chan, int bus, int fxon); /* sdriver (3-arg) */
extern "C" void iSNDenteraudio(void);                           /* sserver */
extern "C" void iSNDleaveaudio(void);

extern "C" int iSNDplatformfxmasterlevel(int bus, int level);   /* @0x801005BC */
extern "C" int SNDfxlevel(int tag, int bus, int level);         /* @0x801005E8 */

/* iSNDplatformfxmasterlevel @0x801005BC : drive the SPU reverb output volume from the bus master `level`
 *   (the PSX has a single reverb, so `bus` is ignored). */
extern "C" int iSNDplatformfxmasterlevel(int bus, int level)
{
    (void)bus;
    iSNDpsxeffectvol(level * 0x102, level * 0x102);
    return 0;
}

/* SNDfxlevel @0x801005E8 : set the effect-send `level` for sound `tag` on `bus` -- for each voice, scale the
 *   requested level by the voice's per-bus send (slot[bus+0x34]) and the bus master (sndgs[bus*4+0x28]),
 *   normalise by 127, and push it to the SPU.  Returns the channel, or a negative error. */
extern "C" int SNDfxlevel(int tag, int bus, int level)
{
    int chanIdx;
    int cur[2];
    if ((char)sndgs[0xf] == 0)
        return -10;
    iSNDenteraudio();
    chanIdx = iSNDgetchan((unsigned int)tag);
    if (-1 < chanIdx) {
        cur[0] = -1;
        while (iSNDpatchkey(chanIdx, (int)cur) != 0) {
            int slot   = sndgs[0x25] + cur[0] * 100 + bus;
            int scaled = level * (int)(signed char)*(char *)(slot + 0x34);
            int fxArg;
            *(char *)(slot + 0x35) = (char)level;
            fxArg = (scaled * sndgs[bus * 4 + 0x28]) / 127;     /* @0x82061029 magic = signed /127 */
            iSNDplatformfxlevel(cur[0], bus, fxArg);
        }
    }
    iSNDleaveaudio();
    return chanIdx;
}
