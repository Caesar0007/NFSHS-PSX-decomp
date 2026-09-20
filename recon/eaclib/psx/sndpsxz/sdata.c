/* eaclib/psx/sndpsxz/sdata.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdata.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800FE594.  iSNDplatformfree -- release a bank's downloaded SPU data (thin wrapper over the SPU
 *   allocator's free).  Ghidra nfs4-f.exe.c (sdata).
 */

/* sdata.obj .bss 0x80147860..0x80147914 : `sndgs`, the sound system's global state (180 B).  Owner proven by retail link
 * order (2026-09-20): the run sits between callback.obj's mutexbuf [361] and salloc.obj's sndchanreserved [369], so
 * ssysinit.obj [285] cannot own it; sdata.obj [365] is EA's sound-library DATA module (the PC build's sdata.obj is 20
 * data globals and no function).  The interior labels are the views other TUs address directly (see ssysinit.c).
 * OPEN: the slot 365..366 cannot tell whether iSNDplatformfree below is sdata.obj's or sdasync.obj's lone survivor. */
__asm__("\t.globl\tsndgs\n\t.globl\tgSndState\n\t.globl\tD_80147871\n"
        "\t.globl\tD_80147898\n\t.globl\tDAT_801478f4\n\t.globl\tiSNDplatformrate\n"
        "\t.section\t.bss\n\t.align\t2\n"
        "sndgs:\n"
        "gSndState:\n\t.space\t0x11\n"
        "D_80147871:\n\t.space\t0x27\n"
        "D_80147898:\n\t.space\t0x5c\n"
        "DAT_801478f4:\n\t.space\t0xc\n"
        "iSNDplatformrate:\n\t.space\t0x14\n\t.text");

extern void iSNDpsxfree(int ptr);   /* sdmemman */

extern void iSNDplatformfree(int ptr);   /* @0x800FE594 */

/* iSNDplatformfree @0x800FE594 : free the SPU block at `ptr`. */
extern void iSNDplatformfree(int ptr)
{
    iSNDpsxfree(ptr);
}
