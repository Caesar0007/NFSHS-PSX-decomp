/* eaclib/psx/sndpsxz/spat2hdr.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\spat2hdr.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x801035B0 .. 0x801035E4].  Parse a sample's tag stream into a playback header + attribute block.
 *   Ghidra nfs4-f.exe.c (spat2hdr) + IDA sigs.  Ghidra-ism: iSNDpatchtohdr's 4th out-arg (in_a3) was dropped;
 *   iSNDgettag is the 4-arg (cursor,&id,&val,&ptr) form (Ghidra showed 2, the others adjacent on stack).
 */
#include "spat2hdr.h"
#include "sgettag.h"

/* SNDattributessetdef @0x801035B0 : reset a 0xc-byte attribute block to defaults (level -1, pan 0x40,
 *   sustain 0x7f). */
int SNDattributessetdef(SndPatchAttributeBlock *attr)
{
    attr->patch_id = -1;
    attr->patch_volume = 0x7f;
    attr->pan = 0x40;
    attr->velocity = 0;
    attr->base_detune = 0;
    attr->playback_factor34 = 0;
    attr->envelope_detune = 0;
        attr->use3dpos = 0;
    return 0;
}

/* iSNDpatchtohdr @0x801035E4 : build the `SNDSAMPLEFORMAT` output (`format`, default word 0x5622) + attribute block (`attr`)
 *   + extra word (`extraOut`) from the sample's tag stream (after its 4- or 8-byte prefix per flags bit 1). */
int iSNDpatchtohdr(unsigned char *sampleData, SNDSAMPLEFORMAT *format, SndPatchAttributeBlock *attr, int *extraOut)
{
    unsigned char *cursor;
    unsigned int id;
    int val;
    unsigned char *ptr;
    SNDattributessetdef(attr);
    /* oracle stores sampleData as a default (`sw s0`), computes s0+8 in the bnez delay slot, s0+4 on
     * fall-through -> a 3-way init + if/else, NOT `x=s0+8; if(!flag)x=s0+4`. */
    cursor = sampleData;
    if ((sampleData[3] & 2) != 0)
        cursor = sampleData + 8;
    else
        cursor = sampleData + 4;
    format->samplerate = 0x5622;
    format->channels = 1;
    format->samplerep = 5;
    *extraOut = 0;
    while (iSNDgettag(&cursor, &id, &val, &ptr)) {
        if (id == 0x80)      attr->use3dpos = (unsigned char)val;
        else if (id == 0x82) format->channels    = (unsigned char)val;
        else if (id == 0x84) format->samplerate = (unsigned short)val;
        else if (id == 0x85) *extraOut                      = val;
        else if (id == 0x13) attr->playback_factor34 = (unsigned char)val;
        else if (id == 0xa)  attr->envelope_detune = (unsigned char)val;
        else if (id == 5)    attr->patch_id                 = val;
        else if (id == 6)    attr->velocity                 = (unsigned char)val;
    }
    return 0;   /* oracle: `addu v0,zero,zero` before jr ra (void->int, §3.2) */
}
