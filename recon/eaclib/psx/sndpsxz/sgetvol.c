/* eaclib/psx/sndpsxz/sgetvol.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sgetvol.obj @0x80102810 */
extern int sndgs[];
extern int  iSNDgetchan(unsigned int tag);    /* salloc  */
extern void iSNDenteraudio(void);             /* sserver */
extern void iSNDleaveaudio(void);

extern int SNDgetvol(unsigned int tag);       /* @0x80102810 */

/* SNDgetvol @0x80102810 : return the current SPU volume (slot +0x2d) of sound `tag`, or a negative error. */
extern int SNDgetvol(unsigned int tag)
{
    int ch;
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    iSNDenteraudio();
    ch = iSNDgetchan(tag);
    if (ch < 0) {                                   /* leaveaudio is called per-path (oracle does not tail-merge) */
        iSNDleaveaudio();
        return -8;
    }
    iSNDleaveaudio();                               /* oracle: leaveaudio BEFORE reading the +0x2d vol */
    return (int)*(signed char *)(ch * 100 + sndgs[0x25] + 0x2d);   /* +0x2d cached vol read signed (lb) */
}
