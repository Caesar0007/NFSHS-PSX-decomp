/* syslib/psx/libc/C46.cpp -- RECONSTRUCTED. obj C46.obj ; libc.lib. memchr @0x800FE388 (BIOS A0:0x2F).
 * BIOS trampoline; real-algorithm reconstruction (first `c` in first n bytes, or 0). */
extern "C" void *memchr(const void *s, int c, int n)   /* @0x800FE388 */
{
    const unsigned char *p = (const unsigned char *)s;
    while (n-- > 0) { if (*p == (unsigned char)c) return (void *)p; p++; }
    return (void *)0;
}
