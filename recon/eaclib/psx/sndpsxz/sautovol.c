/* eaclib/psx/sndpsxz/sautovol.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sautovol.obj @0x800E82D0 */
extern int sndgs[];
extern int  iSNDgetchan(unsigned int tag);    /* salloc  */
extern int  iSNDpatchkey(int chan, int tag);  /* spatkey */
extern void iSNDenteraudio(void);             /* sserver */
extern void iSNDleaveaudio(void);
extern void trap(unsigned int code);
extern int  SNDautovol(unsigned int tag, unsigned int rate, int target);   /* @0x800E82D0 */
/* SNDautovol : ramp a sound's voices toward `target` volume over `rate` ticks (sets +0x18 target, +0x14 step). */
extern int SNDautovol(unsigned int tag, unsigned int rate, int target)
{
    int ch, cur[2];
    if ((signed char)sndgs[0xf] == 0) return -10;  /* signed -> lb (ccpsx char is unsigned) */
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
