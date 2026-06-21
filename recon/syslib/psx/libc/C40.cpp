/* syslib/psx/libc/C40.cpp -- RECONSTRUCTED. obj C40.obj ; libc.lib. bzero @0x8010A540 (BIOS A0:0x28).
 * BIOS trampoline; real-algorithm reconstruction (zero n bytes). */
extern "C" void bzero(void *s, int n)   /* @0x8010A540 */
{
    char *p = (char *)s;
    while (n-- > 0) *p++ = 0;
}
