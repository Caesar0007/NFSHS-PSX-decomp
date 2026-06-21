/* eaclib/psx/sndpsxz/s3dlow.cpp -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj s3dlow.obj @0x800E80E4 */
extern "C" int sndgs[];
extern "C" int  iSNDgetchan(unsigned int tag);          /* salloc  */
extern "C" int  iSNDpatchkey(int chan, int tag);        /* spatkey */
extern "C" void iSNDenteraudio(void);                   /* sserver */
extern "C" void iSNDleaveaudio(void);
extern "C" int  iSNDplatform3dpos(int chan, unsigned int pos);   /* s3dpos */
extern "C" int  SND3dpos(unsigned int tag, unsigned int pos, int y);   /* @0x800E80E4 */
/* SND3dpos : set the 3D pan position on every voice of `tag`. */
extern "C" int SND3dpos(unsigned int tag, unsigned int pos, int y)
{
    int ch, cur[2];
    (void)y;
    if ((char)sndgs[0xf] == 0) return -10;
    iSNDenteraudio();
    ch = iSNDgetchan(tag);
    if (-1 < ch) {
        cur[0] = -1;
        while (iSNDpatchkey(ch, (int)cur) != 0)
            iSNDplatform3dpos(cur[0], pos & 0xffff);
    }
    iSNDleaveaudio();
    return ch;
}
