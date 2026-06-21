/* eaclib/psx/sndpsxz/sdmemlu.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdmemlu.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7CEC.  SNDmemlargestunused -- find the largest free SPU-RAM gap; returns its byte size and
 *   writes its byte start to *out (both << 6 from block units).  Ghidra nfs4-f.exe.c (sdmemlu).
 *   Same SPU alloc table as sdmemman: snd_spu_alloc_count entries of {block,size} @DAT_80147e38.
 */

extern "C" unsigned short snd_spu_reverb_mode, snd_spu_block_total, snd_spu_alloc_count;
unsigned short snd_spu_reverb_mode, snd_spu_block_total, snd_spu_alloc_count;  /* defs (owning TU; BSS) */
extern "C" unsigned short DAT_80147e38;       /* {block,size}[] SPU alloc table */

extern "C" int SNDmemlargestunused(int *out);   /* @0x800E7CEC */

/* SNDmemlargestunused @0x800E7CEC : scan the gaps between SPU allocations for the biggest, in 64-byte
 *   blocks; report start (*out) and size, both converted to bytes (<<6). */
extern "C" int SNDmemlargestunused(int *out)
{
    int             best = 0, gap, i;
    unsigned short *e;

    *out = 0x41;
    if (snd_spu_alloc_count == 0) {
        best = (int)snd_spu_reverb_mode - 0x41;
    } else {
        i = 0;
        e = &DAT_80147e38;
        do {
            if (i == 0) {
                if (best < (int)(*e - 0x41))
                    best = *e - 0x41;
            } else {
                gap = (int)(unsigned)*e -
                      ((int)(unsigned)(&snd_spu_block_total)[i * 2] + (int)(unsigned)(&snd_spu_reverb_mode)[i * 2]);
                if (best < gap) {
                    *out = (int)(unsigned)(&snd_spu_block_total)[i * 2] + (int)(unsigned)(&snd_spu_reverb_mode)[i * 2];
                    best = gap;
                }
            }
            i++;
            e = e + 2;
        } while (i < (int)(unsigned)snd_spu_alloc_count);
        gap = (int)(unsigned)snd_spu_reverb_mode -
              ((int)(unsigned)(&snd_spu_block_total)[i * 2] + (int)(unsigned)(&snd_spu_reverb_mode)[i * 2]);
        if (best < gap) {
            *out = (int)(unsigned)(&snd_spu_block_total)[i * 2] + (int)(unsigned)(&snd_spu_reverb_mode)[i * 2];
            best = gap;
        }
    }
    *out = *out << 6;
    return best << 6;
}
