/* eaclib/psx/sndpsxz/sgetvol.cpp -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sgetvol.obj @0x80102810 */
extern "C" int sndgs[];
extern "C" int  iSNDgetchan(unsigned int tag);    /* salloc  */
extern "C" void iSNDenteraudio(void);             /* sserver */
extern "C" void iSNDleaveaudio(void);

extern "C" int SNDgetvol(unsigned int tag);       /* @0x80102810 */

/* SNDgetvol @0x80102810 : return the current SPU volume (slot +0x2d) of sound `tag`, or a negative error. */
extern "C" int SNDgetvol(unsigned int tag)
{
    int ch;
    if ((char)sndgs[0xf] == 0)
        return -10;
    iSNDenteraudio();
    ch = iSNDgetchan(tag);
    iSNDleaveaudio();
    if (ch < 0)
        return -8;
    return (int)*(char *)(ch * 100 + sndgs[0x25] + 0x2d);
}
