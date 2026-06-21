/* syslib/psx/libc/C37.cpp -- RECONSTRUCTED. obj C37.obj ; libc.lib. toupper @0x8010907C (BIOS A0:0x25).
 * BIOS trampoline; real-algorithm reconstruction. */
extern "C" int toupper(int c)   /* @0x8010907C */
{
    return (c >= 'a' && c <= 'z') ? c - 0x20 : c;
}
