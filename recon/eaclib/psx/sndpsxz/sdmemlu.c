/* eaclib/psx/sndpsxz/sdmemlu.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdmemlu.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7CEC.  SNDmemlargestunused -- find the largest free SPU-RAM gap; returns its byte size and
 *   writes its byte start to *out (both << 6 from block units).  Ghidra nfs4-f.exe.c (sdmemlu).
 *
 *   SPLIT-STORAGE FIX (wave-22 a1): a prior pass modeled snd_spu_engine_ver/block_total/reverb_mode/
 *   alloc_count as ordinary standalone extern/BSS globals OWNED by this TU. That was a genuine aliasing
 *   bug: the oracle proves (this fn + iSNDpsxmemconstrain/iSNDpsxmalloc/iSNDpsxfree in sdmemman.c +
 *   iSNDinit in slib.c + iSNDpsxfxinit in sdfx.cpp -- five independent raw-disasm cross-checks, all
 *   agreeing on the same offsets) that these fields are NOT their own linked objects: they are FIXED
 *   DISPLACEMENTS off the single `sndpd` voice/queue-state blob (@0x80147918), materialized via ONE
 *   lui/addiu(%hi/%lo(sndpd)) and read/written sndpd-relative:
 *       sndpd+0x518 = alloc_count (u16)   sndpd+0x51A = engine_ver (u16)
 *       sndpd+0x51C = block_total (u16)   sndpd+0x51E = reverb_mode (u16)
 *       sndpd+0x520..= {block:u16,size:u16}[alloc_count]  free-list table (4-byte stride)
 *   (SNDmemlargestunused's own oracle nails this directly: `lhu v0,0x518(sndpd)` for alloc_count,
 *   `lhu v0,0x51E(sndpd)` for reverb_mode, table walk from `addiu a2,sndpd,0x520`, and the post-loop tail
 *   re-materializes a FRESH symbol `D_80147E34` == sndpd+0x51C -- i.e. block_total's own address doubles
 *   as the free-list's "virtual entry[-1]" {block=block_total, size=reverb_mode} used to bound the first
 *   gap. That aliasing is REQUIRED for the algorithm to be correct, not just an address coincidence.)
 *   On a real link, standalone globals do NOT share storage with sndpd -- iSNDinit's writes (already
 *   sndpd-relative in slib.c, see its DAT_80147e32/e34) would never be observed by this fn's reads, and
 *   this fn's own pointer-arithmetic table walk ((&snd_spu_block_total)[i*2] etc) would run off into
 *   unrelated BSS instead of the real alloc table. Fixed by aliasing onto `sndpd` here (matching
 *   sdpacket.c/sdma.c/slib.c's established per-file macro-view convention -- no shared header needed,
 *   every consumer just redeclares `extern unsigned char sndpd[]` + its own local DAT_<va> macros).
 *   sdmemman.c's iSNDpsxmalloc/iSNDpsxfree and sdfx.cpp's iSNDpsxfxinit (the OTHER readers/writers of
 *   this same storage) were updated identically in the same commit so every access genuinely aliases.
 */

extern unsigned char sndpd[];   /* EA sound-driver state base @0x80147918 (shared, sdma.c/sdpacket.c/slib.c) */

extern int SNDmemlargestunused(int *out);   /* @0x800E7CEC */

/* SNDmemlargestunused @0x800E7CEC : scan the gaps between SPU allocations for the biggest, in 64-byte
 *   blocks; report start (*out) and size, both converted to bytes (<<6).
 *   MATCH: materialize `base = &sndpd` ONCE (oracle $v1) and reach every field via a FIXED displacement
 *   off it (same lever as sdpacket.c's `voice`/`base` locals) -- per-site `sndpd+CONST` macros each
 *   re-materialized their OWN independent %hi/%lo(sndpd+CONST) symbol instead of sharing one base
 *   register, which is why the first cut of this fix still near-missed. */
extern int SNDmemlargestunused(int *out)
{
    int             best = 0, gap, i;
    unsigned short  count;
    unsigned short *tbl;
    unsigned char  *base = sndpd;

    *out = 0x41;
    count = *(unsigned short *)(base + 0x518);        /* snd_spu_alloc_count */
    if (count == 0) {
        best = (int)*(unsigned short *)(base + 0x51E) - 0x41;   /* snd_spu_reverb_mode */
    } else {
        tbl = (unsigned short *)(base + 0x520);        /* {block,size}[] free-list, 4-byte stride */
        i = 0;
        /* MATCH: the oracle's entry guard (0 < count) tests the CACHED initial load of `count`, but the
         * loop-back test rereads 0x518 fresh from memory each iteration -- reproduce that asymmetry
         * explicitly rather than looping on the cached local both times. */
        if (i < (int)(unsigned)count)
        do {
            if (i == 0) {
                if (best < (int)(*tbl - 0x41))
                    best = *tbl - 0x41;
            } else {
                /* virtual entry[i-1]: block_total(base+0x51C)/reverb_mode(base+0x51E) double as the
                 * free-list's own header slot, one stride before the real table (see file banner). */
                unsigned short *prev = (unsigned short *)(base + 0x51C) + i * 2;
                gap = (int)(unsigned)*tbl -
                      ((int)(unsigned)prev[0] + (int)(unsigned)prev[1]);
                if (best < gap) {
                    *out = (int)(unsigned)prev[0] + (int)(unsigned)prev[1];
                    best = gap;
                }
            }
            i++;
            tbl = tbl + 2;
        } while (i < (int)(unsigned)*(unsigned short *)(base + 0x518));   /* re-read count fresh */
        {
            unsigned short *prev = (unsigned short *)(base + 0x51C) + i * 2;
            gap = (int)(unsigned)*(unsigned short *)(base + 0x51E) -
                  ((int)(unsigned)prev[0] + (int)(unsigned)prev[1]);
            if (best < gap) {
                *out = (int)(unsigned)prev[0] + (int)(unsigned)prev[1];
                best = gap;
            }
        }
    }
    *out = *out << 6;
    return best << 6;
}
