/* syslib/psx/libc/C38.cpp -- RECONSTRUCTED. obj C38.obj ; libc.lib. tolower @0x801035A0 (BIOS A0:0x26).
 * BIOS trampoline; real-algorithm reconstruction. */
extern "C" int tolower(int c)   /* @0x801035A0 */
{
    return (c >= 'A' && c <= 'Z') ? c + 0x20 : c;
}
