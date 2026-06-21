/* eaclib/psx/sndpsxz/splysdef.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\splysdef.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   1 fn @0x800E6834 (80 bytes): SNDplaysetdef -- initialise an SND "play descriptor" to defaults.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub/thunk.  C-linkage.  Part of the EA SND runtime.
 *
 *   The descriptor (20 bytes) drives a one-shot sample play; its default fields:
 *     +0x00 s32 handle  = -1        +0x05 s8  decay   = 0x3C
 *     +0x04 s8  ?       = -1        +0x06/08/0A s8 volume = 0x7F (L/.../R)
 *     +0x07/09    s8  pan = 0x40 (centre)     +0x0B s8 = 0
 *     +0x0C/0E   s16 pitch = 0x1000 (== 1.0)  +0x10/12 s16 = 0
 */

extern "C" void SNDplaysetdef(void *def)   /* @0x800E6834 */
{
    char *d = (char *)def;
    *(int *)(d + 0x00)   = -1;
    *(char *)(d + 0x04)  = (char)-1;
    *(char *)(d + 0x05)  = 0x3C;
    *(short *)(d + 0x0C) = 0x1000;
    *(short *)(d + 0x0E) = 0x1000;
    *(char *)(d + 0x06)  = 0x7F;
    *(char *)(d + 0x08)  = 0x7F;
    *(char *)(d + 0x0A)  = 0x7F;
    *(char *)(d + 0x07)  = 0x40;
    *(char *)(d + 0x09)  = 0x40;
    *(char *)(d + 0x0B)  = 0;
    *(short *)(d + 0x10) = 0;
    *(short *)(d + 0x12) = 0;
}
