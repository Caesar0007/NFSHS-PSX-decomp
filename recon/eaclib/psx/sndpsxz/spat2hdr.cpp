/* eaclib/psx/sndpsxz/spat2hdr.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\spat2hdr.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x801035B0 .. 0x801035E4].  Parse a sample's tag stream into a playback header + attribute block.
 *   Ghidra nfs4-f.exe.c (spat2hdr) + IDA sigs.  Ghidra-ism: iSNDpatchtohdr's 4th out-arg (in_a3) was dropped;
 *   iSNDgettag is the 4-arg (cursor,&id,&val,&ptr) form (Ghidra showed 2, the others adjacent on stack).
 */
extern "C" int  iSNDgettag(int *cursor, int *id, int *val, int *ptr);   /* sgettag */

extern "C" int  SNDattributessetdef(int *attr);                         /* @0x801035B0 */
extern "C" void iSNDpatchtohdr(short *sampleData, int *hdr, int *attr, int *extraOut); /* @0x801035E4 */

/* SNDattributessetdef @0x801035B0 : reset a 0xc-byte attribute block to defaults (level -1, pan 0x40,
 *   sustain 0x7f). */
extern "C" int SNDattributessetdef(int *attr)
{
    *attr = -1;
    *((unsigned char *)attr + 7)  = 0x7f;
    *((unsigned char *)attr + 8)  = 0x40;
    *((unsigned char *)attr + 6)  = 0;
    *(unsigned short *)((char *)attr + 4) = 0;
    *((unsigned char *)attr + 9)  = 0;
    *((unsigned char *)attr + 10) = 0;
    *((unsigned char *)attr + 0xb) = 0;
    return 0;
}

/* iSNDpatchtohdr @0x801035E4 : build the SPU playback header (`hdr`, magic 0x5622) + attribute block (`attr`)
 *   + extra word (`extraOut`) from the sample's tag stream (after its 4- or 8-byte prefix per flags bit 1). */
extern "C" void iSNDpatchtohdr(short *sampleData, int *hdr, int *attr, int *extraOut)
{
    short *cursor;
    int    id, val, ptr;
    SNDattributessetdef(attr);
    cursor = sampleData + 4;
    if ((*((unsigned char *)sampleData + 3) & 2) == 0)
        cursor = sampleData + 2;
    *(unsigned short *)hdr      = 0x5622;
    *((unsigned char *)hdr + 2) = 1;
    *((unsigned char *)hdr + 3) = 5;
    *extraOut = 0;
    while (iSNDgettag((int *)&cursor, &id, &val, &ptr) != 0) {
        if (id == 0x80)      *((unsigned char *)attr + 0xb) = (unsigned char)val;
        else if (id == 0x82) *((unsigned char *)hdr + 2)    = (unsigned char)val;
        else if (id == 0x84) *(unsigned short *)hdr         = (unsigned short)val;
        else if (id == 0x85) *extraOut                      = val;
        else if (id == 0x13) *((unsigned char *)attr + 9)   = (unsigned char)val;
        else if (id == 0xa)  *((unsigned char *)attr + 0xa) = (unsigned char)val;
        else if (id == 5)    *attr                          = val;
        else if (id == 6)    *((unsigned char *)attr + 6)   = (unsigned char)val;
    }
}
