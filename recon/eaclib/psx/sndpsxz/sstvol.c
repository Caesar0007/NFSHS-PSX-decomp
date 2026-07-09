/* eaclib/psx/sndpsxz/sstvol.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sstvol.obj @0x800EA0D8 */
extern int sndgs[];
extern int iSNDstreamgetstreamptr(int tag);   /* sst  */
extern int SNDvol(unsigned int tag, int vol); /* svol */
extern int SNDSTRM_vol(int tag, int vol);     /* @0x800EA0D8 */
/* SNDSTRM_vol : set a stream's volume (cached at +0x54) and apply it.
 * FLOOR (3 diffs): gcc-2.8.0 hoists `lw a0,8(v0)` into the `beqz v0` delay slot; oracle (ccpsx
 * 4.0.0) leaves nop there + emits lw after. GCC delay-slot scheduling difference, not source. */
extern int SNDSTRM_vol(int tag, int vol)
{
    int sp;
    if ((signed char)sndgs[0xf] == 0) return -10;
    sp = iSNDstreamgetstreamptr(tag);
    if (sp == 0) return -8;
    *(char *)(sp + 0x54) = (char)vol;
    SNDvol(*(unsigned int *)(sp + 8), vol);
    return 0;
}
