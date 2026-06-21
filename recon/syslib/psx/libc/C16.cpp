/* syslib/psx/libc/C16.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\C16.obj == libc.lib(C16.OBJ).  1 fn @0x800EB100 : atoi.
 *   BIOS trampoline (A0:0x10) -> real C behaviour + breadcrumb.
 */
extern "C" int atoi(const char *s)   /* @0x800EB100  BIOS A0:0x10 */
{
    int sign = 1, v = 0;
    while (*s == ' ' || *s == '\t' || *s == '\n') ++s;
    if (*s == '-') { sign = -1; ++s; } else if (*s == '+') ++s;
    while (*s >= '0' && *s <= '9') v = v * 10 + (*s++ - '0');
    return sign * v;
}
