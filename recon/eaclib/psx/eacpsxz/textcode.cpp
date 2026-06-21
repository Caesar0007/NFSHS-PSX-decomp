/* eaclib/psx/eacpsxz/textcode.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\textcode.obj ; EACPSXZ.LIB.  1 fn @0x801069AC.  decodeansi -- next ANSI char from a
 *   cursor (advances it).  Ghidra nfs4-f.exe.c + IDA sig (1-arg cursor).
 */
extern "C" int decodeansi(unsigned char **cursor);   /* @0x801069AC */
extern "C" int decodeansi(unsigned char **cursor)
{
    unsigned char c = **cursor;
    *cursor = *cursor + 1;
    return (int)(unsigned int)c;
}
