/* eaclib/psx/sndpsxz/s3dlow.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj s3dlow.obj @0x800E80E4 */
extern int sndgs[];
extern int  iSNDgetchan(unsigned int tag);          /* salloc  */
extern int  iSNDpatchkey(int chan, int tag);        /* spatkey */
extern void iSNDenteraudio(void);                   /* sserver */
extern void iSNDleaveaudio(void);
extern int  iSNDplatform3dpos(int chan, unsigned int pos);   /* s3dpos */
extern int  SND3dpos(unsigned int tag, unsigned int pos, int y);   /* @0x800E80E4 */
/* SND3dpos : set the 3D pan position on every voice of `tag`. */
extern int SND3dpos(unsigned int tag, unsigned int pos, int y)
{
    int ch, cur[2];
    (void)y;
    if ((signed char)sndgs[0xf] == 0) return -10;
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
