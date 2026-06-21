/* syslib/psx/libc/C31.cpp -- RECONSTRUCTED. obj C31.obj ; libc.lib. strrchr @0x80103590 (BIOS A0:0x1C).
 * BIOS trampoline; real-algorithm reconstruction (returns ptr to last `c`, or 0). */
extern "C" char *strrchr(const char *s, int c)   /* @0x80103590 */
{
    const char *last = (const char *)0;
    for (;; s++) {
        if (*s == (char)c) last = s;
        if (*s == 0) return (char *)last;
    }
}
