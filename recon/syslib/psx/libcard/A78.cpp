/* syslib/psx/libcard/A78.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(A78.OBJ): _card_write -- write one 128-byte sector (`block`) of the card on
 *   `chan` from `buf`.  Thin tail-call thunk into the PSX BIOS B0 jump table, entry 0x4E
 *   (write_card_sector).  See C171.cpp for the thunk convention. */

/* @0x8010A0A0 : _card_write -- BIOS B0:0x4E thunk. */
extern "C" int _card_write(int chan, int block, unsigned char *buf)
{
#if defined(__mips__)
    __asm__ volatile("li $10,0xB0\n\t"
                     "jr $10\n\t"
                     "li $9,0x4E\n\t");
    return 0;                       /* tail-call: control never returns here */
#else
    (void)chan; (void)block; (void)buf;
    return 0;                       /* BIOS unavailable on host */
#endif
}
