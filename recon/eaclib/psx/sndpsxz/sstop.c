/* eaclib/psx/sndpsxz/sstop.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sstop.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7E80.  SNDstop -- stop all voices keyed on a tag.  Ghidra nfs4-f.exe.c L145138.
 */

extern int  sndgs[];
extern void iSNDenteraudio(void);                 /* sserver  */
extern void iSNDleaveaudio(void);
extern int  iSNDgetchan(unsigned int tag);        /* salloc   */
extern int  iSNDpatchkey(int chan, int outvar);   /* spatkey  */
extern void iSNDstop(unsigned int voice);         /* sdriver  */

/* SNDstop @0x800E7E80 : stop every voice patched under `tag`.  Resolves the tag to a channel, then walks
 *   its patch keys, issuing the low-level stop on each.  Returns the channel (or a negative error). */
extern int SNDstop(unsigned int tag)
{
    int chan;
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    iSNDenteraudio();
    chan = iSNDgetchan(tag);
    if (-1 < chan) {
        unsigned int v = 0xffffffff;
        while (iSNDpatchkey(chan, (int)&v) != 0)
            iSNDstop(v);
    }
    iSNDleaveaudio();
    return chan;
}
