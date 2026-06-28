/* eaclib/psx/sndpsxz/sautovol.cpp -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sautovol.obj @0x800E82D0 */
extern "C" int sndgs[];
extern "C" int  iSNDgetchan(unsigned int tag);    /* salloc  */
extern "C" int  iSNDpatchkey(int chan, int tag);  /* spatkey */
extern "C" void iSNDenteraudio(void);             /* sserver */
extern "C" void iSNDleaveaudio(void);
extern "C" void trap(unsigned int code);
extern "C" int  SNDautovol(unsigned int tag, unsigned int rate, int target);   /* @0x800E82D0 */
/* SNDautovol : ramp a sound's voices toward `target` volume over `rate` ticks (sets +0x18 target, +0x14 step). */
extern "C" int SNDautovol(unsigned int tag, unsigned int rate, int target)
{
    int ch, cur[2];
    if ((char)sndgs[0xf] == 0) return -10;
    iSNDenteraudio();
    ch = iSNDgetchan(tag);
    if (-1 < ch) {
        if ((int)rate < 1) rate = 1;
        cur[0] = -1;
        while (iSNDpatchkey(ch, (int)cur) != 0) {
            int v = sndgs[0x25] + cur[0] * 100;
            int delta = target * 0x10000 - *(int *)(v + 0x1c);
            *(int *)(v + 0x18) = target * 0x10000;
            *(int *)(v + 0x14) = delta / (int)rate;
        }
    }
    iSNDleaveaudio();
    return ch;
}
