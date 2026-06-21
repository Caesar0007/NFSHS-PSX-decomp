/* syslib/psx/libc/C30.cpp -- RECONSTRUCTED. obj C30.obj ; libc.lib. strchr @0x800F6214 (BIOS A0:0x1B).
 * BIOS trampoline; real-algorithm reconstruction (returns ptr to first `c`, or to the NUL if c==0, else 0). */
extern "C" char *strchr(const char *s, int c)   /* @0x800F6214 */
{
    for (;; s++) {
        if (*s == (char)c) return (char *)s;
        if (*s == 0) return (char *)0;
    }
}
