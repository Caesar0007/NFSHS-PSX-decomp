/* eaclib/psx/sndpsxz/sstvol.cpp -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sstvol.obj @0x800EA0D8 */
extern "C" int sndgs[];
extern "C" int iSNDstreamgetstreamptr(int tag);   /* sst  */
extern "C" int SNDvol(unsigned int tag, int vol); /* svol */
extern "C" int SNDSTRM_vol(int tag, int vol);     /* @0x800EA0D8 */
/* SNDSTRM_vol : set a stream's volume (cached at +0x54) and apply it. */
extern "C" int SNDSTRM_vol(int tag, int vol)
{
    int sp;
    if ((signed char)sndgs[0xf] == 0) return -10;
    sp = iSNDstreamgetstreamptr(tag);
    if (sp == 0) return -8;
    *(char *)(sp + 0x54) = (char)vol;
    SNDvol(*(unsigned int *)(sp + 8), vol);
    return 0;
}
