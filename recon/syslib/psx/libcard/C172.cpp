/* syslib/psx/libcard/C172.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(C172.OBJ): _card_load -- kick the asynchronous "load directory" operation for
 *   the card on channel `chan`.  Thin tail-call thunk into the PSX BIOS A0 jump table, entry 0xAC
 *   (_card_load / _card_async_load_directory).  See C171.cpp for the thunk convention. */

/* @0x80109D60 : _card_load -- BIOS A0:0xAC thunk. */
extern "C" int _card_load(int chan)
{
#if defined(__mips__)
    __asm__ volatile("li $10,0xA0\n\t"
                     "jr $10\n\t"
                     "li $9,0xAC\n\t");
    return 0;                       /* tail-call: control never returns here */
#else
    (void)chan;
    return 0;                       /* BIOS unavailable on host */
#endif
}
