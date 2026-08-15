/* eaclib/psx/sndpsxz/sstvol.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sstvol.obj @0x800EA0D8 */
extern int sndgs[];
extern int iSNDstreamgetstreamptr(int tag);   /* sst  */
extern int SNDvol(unsigned int tag, int vol); /* svol */
extern int SNDSTRM_vol(int tag, int vol);     /* @0x800EA0D8 */
/* SNDSTRM_vol : set a stream's volume (cached at +0x54) and apply it.
 * MATCH: the play-handle read is volatile, so an invalid stream cannot speculate a null-based load
 * into the `beqz` delay slot; this also reproduces the oracle's protective nop. */
extern int SNDSTRM_vol(int tag, int vol)
{
    int sp;
    if ((signed char)sndgs[0xf] == 0) return -10;
    sp = iSNDstreamgetstreamptr(tag);
    if (sp == 0) return -8;
    *(char *)(sp + 0x54) = (char)vol;
    SNDvol(*(volatile unsigned int *)(sp + 8), vol);
    return 0;
}
